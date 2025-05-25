import 'package:flutter/material.dart';
import 'package:gestore_spese/Model/GestoreApp.dart';
import 'package:gestore_spese/View/AddList.dart';
import 'package:gestore_spese/View/BloccoLista.dart';
import 'package:provider/provider.dart';

import 'InfoListaScreen.dart';

class ListeView extends StatefulWidget {
  const ListeView({super.key});

  @override
  State<StatefulWidget> createState() => _listeViewState();
}

class _listeViewState extends State<ListeView> {



  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<GestoreApp>(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF227C9D),
          title: Text(
            'Le Tue Liste',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: ListView.builder(
          itemCount: appState.tutteLeListe.length,
          itemBuilder: (context, index) {
            return BloccoLista(l: appState.tutteLeListe[index]);
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: openSettingLista,
          
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          backgroundColor: Color(0xFFFE6D73),
          child: const Icon(Icons.add, color: Colors.black),
        ),
      );
  }

  void openSettingLista() {

    showModalBottomSheet(context: context, builder: (ctx)=>  InfoListaScreen()  );
  }
}
