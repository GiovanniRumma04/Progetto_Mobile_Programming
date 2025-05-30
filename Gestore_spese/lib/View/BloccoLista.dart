import 'package:flutter/material.dart';
import 'package:gestore_spese/Model/GestoreApp.dart';
import 'package:gestore_spese/Model/ListaSpese.dart';
import 'package:gestore_spese/View/ListaView.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BloccoLista extends StatelessWidget {
  final ListaSpese l;
  final int indice;


  const BloccoLista({super.key, required this.l, required this.indice});

  @override
  Widget build(BuildContext context) {

    return Card(
      color: Color(0xFFFFCB77),
      elevation: 2,
      child: Container(
        width: MediaQuery.of(context).size.width,

        height: 150,
        padding: EdgeInsets.all(12),

        decoration: BoxDecoration(

          color: Color(0xFFFFCB77),
          borderRadius: BorderRadius.circular(20),
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Expanded(
                  child: Text(
                    l.nomeLista,
                    style: GoogleFonts.b612(
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                        fontSize: 23,
                      ),
                    ),
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ListaView(l: l, indexL: indice)),
                    );
                  },
                  icon: Icon(Icons.arrow_forward_ios),
                  color: Colors.black,
                ),



                  ],
                ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    confermaPopup(context, l);

                  },
                  icon: Icon(Icons.delete),
                  color: Colors.red,
                ),

                SizedBox(width: 15),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Data di Creazione: ${l.stampaData()}', style: TextStyle(
                          fontWeight: FontWeight.bold
                      ),
                      ),
                      Text('Totale: ${l.spesaTotale.toString()}€', style: TextStyle(
                          fontWeight: FontWeight.bold
                      ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void confermaPopup(BuildContext context, ListaSpese l) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Container(
        height: 250,
        child: Padding(
          padding: EdgeInsets.all(20),

        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                  child: Text(
                    'Sei sicuro di voler cancella questa lista?'
                    ,style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),)
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      onPressed: (){
                        Provider.of<GestoreApp>(context, listen: false).eliminaLista(l);
                        Navigator.pop(context);
                      },

                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 30),
                          elevation: 6,
                          backgroundColor: Color(0xFFFE6D73),
                          shadowColor: Color(0xFFFE6D73).withOpacity(0.6)
                      ),
                      child: Text(
                        'Conferma',
                        style: TextStyle(color: Colors.white, fontSize: 18,
                          fontWeight: FontWeight.bold,),)

                  ),
                  ElevatedButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },



                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 30),
                          elevation: 6,
                          backgroundColor: Colors.white,
                          shadowColor: Colors.black.withOpacity(0.6)
                      ),

                      child: Text(
                        'Annulla', style: TextStyle(
                        color: Color(0xFFFE6D73),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),))
                ],
              )

            ]
        )
    ),
      ),
    );
  }
}
