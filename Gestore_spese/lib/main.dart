import 'package:flutter/material.dart';
import 'package:gestore_spese/Model/GestoreApp.dart';
import 'package:gestore_spese/View/HomeView.dart';
import 'package:provider/provider.dart';

void main() {

  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});
  final Color primaryBackgroundColor = Color(0xFF227C9D); // AppBar, sfondi
  final Color cardBackgroundColor = Color(0xFFFEF9EF);    // Schede
  final Color buttonColor = Color(0xFFFE6D73);             // Bottoni
  final Color buttonTextColor = Color(0xFFFEF9EF);         // Testo bottoni
  final Color accentColor = Color(0xFFFFCB77);             // Sottotitoli
  final Color textButtonColor = Color(0xFF17C3B2);         // Testo tipo link

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
     create: (context) => GestoreApp(),
      child: MaterialApp(
        theme: ThemeData(

        ),
        home: HomeView(),
      ),
    );
  }
}



