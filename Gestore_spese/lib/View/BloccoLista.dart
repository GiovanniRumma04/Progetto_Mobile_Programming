import 'package:flutter/material.dart';
import 'package:gestore_spese/Model/ListaSpese.dart';
import 'package:gestore_spese/View/ListaView.dart';
import 'package:google_fonts/google_fonts.dart';

class BloccoLista extends StatelessWidget {
  final ListaSpese l;

  BloccoLista({required this.l});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
        height: 150,
        child: Card(
          color: Color(0xC6FFD7A0),
          margin: EdgeInsets.all(10),
          elevation: 4,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                    Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.delete),
                      color: Colors.red,
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      'Data di Creazione: ' +l.stampaData(),
                    ),
                    Text('Totale: ' + l.spesaTotale.toString() + '€'),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ListaView(l: l),
                          ),
                        );
                      },
                      icon: Icon(Icons.arrow_forward_ios),
                      color: Colors.black,
                    ),
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
