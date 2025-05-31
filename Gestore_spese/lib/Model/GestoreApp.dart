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
      if (prodotti[i].id == updatedProduct.id) {
        Prodotto p = prodotti[i];
        p = updatedProduct;
      }
    }


    for (var lista in tutteLeListe) {
      double newTotal = 0.0;
      for (var spesa in lista.lista) {
        if (spesa.p.id == updatedProduct.id) {
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
