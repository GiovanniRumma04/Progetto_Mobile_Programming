import 'package:flutter/material.dart';
import 'package:gestore_spese/Model/GestoreApp.dart';
import 'package:provider/provider.dart';

class SpesaView extends StatefulWidget {
  int index;

  SpesaView({required this.index});

  @override
  _SpesaViewState createState() => _SpesaViewState();
}

class _SpesaViewState extends State<SpesaView> {
  bool _selected = false;
  int _count = 0;


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
                  value: _selected,
                  activeColor: Color(0xFFFFCB77),
                  shape: CircleBorder(),
                  onChanged: (bool? newVal) {
                    setState(() {
                      _selected = newVal ?? false;
                    });
                  },
                ),
                SizedBox(width: 8),
                // Nome e descrizione
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appProvider.prodotti[widget.index].nomeprodotto,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      appProvider.prodotti[widget.index].note,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
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
                  icon: Icon(Icons.remove_circle_outline,color: Color(0xFFFFCB77),),
                  onPressed: () {
                    setState(() {
                      if (_count > 0) _count--;
                    });
                  },
                ),

                // Conteggio
                Text(
                  '$_count',
                  style: TextStyle(fontSize: 16),
                ),

                // Incrementa
                IconButton(
                  icon: Icon(Icons.add_circle_outline,color: Color(0xFFFFCB77)),
                  onPressed: () {
                    setState(() {
                      _count++;
                    });
                  },
                ),

                // Freccia iOS
                IconButton(
                  icon: Icon(Icons.arrow_right_sharp,size: 30,),
                  color: Color(0xFFFE6D73),
                 padding: EdgeInsets.all(0),
                  onPressed: () {},

                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
