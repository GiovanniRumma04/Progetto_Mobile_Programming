import 'Categoria.dart';

class Spesa{

  late String _nome_prodotto;
  late String _nome_lista;
  late int _quantita;
  late double _prezzo;
  late DateTime _data;
  late Categoria _c;
  late String note;


  //Nota: ogni volta che viene creata una spesa, la categoria associata viene aggiornata
  //con la funzione addNumSpese
  Spesa(this._nome_prodotto, this._nome_lista, this._quantita, this._prezzo,
      this._data, this._c, this.note){
    _c.addNumSpese();
  }


  Categoria get c => _c;

  DateTime get data => _data;

  set data(DateTime value) {
    _data = value;
  }

  double get prezzo => _prezzo;

  set prezzo(double value) {
    _prezzo = value;
  }

  int get quantita => _quantita;

  set quantita(int value) {
    _quantita = value;
  }

  String get nome_lista => _nome_lista;

  set nome_lista(String value) {
    _nome_lista = value;
  }

  String get nome_prodotto => _nome_prodotto;

  set nome_prodotto(String value) {
    _nome_prodotto = value;
  }

  @override
  String toString() {
    return 'Spesa: $_nome_prodotto, quantità: $_quantita, prezzo: $_prezzo, data: $_data, note: $note';
  }


}