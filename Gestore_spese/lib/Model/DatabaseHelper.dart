
import 'package:gestore_spese/Model/Categoria.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'ListaSpese.dart';
import 'Prodotto.dart';
import 'Spesa.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'mio_database.db'),
      onCreate: (db, version) async {
        return db.execute(
            '''
          CREATE TABLE categorie (
            nome TEXT PRIMARY KEY
          );

          CREATE TABLE prodotti (
            nome TEXT PRIMARY KEY,
            prezzo REAL NOT NULL,
            note TEXT,
            categoria_nome TEXT NOT NULL,
            FOREIGN KEY (categoria_nome) REFERENCES categorie(nome) ON DELETE CASCADE
          );

          CREATE TABLE liste (
            nome TEXT PRIMARY KEY,
            data_creazione TEXT NOT NULL
          );

          CREATE TABLE spese (
            lista_nome TEXT NOT NULL,
            prodotto_nome TEXT NOT NULL,
            quantita INTEGER NOT NULL CHECK(quantita > 0),
            data TEXT NOT NULL,
            acquistato INTEGER NOT NULL DEFAULT 0,
            PRIMARY KEY (lista_nome, prodotto_nome),
            FOREIGN KEY (lista_nome) REFERENCES liste(nome) ON DELETE CASCADE,
            FOREIGN KEY (prodotto_nome) REFERENCES prodotti(nome) ON DELETE CASCADE
          );
          '''
        );
      },
      version: 2,
    );
  }

  Future<void> insertCategoria(Categoria c) async {
    final db = await database;

    await db.insert(
      'categorie',
      {
        'nome': c.nomeCategoria,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertProdotto(Prodotto p)async{
    final db = await database;

    insertCategoria(p.c);

    await db.insert(
      'prodotti',
      {
        'nome': p.nomeprodotto,
        'prezzo': p.prezzo,
        'note': p.note,
        'categoria_nome': p.c.nomeCategoria,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertLista(ListaSpese l) async{
    final db = await database;

    await db.insert(
      'liste',
      {
        'nome': l.nomeLista,
        'data_creazione': l.datacreazione.toString(),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    for (var spesa in l.lista){
      insertProdotto(spesa.p);

      await db.insert(
        'spese',
        {
          'lista_nome': l.nomeLista,
          'prodotto_nome': spesa.p.nomeprodotto,
          'quantita': spesa.quantita,
          'data': spesa.data.toString(),
          'acquistato': spesa.acquistato ? 1 : 0,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<void> cancellaLista(ListaSpese l)async {
    final db = await database;

    final exists = db.delete(
      'liste',
      where: 'nome = ?',
      whereArgs: [l.nomeLista],
    );
  }

  Future<void> modificaSpesa(ListaSpese lista, Spesa oldSpesa, Spesa newSpesa) async{
    final db = await database;

    await db.delete(
      'spese',
      where: 'lista_nome = ? AND prodotto_nome = ?',
      whereArgs: [lista.nomeLista, oldSpesa.p.nomeprodotto]
    );

    await db.insert(
      'spese',
      {
        'lista_nome': lista.nomeLista,
        'prodotto_nome': newSpesa.p.nomeprodotto,
        'quantita': newSpesa.quantita,
        'data': newSpesa.data.toString(),
        'acquistato': newSpesa.acquistato ? 1 : 0,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}