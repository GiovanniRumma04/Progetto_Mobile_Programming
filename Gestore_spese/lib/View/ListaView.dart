import 'package:flutter/material.dart';
import 'package:gestore_spese/Model/ListaSpese.dart';
import 'package:gestore_spese/Model/Spesa.dart';

class ListaView extends StatelessWidget {
  final ListaSpese l;

  const ListaView({super.key, required this.l});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF227C9D),
        title: Text(l.nomeLista, style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Container(
        color: Color(0xFFFFCB77),
        padding: EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

          children: [
            Container(
              height: 50,
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: Offset(0, 0),
                  ),
                ],

              ),
              child: TextField(
                decoration: InputDecoration(labelText: 'Cerca un Prodotto...', border: InputBorder.none),

              ),
            ),
            Text('Dettagli Lista: '),
            Text('Data di Creazione: ${l.stampaData()}'),
            Text(
              'Totale: ' + l.spesaTotale.toString() + "€",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            Flexible(
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
    );
  }
}

class CustomCards extends StatelessWidget {
  final Spesa s;
  const CustomCards({super.key, required this.s});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 170,
          margin: EdgeInsets.all(8),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 8,
                offset: Offset(0, 0),
              ),
            ],
          ),
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
                'Data Spesa: ${s.stampaData()}',
                style: TextStyle(fontWeight: FontWeight.w300),
              ),
              Text(
                'Prezzo unitario: ' + s.p.prezzo.toString() + "€",
                style: TextStyle(fontWeight: FontWeight.w300),
              ),
              Text(
                'Quantità: ${s.quantita}',
                style: TextStyle(fontWeight: FontWeight.w300),
              ),
              Text(
                'Costo: ' + (s.p.prezzo * s.quantita).toString() + "€",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),

        Container(
          height: 170,
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 8,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(onPressed: () {}, icon: Icon(Icons.arrow_forward_ios)),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.delete),
                color: Colors.red,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
