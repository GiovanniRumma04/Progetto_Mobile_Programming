import 'package:flutter/cupertino.dart';
import 'package:gestore_spese/Model/ListaSpese.dart';
import 'package:gestore_spese/Model/Prodotto.dart';
import 'package:gestore_spese/Model/Spesa.dart';
import 'package:gestore_spese/View/SpesaView.dart';

import 'Categoria.dart';

class GestoreApp extends ChangeNotifier {
  List<Prodotto> prodotti = [];
  List<Categoria> categorie = [];
  List<ListaSpese> tutteLeListe = [];
  late int indiceCategoria;
  List<Spesa> spesa = [];



  void addSpesa(Spesa sIn) {
    spesa.removeWhere((s)=> sIn.p.nomeprodotto ==s.p.nomeprodotto);
    spesa.add(sIn);
    print(spesa);
    notifyListeners();
  }


  void aggiungiSpeseNellaLista(ListaSpese ls){

    if(spesa.isNotEmpty){
      ls.aggiungiLista(spesa);
      tutteLeListe.add(ls);
      spesa.removeRange(0, spesa.length-1);
      notifyListeners();
    }else{
      print("inserisci almeno una spesa");
    }


  }

  void creaProd(Prodotto p) {
    prodotti.add(p);
    notifyListeners();
  }

  void creaCategoria(Categoria c) {
    categorie.add(c);
    notifyListeners();
  }

  void CreaLista(ListaSpese ls) {
    tutteLeListe.add(ls);
    notifyListeners();
  }

  void eliminaLista(ListaSpese l) {
    tutteLeListe.remove(l);
    print(tutteLeListe);
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
}
