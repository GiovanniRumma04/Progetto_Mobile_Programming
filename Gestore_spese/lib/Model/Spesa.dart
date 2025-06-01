import 'Prodotto.dart';

class Spesa {
  late Prodotto p;

  late DateTime data;

  late int quantita;
  late bool acquistato;

  Spesa(this.p) {
    quantita = 0;
    data = DateTime.now();
    acquistato = false;
  }

  @override
  String toString() {
    return 'Spesa{p: $p, data: $data, quantita: $quantita, acquistato: $acquistato}';
  }
}
