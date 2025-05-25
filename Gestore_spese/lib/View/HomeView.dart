import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';

import 'ListeView.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
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

