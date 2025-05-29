import 'Prodotto.dart';

class Spesa {
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

  String stampaData(){
    return "${_data.day}/${_data.month}/${_data.year}";
  }

  @override
  String toString() {
    return 'Spesa{p: $p, _data: $_data, _quantita: $_quantita}';
  }

  /*Map<String, dynamic> toJson(){
    return{
      'prodotto': p.toJson(),
      'data': data.toIso8601String(),
      'quantità': quantita
    };
  }

  factory Spesa.fromJson(Map<String, dynamic> json){
    return Spesa(json['prodotto'],json['data'],json['quantità']);
  }*/



}
