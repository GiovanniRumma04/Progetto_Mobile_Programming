
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

          CREATE TABLE spese (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            lista_id INTEGER NOT NULL,
            prodotto_id INTEGER NOT NULL,
            quantita INTEGER NOT NULL CHECK(quantita > 0),
            data TEXT NOT NULL,
            PRIMARY KEY (lista_id, prodotto_id, id),
            FOREIGN KEY (lista_id) REFERENCES liste(id) ON DELETE CASCADE,
            FOREIGN KEY (prodotto_id) REFERENCES prodotti(id) ON DELETE CASCADE
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
            PRIMARY KEY (lista_nome, prodotto_nome),
            FOREIGN KEY (lista_nome) REFERENCES liste(nome) ON DELETE CASCADE,
            FOREIGN KEY (prodotto_nome) REFERENCES prodotti(nome) ON DELETE CASCADE
          );
          '''
        );
      },
      version: 1,
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

    final categoria = await db.query(
        'categorie',
        where: 'nome = ?',
        whereArgs: [p.c.nomeCategoria]
    );

    if (categoria.isEmpty) insertCategoria(p.c);

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


  }

  Future<void> cancellaLista(ListaSpese l)async {
    final db = await database;

    final exists = db.delete(
      'liste',
      where: 'nome = ?',
      whereArgs: [l.nomeLista],
    );
  }

  Future<void> modificaSpesa(ListaSpese oldLista, ListaSpese newLista) async{

  }
}