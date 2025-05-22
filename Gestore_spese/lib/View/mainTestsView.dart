/*Test di visualizzazione di SpesaProdottoView.dart*/
import 'package:flutter/material.dart';
import 'SpesaProdottoView.dart';
import '../Model/Spesa.dart';
import '../Model/Prodotto.dart';
import '../Model/Categoria.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        //appBar: AppBar(title: Text('Test Widget')),
        body: Center(
          child: SpesaProdottoView(
            true,
            Spesa(
              Prodotto(
                'Biscotti',
                9.00,
                Categoria(
                  'Alimentari',
                ),
                'Ogni pezzo è un pacco di biscotti da 200g.',
              ),
              DateTime(2025, 5, 22),
              3,
            ),
          ),
        ),
      ),
    ),
  );
}