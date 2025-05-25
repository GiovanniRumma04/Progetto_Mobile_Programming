import 'package:flutter/material.dart';
import 'package:gestore_spese/View/AddList.dart';

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
      Shadow(color: Colors.black38, offset: Offset(1, 1), blurRadius: 2)
    ],
  );
  int? _selectedChip;
  final double _radius = 12.0;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final formattedDate = '${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year}';

    return  Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Crea Lista" , style:  sectionTitleStyle,),
            SizedBox(height: 20,),
            SizedBox(
              width: 200,
              child: TextField(
                controller: _controller,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  labelText: 'Nome Lista',
                  labelStyle: TextStyle(color: fieldBorderColor),
                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: fieldBorderColor, width: 1.5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: fieldBorderColor.withOpacity(0.7)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: fieldBorderColor, width: 2),
                  ),
                ),
              ),
            ),

            SizedBox(height: 16),

              SizedBox(
              height: 70,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  children: [
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: List.generate(5, (index) {
                        return ChoiceChip.elevated(
                          elevation: 8,
                          backgroundColor: baseColor.withOpacity(0.5),
                          shadowColor: baseColor.withOpacity(0.5),
                          selectedShadowColor: baseColor,
                          selectedColor: baseColor,

                          label: Text(
                            'Categoria $index',
                            style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          selected: _selectedChip == index,
                          onSelected: (selected) {
                            setState(() {
                              _selectedChip = selected ? index : null;
                            });
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(_radius),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
            Container(
                width:250,
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
                      MaterialPageRoute(builder: (context) => AddList()),
                    );
                  },
                  child: Text('Crea Categoria'),
                ),
            ),
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
                      padding: EdgeInsets.symmetric(vertical: 13 ),
                      textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddList()),
                      );
                    },
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
