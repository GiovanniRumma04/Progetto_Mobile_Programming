import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:gestore_spese/Model/ListaSpese.dart';
import 'package:gestore_spese/Model/Prodotto.dart';
import 'package:gestore_spese/Model/Spesa.dart';
import 'package:gestore_spese/View/SpesaView.dart';

import 'Categoria.dart';
import 'DatabaseHelper.dart';

class GestoreApp extends ChangeNotifier {
  List<Prodotto> prodotti = [];
  List<Categoria> categorie = [];
  List<ListaSpese> tutteLeListe = [];
  late int indiceCategoria;
  List<Spesa> spesa = [];

  GestoreApp(){
    getCategorie();
    getProdotti(categorie);
    getListe(prodotti);
  }

  void addSpesa(Spesa sIn) {
    spesa.removeWhere((s)=> sIn.p.nomeprodotto ==s.p.nomeprodotto);
    spesa.add(sIn);
    print(spesa);
    notifyListeners();
  }

  void aggiungiSpeseNellaLista(ListaSpese ls){

    if(spesa.isNotEmpty) {
      ls.aggiungiLista(spesa);
      tutteLeListe.add(ls);
      DatabaseHelper.instance.insertLista(ls);
    }
    spesa.removeRange(0, spesa.length);
    notifyListeners();
  }

  void creaProd(Prodotto p) {
    prodotti.add(p);
    DatabaseHelper.instance.insertProdotto(p);
    notifyListeners();
  }

  void creaCategoria(Categoria c) {
    categorie.add(c);
    DatabaseHelper.instance.insertCategoria(c);
    notifyListeners();
  }

  void CreaLista(ListaSpese ls) {
    tutteLeListe.add(ls);
    notifyListeners();
  }

  void eliminaLista(ListaSpese l) {
    tutteLeListe.remove(l);
    DatabaseHelper.instance.cancellaLista(l);
    notifyListeners();
  }

  void updateProductAndExpenses(Prodotto updatedProduct, int updatedQuantita) {

    for (var i = 0; i < prodotti.length; i++) {
      if (prodotti[i].nomeprodotto == updatedProduct.nomeprodotto) {
        Prodotto p = prodotti[i];
        p = updatedProduct;
      }
    }

    for (var lista in tutteLeListe) {
      double newTotal = 0.0;
      for (var spesa in lista.lista) {
        if (spesa.p.nomeprodotto == updatedProduct.nomeprodotto) {
          spesa.p = updatedProduct;
          spesa.quantita = updatedQuantita;
        }
        newTotal += spesa.p.prezzo * spesa.quantita;
      }
      lista.spesaTotale = newTotal;
    }
    notifyListeners();
  }

  void deleteExpense(int listIndex, int expenseIndex) {
    tutteLeListe[listIndex].lista.removeAt(expenseIndex);

    double newTotal = 0.0;
    for (var spesa in tutteLeListe[listIndex].lista) {
      newTotal += spesa.p.prezzo * spesa.quantita;
    }
    tutteLeListe[listIndex].spesaTotale = newTotal;

    notifyListeners();
  }

  Future<void> getCategorie() async{
    final db = await DatabaseHelper.instance.database;

    final List<Map<String, dynamic>> result = await db.rawQuery(
        '''
      SELECT categoria_nome, COUNT(*) AS numProdotti
      FROM prodotti
      GROUP BY categoria_nome;
      '''
    );

    for (var occorrenza in result){
      categorie.add(Categoria(occorrenza['nome']));
    }
  }

  Future<void> getProdotti(List<Categoria> l) async{
    final db = await DatabaseHelper.instance.database;

    final List<Map<String, dynamic>> result = await db.query('prodotti');

    for ( Map<String, dynamic> occorrenza in result){
      for (Categoria c in l) {
        if (c.nomeCategoria == occorrenza['categoria_nome']) {
          final newProd = Prodotto(
              occorrenza['nome'],
              occorrenza['prezzo'],
              c,
              occorrenza['note']
          );
          prodotti.add(newProd);
        }
      }
    }
  }

  Future<void> getListe(List<Prodotto> p) async{
    final db = await DatabaseHelper.instance.database;

    final liste = await db.query('liste');

    for (Map<String, dynamic> occorrenza in liste){
      final spese = await db.query(
        'spese',
        where: 'lista_nome = ?',
        whereArgs: [occorrenza['nome']]
      );
      ListaSpese newLista = ListaSpese.init(occorrenza['nome'], occorrenza['data_creazione']);
      List<Spesa> newListaSpese = [];
      for (var spesa in spese){
        for (var prodotto in p){
          if (prodotto.nomeprodotto == spesa['prodotto_nome']){
            newListaSpese.add(
              Spesa.init(
                  prodotto,
                  DateTime.parse(spesa['data'] as String),
                  spesa['quantita'] as int,
                  spesa['acquistato'] as bool)
            );
          }
        }
      }
      newLista.aggiungiLista(newListaSpese);
      tutteLeListe.add(newLista);
    }
  }
}
