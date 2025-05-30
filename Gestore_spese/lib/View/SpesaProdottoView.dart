import 'package:flutter/material.dart';
import '../Model/Prodotto.dart';
import '../Model/Spesa.dart';

class SpesaProdottoView extends StatefulWidget {
  final bool isReadOnly;
  final Prodotto prodotto;
  final int quantita;

  const SpesaProdottoView(this.isReadOnly, this.prodotto, {this.quantita = 1, super.key});

  @override
  State<SpesaProdottoView> createState() => _SpesaProdottoViewState();
}

class _SpesaProdottoViewState extends State<SpesaProdottoView> {
  late TextEditingController nomeController;
  late TextEditingController prezzoController;
  late TextEditingController noteController;
  late int quantita;

  @override
  void initState() {
    super.initState();
    nomeController = TextEditingController(text: widget.prodotto.nomeprodotto);
    prezzoController = TextEditingController(text: widget.prodotto.prezzo.toStringAsFixed(2));
    noteController = TextEditingController(text: widget.prodotto.note);
    quantita = widget.quantita;
  }

  void saveChanges() {
    setState(() {
      widget.prodotto.nomeprodotto = nomeController.text;
      widget.prodotto.prezzo = double.tryParse(prezzoController.text) ?? widget.prodotto.prezzo;
      widget.prodotto.note = noteController.text;
    });
    Navigator.pop(context, {
      'nome': widget.prodotto.nomeprodotto,
      'prezzo': widget.prodotto.prezzo,
      'note': widget.prodotto.note,
      'quantita': quantita,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isReadOnly ? "Dettaglio Prodotto" : "Modifica Prodotto"),
        backgroundColor: Color(0xFF227C9D),
      ),
      body: Container(
        color: Color(0xFFFFCB77),
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              margin: EdgeInsets.only(bottom: 32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: nomeController,
                enabled: !widget.isReadOnly,
                decoration: InputDecoration(
                  labelText: "Nome Prodotto",
                  labelStyle: TextStyle(color: Colors.black54),
                  border: InputBorder.none,
                ),
                style: TextStyle(fontSize: 20),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              margin: EdgeInsets.only(bottom: 32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: prezzoController,
                enabled: !widget.isReadOnly,
                decoration: InputDecoration(
                  labelText: "Prezzo (€)",
                  labelStyle: TextStyle(color: Colors.black54),
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.number,
                style: TextStyle(fontSize: 20),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              margin: EdgeInsets.only(bottom: 32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: noteController,
                enabled: !widget.isReadOnly,
                decoration: InputDecoration(
                  labelText: "Note",
                  labelStyle: TextStyle(color: Colors.black54),
                  border: InputBorder.none,
                ),
                style: TextStyle(fontSize: 20),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Quantità: $quantita", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                if (!widget.isReadOnly)
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove_circle_outline, color: Color(0xFF227C9D)),
                        onPressed: () {
                          setState(() {
                            if (quantita > 1) quantita--;
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.add_circle_outline, color: Color(0xFF227C9D)),
                        onPressed: () {
                          setState(() {
                            quantita++;
                          });
                        },
                      ),
                    ],
                  ),
              ],
            ),
            SizedBox(height: 32),
            if (!widget.isReadOnly)
              ElevatedButton(
                onPressed: saveChanges,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF17C3B2), // Green color for save
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 30),
                ),
                child: Text(
                  "Salva Modifica",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
          ],
        ),
      ),
    );
  }
}