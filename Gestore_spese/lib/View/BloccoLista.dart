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
      width: MediaQuery.of(context).size.width,

      height: 150,
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xFFFFCB77),
        borderRadius: BorderRadius.circular(20),
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              Text('Data di Creazione: ' + l.stampaData()),
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
                    MaterialPageRoute(builder: (context) => ListaView(l: l)),
                  );
                },
                icon: Icon(Icons.arrow_forward_ios),
                color: Colors.black,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
