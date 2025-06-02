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

  GestoreApp() {
    init();
  }

  Future<void> init() async {
    await getCategorie();
    await getProdotti(categorie);
    await getListe(prodotti);
    notifyListeners();
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
    final c = categorie.firstWhere((c) => c.nomeCategoria == p.c.nomeCategoria);
    c.addNumSpese();
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
        var oldSpesa = spesa;
        if (spesa.p.nomeprodotto == updatedProduct.nomeprodotto) {
          spesa.p = updatedProduct;
          spesa.quantita = updatedQuantita;
        }
        newTotal += spesa.p.prezzo * spesa.quantita;
        DatabaseHelper.instance.modificaSpesa(lista, oldSpesa, spesa);
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

  Future<void> getCategorie() async {
    print("getCategorie");
    final db = await DatabaseHelper.instance.database;

    final List<Map<String, dynamic>> result = await db.query('categorie');

    for (var occorrenza in result){
      final num = await db.query(
        'prodotti',
        where: 'categoria_nome = ?',
        whereArgs: [occorrenza['nome']]
      );
      categorie.add(Categoria.init(occorrenza['nome'], num.length));
    }
    print("Categorie caricate: $categorie");
  }

  Future<void> getProdotti(List<Categoria> l) async {
    print("getProdotti");
    final db = await DatabaseHelper.instance.database;

    final test = await db.query('prodotti');
    print(test.length);
    for (var str in test){
      print(str.toString());
    }

    for (var c in l){
      final res = await db.query(
        'prodotti',
        where: 'categoria_nome = ?',
        whereArgs: [c.nomeCategoria],
      );
      for (var p in res){
        final newProd = Prodotto(
          p['nome'] as String,
          p['prezzo'] as double,
          c,
          p['note'] as String
        );
        prodotti.add(newProd);
      }
    }
    print("Prodotti caricati: $prodotti");
  }

  Future<void> getListe(List<Prodotto> p) async {
    print("getListe");
    final db = await DatabaseHelper.instance.database;

    final liste = await db.query('liste');

    for (Map<String, dynamic> occorrenza in liste){
      final spese = await db.query(
        'spese',
        where: 'lista_nome = ?',
        whereArgs: [occorrenza['nome']]
      );
      ListaSpese newLista = ListaSpese.init(occorrenza['nome'], DateTime.parse(occorrenza['data_creazione']));
      List<Spesa> newListaSpese = [];
      for (var spesa in spese){
        for (var prodotto in p){
          if (prodotto.nomeprodotto == spesa['prodotto_nome']){
            newListaSpese.add(
              Spesa.init(
                  prodotto,
                  DateTime.parse(spesa['data'].toString()),
                  spesa['quantita'] as int,
                  spesa['acquistato']== 1?true:false)
            );
          }
        }
      }
      newLista.aggiungiLista(newListaSpese);
      tutteLeListe.add(newLista);
    }
    print("Liste caricate: $tutteLeListe");
  }
}
