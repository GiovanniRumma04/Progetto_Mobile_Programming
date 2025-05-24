import 'package:flutter/cupertino.dart';
import 'package:gestore_spese/Model/ListaSpese.dart';
import 'package:gestore_spese/Model/Prodotto.dart';
import 'package:gestore_spese/Model/Spesa.dart';

import 'Categoria.dart';

class GestoreApp extends ChangeNotifier{

  List<Prodotto> prodotti = [];
  List<Spesa> spese = [];
  List<ListaSpese> tutteLeListe = [];






  void creaProd (Prodotto p){

    prodotti.add(p);
    notifyListeners();

  }

  void CreaLista (ListaSpese ls){

    tutteLeListe.add(ls);
    notifyListeners();
  }

  void creaSpesa (ListaSpese ls,Spesa s){
    ls.aggiungiSpesa(s);
    notifyListeners();
  }


}

