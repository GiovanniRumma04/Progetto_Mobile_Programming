import 'package:flutter/material.dart';
import 'package:gestore_spese/Model/ListaSpese.dart';
import 'package:google_fonts/google_fonts.dart';

class BloccoLista extends StatelessWidget {
  final ListaSpese l;

  BloccoLista({required this.l});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
        height: 200,
        child: Card(
          color: Color(0xFFFEF9EF),
          margin: EdgeInsets.all(10),
          elevation: 4,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.table_chart, color: Colors.black, size: 30),
                    Text(
                      l.nomeLista,
                      style: GoogleFonts.b612(
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w300,
                          fontSize: 25,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.arrow_forward_ios),
                      color: Colors.black,
                    ),
                  ],
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    Text('Numero di Spese: ' + l.numElementi.toString()),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.delete),
                      color: Colors.red,
                    ),
                    Text('Totale: ' + l.spesaTotale.toString() + '€'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
