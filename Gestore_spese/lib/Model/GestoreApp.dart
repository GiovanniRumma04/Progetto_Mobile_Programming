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

void CreaLista(ListaSpese ls ){

tutteLeListe.add(ls);
notifyListeners();
}

  void eliminaLista(ListaSpese l) {
    tutteLeListe.remove(l);
    print(tutteLeListe);
    notifyListeners();
  }

  void eliminaSpesa(int indexS, int indexL) {
    tutteLeListe[indexL].rimuoviSpesa(indexS);
    notifyListeners();
  }
}
