import 'package:flutter/material.dart';
import 'package:gestore_spese/Model/GestoreApp.dart';
import 'package:gestore_spese/View/HomeView.dart';
import 'package:provider/provider.dart';

import 'View/ListeView.dart';

void main() {

  runApp( MyApp());
}

class MyApp extends StatefulWidget {
   MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Color primaryBackgroundColor = Color(0xFF227C9D);
 // AppBar, sfondi
  final Color cardBackgroundColor = Color(0xFFFEF9EF);
    // Schede
  final Color buttonColor = Color(0xFFFE6D73);
             // Bottoni
  final Color buttonTextColor = Color(0xFFFEF9EF);
         // Testo bottoni
  final Color accentColor = Color(0xFFFFCB77);
             // Sottotitoli
  final Color textButtonColor = Color(0xFF17C3B2);
         // Testo tipo link
  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
     create: (context) => GestoreApp(),
      child: MaterialApp(
        theme: ThemeData(

        ),
        home: MainNavigation(),
      ),
    );
  }
}

class MainNavigation extends StatefulWidget{
  @override
  State<MainNavigation> createState() => _MainNavigation();
}

class _MainNavigation extends State<MainNavigation> {

  int _selectedIndex = 0;


  final List<Widget> _screens = [
    HomeView(),
    ListeView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

    @override
    Widget build(BuildContext context) {
      return Scaffold(

          body: _screens[_selectedIndex],

          bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped, // aggiorna l'indice e ridisegna
      items: const [
      BottomNavigationBarItem(
      icon: Icon(Icons.shopping_bag),
      label: "Prodotti",
      ),
      BottomNavigationBarItem(
      icon: Icon(Icons.shopping_cart),
      label: "Liste",
      ),
      ],
      ),
      );
    }
  }






