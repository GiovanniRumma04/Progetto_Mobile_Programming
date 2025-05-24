import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:gestore_spese/Model/Categoria.dart';
import 'package:gestore_spese/Model/GestoreApp.dart';
import 'package:gestore_spese/Model/ListaSpese.dart';
import 'package:gestore_spese/Model/Prodotto.dart';
import 'package:gestore_spese/Model/Spesa.dart';
import 'package:gestore_spese/View/BloccoLista.dart';
import 'package:provider/provider.dart';

import 'ListeView.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
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
    final appProvider = Provider.of<GestoreApp>(context);
    appProvider.tutteLeListe.addAll([l,l1,l2, l2, l1, l]);

    final TextStyle sectionTitleStyle = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      shadows: [
        Shadow(color: Colors.black38, offset: Offset(1, 1), blurRadius: 2)
      ],
    );
    final TextStyle textButtonStyle = TextStyle(
      fontSize: 16,
      color:Color(0xFF17C3B2) ,
      fontWeight:  FontWeight.bold,
      shadows: [
        Shadow(color: Color(0x6617C3B2), offset: Offset(1, 1), blurRadius: 2)
      ],

    );

    final TextStyle fabLabelStyle = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: Colors.black87,
      shadows: [
        Shadow(color: Colors.black12, offset: Offset(1, 1), blurRadius: 1)
      ],
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor:Color(0xFF227C9D),
        title: Text(
          "Benvenuto nella Home",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(color: Colors.black87, offset: Offset(1, 2), blurRadius: 2)
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TextField personalizzato
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Color(0xFFFFCB77),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.search, color: Colors.black54),
                  hintText: "Ricerca...",
                  border: InputBorder.none,
                ),
              ),
            ),

            SizedBox(height: 25),

            // Sezione Prodotti Recenti
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("PRODOTTI RECENTI", style: sectionTitleStyle),
                TextButton(
                  onPressed: () {},

                  child: Text("Scopri di più",style: textButtonStyle,),
                ),
              ],
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              height: 350,
              color: Colors.grey[100],

            ),

            SizedBox(height: 25),

            // Sezione Liste Recenti
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("LISTE RECENTI", style: sectionTitleStyle),
                TextButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => ListeView()
                    )
                    );
                  },
                  child: Text("Scopri di più",style: textButtonStyle,),

                ),
              ],
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              height: 350,
              color: Colors.grey[100],
              child: ListView.builder(itemCount:3, itemBuilder: (context, index){
                return BloccoLista(l: appProvider.tutteLeListe[index]);
              }),
            ),
          ],
        ),
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
          child: const Icon(Icons.add,size: 33,),
          fabSize: ExpandableFabSize.regular,
          foregroundColor: Color(0xFFFEF9EF), // Colore dell'icona
          backgroundColor: Color(0xffFE6D73), // Colore di sfondo del FAB
          shape: const CircleBorder(),
        ),
        closeButtonBuilder: DefaultFloatingActionButtonBuilder(
          child: const Icon(Icons.close,size: 33,),
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

                onPressed: () {},
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
                onPressed: () {},
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
                onPressed: () {},
                child: Icon(Icons.category_rounded, color: Color(0xFFFE6D73)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

