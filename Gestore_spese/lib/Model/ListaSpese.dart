import 'Categoria.dart';
import 'Spesa.dart';

class ListaSpese{
    late String _nomeLista;
    late double _spesaTotale;
    late List<Spesa> lista;

    ListaSpese(String nomeLista){
      _nomeLista = nomeLista;
      _spesaTotale = 0.0;
      lista = [];
    }


    String get nomeLista => _nomeLista;

    void aggiungiSpesa(String nomeProdotto, int quantita,
        double prezzo, DateTime d, Categoria c, String note) {
      lista.add(new Spesa(
          nomeProdotto,
          _nomeLista,
          quantita,
          prezzo,
          d,
          c,
          note));
    }

    //Nota: quando da una lista rimuoviamo una Spesa, viene prima selezionata la spesa
    //con la funzione getRange partendo dall'indice della spesa, e poi viene aggiornata
    //la categoria associata con la funzione remNumSpese
    void rimuoviSpesa(int index){
      Spesa s = lista.getRange(index, index+1).first;
      s.c.remNumSpese();
      lista.removeAt(index);
    }

    @override
    String toString() {
      return 'ListaSpese: Totale: $spesaTotale, $lista';
    }

    double get spesaTotale => _spesaTotale;


}