import 'package:flutter/material.dart';
import 'package:gestore_spese/Model/Categoria.dart';
import 'package:gestore_spese/Model/GestoreApp.dart';
import 'package:gestore_spese/Model/ListaSpese.dart';
import 'package:gestore_spese/Model/Spesa.dart';
import 'package:gestore_spese/Model/Prodotto.dart';
import 'package:gestore_spese/View/HomeView.dart';
import 'package:provider/provider.dart';

void main() {

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


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GestoreApp(),
      child: MaterialApp(

        home: HomeView(),
      ),
    );
  }
}
