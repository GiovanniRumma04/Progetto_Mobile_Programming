import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return Scaffold(

     appBar: AppBar(
       title: Text("HOME"),
     ),
     body: Column(

       children: [

         TextField(
           style:TextStyle(

           ) ,

         ),

         SizedBox(height: 10,),

         Row(

           children: [


             Text("PRODOTTI RECENTI"),
             TextButton(onPressed: (){}, child: Text("ALTRO")),
             SizedBox(height: 15,),





           ],
         )

       ],






     ),


   );



  }




}