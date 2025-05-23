import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'BloccoLista.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("HOME")),
      body: Column(
        children: [
          TextField(style: TextStyle()),

          SizedBox(height: 10),

          Row(
            children: [
              Text("PRODOTTI RECENTI"),
              TextButton(onPressed: () {}, child: Text("VEDI TUTTI")),
              SizedBox(height: 15),
            ],
          ),

          Container(
            width: MediaQuery.of(context).size.width,
            height: 350,

            // child: ListView.builder(
            // itemCount: 4,
            //itemBuilder:  (context, index) {
            //return BloccoLista(l: listaCentrale[index]);
            // },
            //),
          ),

          SizedBox(height: 10),

          Row(
            children: [
              Text("LISTE RECENTI"),
              TextButton(onPressed: () {}, child: Text("VEDI TUTTI")),
              SizedBox(height: 15),
            ],
          ),

          Container(
            width: MediaQuery.of(context).size.width,
            height: 350,

            // child: ListView.builder(
            // itemCount: 4,
            //itemBuilder:  (context, index) {
            //return BloccoLista(l: listaCentrale[index]);
            // },
            //),
          ),
        ],
      ),
    );
  }
}
