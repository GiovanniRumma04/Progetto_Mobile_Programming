import 'package:flutter/material.dart';
import 'package:gestore_spese/Model/DatabaseManager.dart';
import 'package:gestore_spese/Model/ListaSpese.dart';
import 'package:gestore_spese/View/BloccoLista.dart';

void main() {

  DatabaseManager.instance.insertLista(new ListaSpese('lista1'));
  print(DatabaseManager.instance.ottieniElementi().toString());
  runApp(esempio());
}

class esempio extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _esempioState();
}

class _esempioState extends State<esempio> {
  final List esempi = [
    ListaSpese('lista1'),
    ListaSpese('lista2'),
    ListaSpese('lista3'),
    ListaSpese('lista4'),
    ListaSpese('lista5'),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF17C3B2),
          title: Text(
            'Le Tue Liste',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: ListView.builder(
          itemCount: esempi.length,
          itemBuilder: (context, index) {
            return BloccoLista(l: esempi[index]);
          },
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: (){},
            child: Icon(
                Icons.add,
                color: Colors.black,
            ),
            backgroundColor: Color(0xFFFE6D73),
        ),
      ),
    );
  }
}
