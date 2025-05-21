import 'Prodotto.dart';

class Spesa{

  late Prodotto p;
  late DateTime _data;
  late int _quantita;


  DateTime get data => _data;

  set data(DateTime value) {
    _data = value;
  }

  Spesa(this.p,this._data, this._quantita);

  int get quantita => _quantita;

  set quantita(int value) {
    _quantita = value;
  }
}