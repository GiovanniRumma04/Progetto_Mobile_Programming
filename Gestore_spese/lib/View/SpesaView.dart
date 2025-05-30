import 'package:flutter/material.dart';
import 'package:gestore_spese/Model/GestoreApp.dart';
import 'package:gestore_spese/Model/Prodotto.dart';
import 'package:gestore_spese/Model/Spesa.dart';
import 'package:provider/provider.dart';

import 'SpesaProdottoView.dart';

class SpesaView extends StatefulWidget {
  final int index;
  final bool selected;
   final int count ;
     final Function(Spesa?) notifcaCambiamneto;
  SpesaView({super.key, required this.index,required this.selected,required this.count,required this.notifcaCambiamneto});

  @override
  _SpesaViewState createState() => _SpesaViewState();
}





class _SpesaViewState extends State<SpesaView> {
  late bool selected;
  late int count;

  void initState() {
    super.initState();
    selected = widget.selected; // copia esplicita
    count = widget.count;       // copia esplicita
  }

  void updateData(Prodotto? p,quantita){
   widget.notifcaCambiamneto(
     selected ?  Spesa(p!, DateTime.now(), quantita) : null
   );


  }


  @override
  Widget build(BuildContext context) {


    final appProvider = Provider.of<GestoreApp>(context);

    return Card(

      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                // Checkbox rotondo
                Checkbox(
                  value: selected,
                  activeColor: Color(0xFFFFCB77),
                  shape: CircleBorder(),
                  onChanged: (bool? newVal) {

                    setState(() {
                     selected = newVal ?? false;
                       count = selected? 1 :0;
                     updateData(appProvider.prodotti[widget.index], count);

                    });
                  },
                ),
                SizedBox(width: 8),
                // Nome e descrizione
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        appProvider.prodotti[widget.index].nomeprodotto,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        appProvider.prodotti[widget.index].c.nomeCategoria,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Pulsanti di quantità e freccia
            Row(
              children: [
                // Decrementa
                IconButton(
                  icon: Icon(Icons.remove_circle_outline,color: Color(0xFFFFCB77),),
                  onPressed: () {
                    setState(() {
                     print("diminusico :");
                      if(count > 0) {
                        count = count-1;
                        updateData(appProvider.prodotti[widget.index],
                            count );

                        print(" rimane quantita $count, nome prodotto ${appProvider.prodotti[widget.index]}");

                      }else {
                        count=0;
                        print(" rimane quantita $count, nome prodotto ${appProvider.prodotti[widget.index]} deseleziono");

                      }

                      selected = (count>0) ? true : false;

                    });
                  },
                ),

                // Conteggio
                Text(
                  '$count',
                  style: TextStyle(fontSize: 16),
                ),

                // Incrementa
                IconButton(
                  icon: Icon(Icons.add_circle_outline,color: Color(0xFFFFCB77)),
                  onPressed: () {
                    setState(() {
                     count =count +1;
                     updateData(appProvider.prodotti[widget.index],
                         count );
                     print(" creo $count, nome prodotto ${appProvider.prodotti[widget.index].nomeprodotto}");
                     selected = (count>0)? true : false;

                    });
                  },
                ),

                // Freccia iOS
                IconButton(
                  icon: Icon(Icons.arrow_right_sharp,size: 30,),
                  color: Color(0xFFFE6D73),
                 padding: EdgeInsets.all(0),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SpesaProdottoView(true, appProvider.prodotti[widget.index], quantita: count,)),
                    );
                  },

                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
