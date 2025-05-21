import 'Categoria.dart';
import 'Spesa.dart';

class ListaSpese{
    late String _nomeLista;
    late double _spesaTotale;
    late List<Spesa> lista;
    late int _numElementi;

    ListaSpese(this._nomeLista){
      _spesaTotale = 0.0;
      _numElementi = 0;
      lista = [];
    }

    int get numElementi => _numElementi;

  set numElementi(int value) {
    _numElementi = value;
  }

  double get spesaTotale => _spesaTotale;

  set spesaTotale(double value) {
    _spesaTotale = value;
  }

  String get nomeLista => _nomeLista;

  set nomeLista(String value) {
    _nomeLista = value;
  }
}