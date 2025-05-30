import 'package:flutter/material.dart';
import 'package:gestore_spese/Model/GestoreApp.dart';
import 'package:gestore_spese/Model/ListaSpese.dart';
import 'package:gestore_spese/Model/Spesa.dart';
import 'package:gestore_spese/View/SpesaProdottoView.dart';
import 'package:provider/provider.dart';

class ListaView extends StatefulWidget {
  final ListaSpese l;
  final indexL;

  const ListaView({super.key, required this.l, this.indexL});

  @override
  State<ListaView> createState() => _ListaViewState();
}

class _ListaViewState extends State<ListaView> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<GestoreApp>(context);
    final speseFiltrate = getFilteredSpese(widget.l, query);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF227C9D),
        title: Text(widget.l.nomeLista, style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Container(
        color: Color(0xFFFFCB77),
        padding: EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    query = value;
                  });
                },
                decoration: InputDecoration(
                  icon: Icon(Icons.search, color: Colors.black54),
                  hintText: "Ricerca...",
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text('Dettagli Lista: '),
            Text('Data di Creazione: ${widget.l.stampaData()}'),
            Text(
              'Totale: ' + widget.l.spesaTotale.toStringAsFixed(2) + "€",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            Flexible(
              child: ListView.builder(
                itemCount: speseFiltrate.length,
                itemBuilder: (context, index) {
                  return CustomCards(s: speseFiltrate[index], indexList: widget.indexL, indexSpesa: index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Spesa> getFilteredSpese(ListaSpese l, String query) {
    if (query.isEmpty) return l.lista;
    return l.lista.where((s) => s.p.nomeprodotto.toLowerCase().contains(query.toLowerCase())).toList();
  }
}

class CustomCards extends StatefulWidget {
  final Spesa s;
  final int indexSpesa;
  final int indexList;

  const CustomCards({super.key, required this.s, required this.indexList, required this.indexSpesa});

  @override
  State<CustomCards> createState() => _CustomCardsState();
}

class _CustomCardsState extends State<CustomCards> {
  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<GestoreApp>(context);
    return Container(
      height: 170,
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 8,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.s.p.nomeprodotto,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    fontFamily: 'Roboto',
                  ),
                ),
                Text(
                  'Data Spesa: ${widget.s.stampaData()}',
                  style: TextStyle(fontWeight: FontWeight.w300),
                ),
                Text(
                  'Prezzo unitario: ' + widget.s.p.prezzo.toStringAsFixed(2) + "€",
                  style: TextStyle(fontWeight: FontWeight.w300),
                ),
                Text(
                  'Quantità: ${widget.s.quantita}',
                  style: TextStyle(fontWeight: FontWeight.w300),
                ),
                Text(
                  'Costo: ' + (widget.s.p.prezzo * widget.s.quantita).toStringAsFixed(2) + "€",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SpesaProdottoView(true, widget.s.p, quantita: widget.s.quantita),
                    ),
                  );
                },
                icon: Icon(Icons.arrow_forward_ios),
              ),
              IconButton(
                onPressed: () async {
                  final updatedData = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SpesaProdottoView(false, widget.s.p, quantita: widget.s.quantita),
                    ),
                  );
                  if (updatedData != null) {
                    setState(() {
                      widget.s.p.nomeprodotto = updatedData['nome'];
                      widget.s.p.prezzo = updatedData['prezzo'];
                      widget.s.p.note = updatedData['note'];
                      widget.s.quantita = updatedData['quantita'];

                      final appProvider = Provider.of<GestoreApp>(context, listen: false);
                      appProvider.updateProductAndExpenses(widget.s.p, widget.s.quantita);
                    });
                  }
                },
                icon: Icon(Icons.edit, color: Colors.green),
              ),
              Row(
                children: [
                  Text(
                    'Acquistato',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  Checkbox(
                    value: widget.s.acquistato,
                    onChanged: (value) => setState(() {
                      widget.s.acquistato = !widget.s.acquistato;
                    }),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
