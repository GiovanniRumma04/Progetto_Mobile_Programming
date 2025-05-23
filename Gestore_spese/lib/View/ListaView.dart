import 'package:gestore_spese/Model/GestoreApp.dart';
import 'package:flutter/material.dart';
import 'package:gestore_spese/Model/ListaSpese.dart';
import 'package:gestore_spese/Model/Spesa.dart';

void main() {
  runApp(ListaView(l: listaCentrale[0]));
}

class ListaView extends StatelessWidget {
  final ListaSpese l;

  ListaView({required this.l});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF17C3B2),
        title: Text(l.nomeLista, style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Card(
        color: Color(0xC6FFD7A0),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

            children: [
              SizedBox(
                height: 70,
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Cerca un Prodotto...',
                  ),
                ),
              ),
              Text('Dettagli Lista: '),
              Text('Data di Creazione: ' + l.stampaData()),
              Text(
                'Totale: ' + l.spesaTotale.toString() + "€",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: l.lista.length,
                  itemBuilder: (context, index) {
                    return CustomCards(s: l.lista[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomCards extends StatelessWidget {
  final Spesa s;
  CustomCards({required this.s});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    s.p.nomeprodotto,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  Text(
                    'Data Spesa: ' + s.stampaData(),
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),
                  Text(
                    'Prezzo unitario: ' + s.p.prezzo.toString() + "€",
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),
                  Text(
                    'Quantità: ' + s.quantita.toString(),
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),
                  Text(
                    'Costo: ' + (s.p.prezzo * s.quantita).toString() + "€",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),

        Card(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.arrow_forward_ios),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.delete),
                  color: Colors.red,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
