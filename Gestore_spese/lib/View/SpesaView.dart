import 'package:flutter/material.dart';
import 'package:gestore_spese/Model/GestoreApp.dart';
import 'package:gestore_spese/Model/Prodotto.dart';
import 'package:gestore_spese/Model/Spesa.dart';
import 'package:provider/provider.dart';

import 'SpesaProdottoView.dart';

class SpesaView extends StatefulWidget {
  final Prodotto prodotto;
  final Map<Prodotto, int> targetMap;
  final bool selected;
  final int count;

  SpesaView({
    super.key,
    required this.prodotto,
    required this.targetMap,
    required this.selected,
    required this.count,
  });

  @override
  _SpesaViewState createState() => _SpesaViewState();
}

class _SpesaViewState extends State<SpesaView> {
  late bool selected;
  late int count;
  late Spesa s;

  @override
  void initState() {
    super.initState();
    selected = widget.selected;
    count = widget.count;
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<GestoreApp>(context);
    int index = appProvider.prodotti.indexOf(widget.prodotto);
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
                      count = selected ? 1 : 0;

                      if (selected == true) {
                        widget.targetMap[widget.prodotto] = count;
                        s = new Spesa(widget.prodotto);
                        s.quantita = count;
                        appProvider.addSpesa(s);
                        print(widget.targetMap.toString());
                      } else {
                        widget.targetMap.remove(widget.prodotto);
                        appProvider.spesa.remove(s);
                      }
                    });
                  },
                ),
                // Nome e descrizione
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 90,
                      child: Text(
                        widget.prodotto.nomeprodotto,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    //SizedBox(height: 4),
                    Text(
                      widget.prodotto.c.nomeCategoria,
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                  ],
                ),
              ],
            ),

            // Pulsanti di quantità e freccia
            Row(
              children: [
                // Decrementa
                IconButton(
                  icon: Icon(
                    Icons.remove_circle_outline,
                    color: Color(0xFFFFCB77),
                  ),
                  onPressed: () {
                    setState(() {
                      print("diminusico :");

                      if (count > 0) {
                        count = count - 1;

                        widget.targetMap[widget.prodotto] = count;
                        s.quantita = count;
                        appProvider.addSpesa(s);



                        print(
                          " rimane quantita $count, nome prodotto ${appProvider.prodotti[index]}",
                        );
                      } else {
                        count = 0;


                        print(
                          " rimane quantita $count, nome prodotto ${appProvider.prodotti[index]} deseleziono",
                        );
                      }

                      selected = (count > 0) ? true : false;

                      if(selected == false){ // controllo su selected dopo che viene settato a false
                        widget.targetMap.remove(widget.prodotto);
                        appProvider.spesa.remove(s);
                      }
                    });
                  },
                ),

                // Conteggio
                Text('$count', style: TextStyle(fontSize: 16)),

                // Incrementa
                IconButton(
                  icon: Icon(
                    Icons.add_circle_outline,
                    color: Color(0xFFFFCB77),
                  ),
                  onPressed: () {
                    setState(() {
                      count = count + 1;


                      widget.targetMap[widget.prodotto] = count;

                      if(count == 1){ // appena incremento di 1 significa che devo istanziare una spesa di quantità unitaria
                        s = new Spesa(widget.prodotto);
                        s.quantita = count;
                        appProvider.addSpesa(s);

                      }else if(count > 1){ // se la quantità è maggiore di 1 significa che ho già istanziato la spesa e devo solo incrementarne la quantità
                        s.quantita = count;
                        appProvider.addSpesa(s);
                      }

                      print(
                        " creo $count, nome prodotto ${appProvider.prodotti[index].nomeprodotto}",
                      );
                      selected = (count > 0) ? true : false;
                    });
                  },
                ),

                IconButton(
                  icon: Icon(Icons.arrow_right_sharp, size: 30),
                  color: Color(0xFFFE6D73),
                  padding: EdgeInsets.all(0),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => SpesaProdottoView(
                              true,
                              appProvider.prodotti[index],
                              quantita: count,
                            ),
                      ),
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
