import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Model/GestoreApp.dart';
import 'SpesaView.dart';

class AddList extends StatelessWidget{
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

  @override

  Widget build(BuildContext context) {
    final appProvider = Provider.of<GestoreApp>(context);
    return Scaffold(

       appBar: AppBar(
         backgroundColor:Color(0xFF227C9D),
          title: Text("Crea Lista",
            style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,

          )
          ),
         centerTitle: true,
       ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Container(

              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Color(0xFFFFCB77),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.search, color: Colors.black54),
                  hintText: "Cerca Prodotto ",
                  border: InputBorder.none,
                ),
              ),
            ),
              SizedBox(height: 10,),
            Container(
              height: 400,

             child: SingleChildScrollView(
               scrollDirection: Axis.vertical,
               child: Wrap(

                 children: List.generate(10, (index){

                   return SpesaView();
               }

               ),
             ),

            )
            ),
            SizedBox(height: 15,),
            Container(
              width:200,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:Color(0xFFFFCB77) ,
                  foregroundColor: Colors.white,
                  elevation: 6,
                  shadowColor: Color(0xFFFFCB77).withOpacity(0.6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16),
                  textStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddList()),
                  );
                },
                child: Text('Crea Prodotto'),
              ),
            ),

          ],



        ),

      ),

      floatingActionButton:FloatingActionButton.extended(
        onPressed: (){},

          elevation: 6,
          backgroundColor: Color(0xFFFE6D73),
          foregroundColor: Color(0xFFFEF9EF),
       //   shadowColor: Color(0xFFFE6D73).withOpacity(0.6),
        icon: Icon(
          Icons.add, color:
        Color(0xFFFEF9EF),
        ),
        label: Text("Crea", style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
      )
    );

  }



}