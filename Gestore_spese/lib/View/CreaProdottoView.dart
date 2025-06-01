import 'package:flutter/material.dart';
import '../Model/Prodotto.dart';
import '../Model/GestoreApp.dart';
import '../Model/Categoria.dart'; // Import necessario per creare oggetti Categoria
import 'package:provider/provider.dart';// Per accedere a GestoreApp
import 'package:gestore_spese/View/InfoListaScreen.dart';

import 'CreaCategoriaView.dart';
class CreaProdottoView extends StatefulWidget {
  const CreaProdottoView({super.key});

  @override
  State<CreaProdottoView> createState() => _CreaProdottoViewState();
}

class _CreaProdottoViewState extends State<CreaProdottoView> {
  final _formKey = GlobalKey<FormState>();

  String? nomeProdotto;
  String? categoria;
  double? prezzo;
  String? note;

  final Color baseColor = Color(0xFFFFCB77);
  final Color textColor = Color(0xFFFFFFFF);
  int? _selectedChip;
  final double _radius = 12.0;
  final Color buttonColor = Color(0xFFFE6D73);


  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<GestoreApp>(context);
    final categorie = Provider.of<GestoreApp>(context).categorie;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Crea Prodotto"),
        backgroundColor: const Color(0xFF227C9D),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            const Text(
              "Crea Prodotto",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            Form(
              key: _formKey,
              child: Expanded(
                child: ListView(
                  children: [
                    // Campo Nome Prodotto
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: "Nome Prodotto",
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 20,
                          ),
                          border: InputBorder.none,
                        ),
                        validator: (value) => value == null || value.isEmpty
                            ? "Campo obbligatorio"
                            : null,
                        onSaved: (value) => nomeProdotto = value,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Campo Categoria
                    /*DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: "Categoria",
                        border: OutlineInputBorder(),
                      ),
                     items: [
                  ...categorie.map((cat) => DropdownMenuItem(
                      value: cat.nomeCategoria,
                      child: Text(cat.nomeCategoria),
                    )),
                const DropdownMenuItem(
                  value: 'NUOVA_CATEGORIA',
                  child: Text("➕ Nuova Categoria"),
                ),
              ],

                      onChanged: (value) async {
  if (value == 'NUOVA_CATEGORIA') {
    final nuova = await _mostraDialogNuovaCategoria(context);
    if (nuova != null && nuova.isNotEmpty) {
      setState(() {
        categoria = nuova;
        print(categorie);
      });
    }
  } else {
    setState(() {
      categoria = value;
    });
  }
},

                      validator: (value) =>
                          value == null || value.isEmpty ? "Campo obbligatorio" : null,
                    ),*/

                    blocchiCategorie(appProvider: appProvider, baseColor:  baseColor, textColor:  textColor),
                    Container(
                      width: 250,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: baseColor,
                          foregroundColor: textColor,
                          elevation: 6,
                          shadowColor: buttonColor.withOpacity(0.6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(_radius),
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
                            MaterialPageRoute(builder: (context) => CreaCategoriaView()),
                          );
                        },
                        child: Text('Crea Categoria'),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Campo Prezzo
                    TextFormField(
                      decoration: const InputDecoration(labelText: "Prezzo"),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Campo obbligatorio";
                        }
                        if (double.tryParse(value) == null) {
                          return "Inserisci un numero valido";
                        }
                        return null;
                      },
                      onSaved: (value) =>
                          prezzo = value != null && value.isNotEmpty ? double.parse(value) : null,
                    ),
                    const SizedBox(height: 20),

                    // Campo Note
// Campo Note
TextFormField(
  decoration: const InputDecoration(
    labelText: "Note",
    alignLabelWithHint: true, // <--- Sposta la label in alto
    border: OutlineInputBorder(),
  ),
  maxLines: 5,
  onSaved: (value) => note = value,
),
const SizedBox(height: 30),

                  

                    // Pulsanti
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF17C3B2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 15,
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();

                              // Creazione della categoria (se non esiste, usa una generica)

                                categoria = appProvider.categorie[appProvider.indiceCategoria].nomeCategoria;


                              Categoria categoriaObj = Categoria(categoria ?? "Generica");

                              // Creazione del prodotto
                              
                              Prodotto nuovo = Prodotto(
                                nomeProdotto ?? "",
                                prezzo ?? 0.0,
                                categoriaObj,
                                note ?? "Nessuna nota",

                              );



                              // Aggiunta del prodotto tramite GestoreApp
                              Provider.of<GestoreApp>(context, listen: false).creaProd(nuovo);


                              // Torna indietro
                              Navigator.pop(context);
                            }
                          },
                          child: const Text("Conferma"),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 15,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Annulla"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<String?> _mostraDialogNuovaCategoria(BuildContext context) async {
  final _categoriaController = TextEditingController();

  return showDialog<String>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Nuova Categoria"),
        content: TextField(
          controller: _categoriaController,
          decoration: const InputDecoration(hintText: "Nome Categoria"),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Chiude senza tornare nulla
            },
            child: const Text("Annulla"),
          ),
          TextButton(
            onPressed: () {
              final nome = _categoriaController.text.trim();
              if (nome.isNotEmpty) {
                final nuovaCategoria = Categoria(nome);
                Provider.of<GestoreApp>(context, listen: false).creaCategoria(nuovaCategoria);
                Navigator.pop(context, nome); // Ritorna il nome della nuova categoria
              }
            },
            child: const Text("Salva"),
          ),
        ],
      );
    },
  );
}

}