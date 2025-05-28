import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Model/Categoria.dart';
import '../Model/GestoreApp.dart';

class CreaCategoriaView extends StatefulWidget {
  const CreaCategoriaView({super.key});

  @override
  State<CreaCategoriaView> createState() => _CreaCategoriaViewState();
}

class _CreaCategoriaViewState extends State<CreaCategoriaView> {
  final _formKey = GlobalKey<FormState>();
  String? nomeCategoria;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Crea Categoria"),
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
              "Crea Categoria",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            Form(
              key: _formKey,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50), // Changed to make the form oval
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
                    hintText: "Nome Categoria",
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 15,
                    ),
                    border: InputBorder.none,
                  ),
                  textAlign: TextAlign.center,
                  validator: (value) => value == null || value.isEmpty
                      ? "Campo obbligatorio"
                      : null,
                  onSaved: (value) => nomeCategoria = value,
                ),
              ),
            ),
            const SizedBox(height: 50),
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
                      Categoria nuova = Categoria(nomeCategoria ?? "Senza Nome");
                      Provider.of<GestoreApp>(context, listen: false).creaCategoria(nuova);
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
    );
  }
}
