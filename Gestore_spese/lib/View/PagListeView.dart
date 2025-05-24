import 'package:flutter/material.dart';
import 'package:gestore_spese/Model/GestoreApp.dart';
import 'package:gestore_spese/View/BloccoLista.dart';

class ListeView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _listeViewState();
}

class _listeViewState extends State<ListeView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF17C3B2),
          title: Text(
            'Le Tue Liste',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: ListView.builder(
          itemCount: listaCentrale.length,
          itemBuilder: (context, index) {
            return BloccoLista(l: listaCentrale[index]);
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          backgroundColor: Color(0xFFFE6D73),
          child: const Icon(Icons.add, color: Colors.black),
        ),
      );
  }
}
