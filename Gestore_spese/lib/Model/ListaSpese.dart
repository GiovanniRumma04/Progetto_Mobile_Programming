import 'Spesa.dart';

class ListaSpese {
  late String _nomeLista;

   double spesaTotale=0.0;

  late List<Spesa> lista;

  late int numElementi=0;

  late DateTime datacreazione;

  ListaSpese(this._nomeLista) {

    datacreazione = DateTime.now();
    lista = [];
  }

  ListaSpese.init(this._nomeLista, this.datacreazione){
    lista = [];
  }

  String get nomeLista => _nomeLista;

  set nomeLista(String value) {
    _nomeLista = value;
  }

  void aggiungiLista(List<Spesa> ls){

    lista.addAll(ls);
    numElementi=ls.length;
    SommmaSpesaTotale();

  }

  void  SommmaSpesaTotale() {
    spesaTotale = lista.fold(0.0, (somma, spesa) =>
    somma + (spesa.p.prezzo * spesa.quantita)
    );
  }
  String stampaData(){
    return "${datacreazione.day}/${datacreazione.month}/${datacreazione.year}";
  }

  @override
  bool operator ==(Object other) {
    return other is ListaSpese &&
        other.nomeLista.toLowerCase() == nomeLista.toLowerCase(); // case-insensitive
  }

  @override
  String toString() {
    String retVal = 'ListaSpesa{_nomeLista: $_nomeLista, data: $datacreazione,{';
    for (var spesa in lista){
      retVal += spesa.toString() + ', ';
    }
    return retVal + 'end}';
  }

}
