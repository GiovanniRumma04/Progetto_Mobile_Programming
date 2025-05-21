import 'package:gestore_spese/Model/Categoria.dart';

class Prodotto{
  late String _nomeprodotto;
  late double _prezzo;
  late Categoria _c;
  late String _note;

  Prodotto(this._nomeprodotto, this._prezzo, this._c, this._note);

  Categoria get c => _c;

  set c(Categoria value) {
    _c = value;
  }

  String get note => _note;

  set note(String value) {
    _note = value;
  }

  double get prezzo => _prezzo;

  set prezzo(double value) {
    _prezzo = value;
  }

  String get nomeprodotto => _nomeprodotto;

  set nomeprodotto(String value) {
    _nomeprodotto = value;
  }
}