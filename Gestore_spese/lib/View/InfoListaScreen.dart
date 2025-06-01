import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gestore_spese/Model/GestoreApp.dart';
import 'package:gestore_spese/View/AddList.dart';
import 'package:gestore_spese/View/CreaCategoriaView.dart';
import 'package:provider/provider.dart';

import '../Model/ListaSpese.dart';

class InfoListaScreen extends StatefulWidget {
  @override
  State<InfoListaScreen> createState() => _InfoListaScreenState();
}

class _InfoListaScreenState extends State<InfoListaScreen> {
  final Color baseColor = Color(0xFFFFCB77);
  final Color textColor = Color(0xFFFFFFFF); // white for chips
  final Color chipSelectedColor = Color(0xFFF96E5A); // selected chip color
  final Color fieldBorderColor = Color(0xFF2279CD);
  final Color buttonColor = Color(0xFFFE6D73);
  final Color buttonTextColor = Color(0xFFFEF9EF);
  final TextStyle sectionTitleStyle = TextStyle(
    fontSize: 35,
    fontWeight: FontWeight.bold,
    shadows: [
      Shadow(color: Colors.black38, offset: Offset(1, 1), blurRadius: 2),
    ],
  );
  int? _selectedChip;
  final double _radius = 12.0;
  final TextEditingController _controller = TextEditingController();
  bool _isButtonEnabled = false;

  @override
  void initState(){
    super.initState();
    _controller.addListener(() {
      setState(() {
        _isButtonEnabled = _controller.text.trim().isNotEmpty;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final formattedDate =
        '${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year}';
    final appProvider = Provider.of<GestoreApp>(context);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Crea Lista", style: sectionTitleStyle),
          SizedBox(height: 20),
          SizedBox(
            width: 200,
            child: TextField(

              inputFormatters: [
                LengthLimitingTextInputFormatter(30),
              ],
              controller: _controller,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                labelText: 'Nome Lista',
                labelStyle: TextStyle(color: fieldBorderColor),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 10,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: fieldBorderColor, width: 1.5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: fieldBorderColor.withOpacity(0.7),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: fieldBorderColor, width: 2),
                ),
              ),
            ),
          ),

          SizedBox(height: 16),


          SizedBox(height: 16),

          SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 150,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    foregroundColor: textColor,
                    elevation: 8,
                    shadowColor: buttonColor.withOpacity(0.6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(_radius),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 13),
                    textStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: _isButtonEnabled
                      ?() {

                    if(appProvider.tutteLeListe.contains(ListaSpese(_controller.text))){
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Lista già esistente"),
                          duration: Duration(seconds: 2),
                          backgroundColor: Colors.black,
                        ),
                      );
                    }else{
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddList(nome: _controller.text),
                        ),
                      );
                    }

                  }: null,
                  child: Text('Avanti'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class blocchiCategorie extends StatefulWidget {
  final GestoreApp appProvider;
  final Color baseColor;
  final Color textColor;

  blocchiCategorie({
    Key? key,
    required this.appProvider,
    required this.baseColor,
    required this.textColor,
  }) : super(key: key);

  @override
  _BlocchiCategorieState createState() => _BlocchiCategorieState();
}

class _BlocchiCategorieState extends State<blocchiCategorie> {
  int? _selectedChip;

  String testoCategoria(int index) {
    if (widget.appProvider.categorie.isEmpty) {
      return "Nessuna Categoria";
    } else {
      return widget.appProvider.categorie[index].nomeCategoria;
    }
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<GestoreApp>(context);
    return SizedBox(
      height: 70,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          children: [
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(widget.appProvider.categorie.length, (
                index,
              ) {
                return ChoiceChip.elevated(
                  elevation: 8,
                  backgroundColor: widget.baseColor.withOpacity(0.5),
                  shadowColor: widget.baseColor.withOpacity(0.5),
                  selectedShadowColor: widget.baseColor,
                  selectedColor: widget.baseColor,
                  label: Text(
                    testoCategoria(index),
                    style: TextStyle(
                      color: widget.textColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  selected: _selectedChip == index,
                  onSelected: (selected) {
                    setState(() {
                      _selectedChip = selected ? index : null;
                      appProvider.indiceCategoria = _selectedChip!;
                    });
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
