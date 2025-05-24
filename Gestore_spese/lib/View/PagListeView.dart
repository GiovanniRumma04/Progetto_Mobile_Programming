import 'package:flutter/material.dart';
import 'package:gestore_spese/Model/Categoria.dart';
import 'package:gestore_spese/Model/GestoreApp.dart';
import 'package:gestore_spese/Model/ListaSpese.dart';
import 'package:gestore_spese/Model/Prodotto.dart';
import 'package:gestore_spese/Model/Spesa.dart';
import 'package:gestore_spese/View/BloccoLista.dart';

class ListeView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _listeViewState();
}

class _listeViewState extends State<ListeView> {

  /*void avvia(){
    setState(() {
      ListaSpese l = new ListaSpese('lista1');
      ListaSpese l1 = new ListaSpese('lista2');
      ListaSpese l2 = new ListaSpese('lista3');
      Categoria c1 = new Categoria('cibo');
      Categoria c2 = new Categoria('elettronica');
      Prodotto p = new Prodotto('uova', 2.5, c1, 'un pacco');

      Prodotto p1 = new Prodotto('farina', 2.5, c1, 'un pacco');

      Prodotto p2 = new Prodotto('pane', 2.5, c1, 'dsadsad');

      Spesa s1 = new Spesa(p, DateTime.now(), 3);
      Spesa s2 = new Spesa(p1, DateTime.now(), 5);
      Spesa s3 = new Spesa(p2, DateTime.now(), 1);

      l.aggiungiSpesa(s1);
      l.aggiungiSpesa(s2);
      l.aggiungiSpesa(s3);
      l.aggiungiSpesa(s1);
      l.aggiungiSpesa(s3);
      l.aggiungiSpesa(s2);
      l.aggiungiSpesa(s1);
      l.aggiungiSpesa(s2);
      l.aggiungiSpesa(s3);
      l.aggiungiSpesa(s1);
      l.aggiungiSpesa(s3);
      l.aggiungiSpesa(s2);

      l1.aggiungiSpesa(s1);
      l1.aggiungiSpesa(s2);
      l1.aggiungiSpesa(s3);

      l2.aggiungiSpesa(s2);
      l2.aggiungiSpesa(s1);
      l2.aggiungiSpesa(s3);

      listaCentrale.add(l);
      listaCentrale.add(l1);
      listaCentrale.add(l2);
      listaCentrale.add(l);
      listaCentrale.add(l1);
      listaCentrale.add(l2);
      listaCentrale.add(l);
      listaCentrale.add(l1);
      listaCentrale.add(l2);
      listaCentrale.add(l);
      listaCentrale.add(l1);
      listaCentrale.add(l2);
    });
  }*/

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
