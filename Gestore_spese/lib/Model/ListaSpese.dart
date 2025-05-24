import 'Spesa.dart';

class ListaSpese {
  late String _nomeLista;

  late double _spesaTotale;

  late List<Spesa> lista;

  late int _numElementi;

  late DateTime datacreazione;

  ListaSpese(this._nomeLista) {
    _spesaTotale = 0.0;
    _numElementi = 0;
    datacreazione = DateTime.now();
    lista = [];
  }

  int get numElementi => _numElementi;

  double get spesaTotale => _spesaTotale;

  String get nomeLista => _nomeLista;

  set nomeLista(String value) {
    _nomeLista = value;
  }

  void aggiungiSpesa(Spesa s) {
    lista.add(s);
    _numElementi = _numElementi + 1;
    _spesaTotale = spesaTotale + (s.p.prezzo * s.quantita);
  }

  void rimuoviSpesa(int index) {
    Spesa s = lista.removeAt(index);
    _numElementi = _numElementi - 1;
    _spesaTotale = spesaTotale - (s.p.prezzo * s.quantita);
  }

  String stampaData(){
    return "${datacreazione.day}/${datacreazione.month}/${datacreazione.year}";
  }

  /*Map<String, dynamic> toJson() {
    return {
      'nomeLista': nomeLista,
      'spesaTotale': spesaTotale,
      'Lista': lista.map((s)=>s.toJson()).toList(),
      'numElementi': numElementi,
      'datacreazione': datacreazione.toIso8601String()
    };
  }

  factory ListaSpese.fromJson(Map<String, dynamic> json){
    return ListaSpese(json['nomeLista']);
  }*/

  @override
  String toString() {
    return 'ListaSpese{_nomeLista: $_nomeLista, _spesaTotale: $_spesaTotale, _numElementi: $_numElementi}';
  }
}
