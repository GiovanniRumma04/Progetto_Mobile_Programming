import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:gestore_spese/View/BloccoLista.dart';
import 'package:gestore_spese/View/CreaCategoriaView.dart';
import 'package:gestore_spese/View/CreaProdottoView.dart';
import 'package:gestore_spese/View/InfoListaScreen.dart';
import 'package:gestore_spese/View/ProdottoView.dart';
import 'package:provider/provider.dart';

import '../Model/Categoria.dart';
import '../Model/GestoreApp.dart';
import '../Model/ListaSpese.dart';
import '../Model/Prodotto.dart';
import '../Model/Spesa.dart';
import 'ListeView.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String query = '';

  @override
  Widget build(BuildContext context) {

    final appProvider = Provider.of<GestoreApp>(context);
    final prodottiFiltrati = getFilteredProducts(appProvider.prodotti, query);


    final TextStyle sectionTitleStyle = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      shadows: [
        Shadow(color: Colors.black38, offset: Offset(1, 1), blurRadius: 2),
      ],
    );
    final TextStyle textButtonStyle = TextStyle(
      fontSize: 16,
      color: Color(0xFF17C3B2),
      fontWeight: FontWeight.bold,
      shadows: [
        Shadow(color: Color(0x6617C3B2), offset: Offset(1, 1), blurRadius: 2),
      ],
    );

    final TextStyle fabLabelStyle = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: Colors.black87,
      shadows: [
        Shadow(color: Colors.black12, offset: Offset(1, 1), blurRadius: 1),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF227C9D),
        title: Text(
          "Prodotti",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(

        children: [
          // TextField personalizzato
          SizedBox(height: 20,),
          Container(

            width: 300,
            padding: EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Color(0xFFFFCB77),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color:  Color(0xFFFFCB77).withOpacity(0.5),
                  blurRadius: 5,
                  offset: const Offset(2, 3),
                  spreadRadius: 2,
                  
                )
              ]
            ),

            child: TextField(
              onChanged: (value) {
                setState(() {
                  query = value;
                });
              },
              decoration: InputDecoration(
                icon: Icon(Icons.search, color: Colors.black54),
                hintText: "Ricerca...",
                border: InputBorder.none,
              ),
            ),
          ),
          SizedBox(height: 20,),
          Container(
            height: 500,
            child: ListView.builder(
              itemCount: prodottiFiltrati.length,
              scrollDirection: Axis.vertical ,

              itemBuilder: (context, index) {

                  return ProdottoView(
                    prodotto: prodottiFiltrati[(prodottiFiltrati.length-1)-index],
                    icona: Icons.shopping_bag,
                  );

              },
            ),
          ),

          ]
          ),



      // Floating Action Button personalizzato
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ExpandableFab(
        type: ExpandableFabType.up,
        distance: 70,
        overlayStyle: ExpandableFabOverlayStyle(
          color: Colors.white.withOpacity(0.9),
        ),
        childrenAnimation: ExpandableFabAnimation.rotate,
        openButtonBuilder: RotateFloatingActionButtonBuilder(
          child: const Icon(Icons.add, size: 33),
          fabSize: ExpandableFabSize.regular,
          foregroundColor: Color(0xFFFEF9EF), // Colore dell'icona
          backgroundColor: Color(0xffFE6D73), // Colore di sfondo del FAB
          shape: const CircleBorder(),
        ),
        closeButtonBuilder: DefaultFloatingActionButtonBuilder(
          child: const Icon(Icons.close, size: 33),
          fabSize: ExpandableFabSize.regular,
          foregroundColor: Color(0xFFFEF9EF),
          backgroundColor: Color(0xFFFE6D73),
          shape: const CircleBorder(),
        ),
        children: [
          Row(
            children: [
              Text("Crea Lista", style: fabLabelStyle),
              SizedBox(width: 12),
              FloatingActionButton.small(
                elevation: 6,
                heroTag: null,
                backgroundColor: Color(0xFFFEF9EF),

                onPressed: () {

                  showModalBottomSheet(context: context, builder: (ctx)=>  InfoListaScreen()  );
                },
                child: Icon(Icons.checklist_rounded, color: Color(0xFFFE6D73)),
              ),
            ],
          ),
          Row(
            children: [
              Text("Crea Prodotto", style: fabLabelStyle),
              SizedBox(width: 12),
              FloatingActionButton.small(
                elevation: 6,
                heroTag: null,
                backgroundColor: Color(0xFFFEF9EF),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CreaProdottoView()));
                },
                child: Icon(Icons.add_box_rounded, color: Color(0xFFFE6D73)),
              ),
            ],
          ),
          Row(
            children: [
              Text("Crea Categoria", style: fabLabelStyle),
              SizedBox(width: 12),
              FloatingActionButton.small(
                elevation: 6,
                heroTag: null,
                backgroundColor: Color(0xFFFEF9EF),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CreaCategoriaView()));
                },
                child: Icon(Icons.category_rounded, color: Color(0xFFFE6D73)),
              ),
            ],
          ),
        ],
      ),

    );
  }
}

List<Prodotto> getFilteredProducts(List<Prodotto> prodotti, String query) {
  if (query.isEmpty) return prodotti;
  return prodotti
      .where((p) => p.nomeprodotto.toLowerCase().contains(query.toLowerCase()))
      .toList();
}

