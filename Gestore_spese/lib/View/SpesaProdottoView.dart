import 'package:flutter/material.dart';
import '../Model/Spesa.dart';

class SpesaProdottoView extends StatelessWidget {

  final bool mostraTutto;
  final Spesa spesa;

  const SpesaProdottoView(this.mostraTutto, this.spesa, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFEF9EF),
      appBar: AppBar(centerTitle: true,
                     backgroundColor: Color(0xFF227C9D),
                     title: Text(mostraTutto ? 'DETTAGLI SPESA' : 'DETTAGLI PRODOTTO',
                                 style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white)
                     )
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView(
          shrinkWrap: true,
          children: [
            Text('NOME PRODOTTO:\n${spesa.p.nomeprodotto}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF227C9D))),
            SizedBox(height: 20),
            Text('CATEGORIA:\n${spesa.p.c.nomeCategoria}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF17C382))),
            SizedBox(height: 20),
            Text('PREZZO:\n€${spesa.p.prezzo.toStringAsFixed(2)}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFFFFC877))),
            SizedBox(height: 20),
            if(mostraTutto)...[
              Text('QUANTITA\':\n${spesa.quantita}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFFFE6D73))),
              SizedBox(height: 20),
              Text('DATA:\n${spesa.data}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF227C9D))),
              SizedBox(height: 20),
            ],
            Text('NOTE:\n${spesa.p.note}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //Navigator.pop(context);
          //Messaggio di prova
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Hai cliccato il pulsante per tornare indietro'),
              backgroundColor: Colors.black,
              duration: Duration(seconds: 2),
            ));
        },
        tooltip: 'Torna indietro',
        backgroundColor: Color(0xFF17C382),
        child: Icon(Icons.arrow_back, color: Colors.white),
      ),
    );
  }

}