
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'mio_database.db'),
      onCreate: (db, version) {
        return db.execute(
          '''
          CREATE TABLE categorie (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          nome TEXT NOT NULL UNIQUE,
          num_spese INTEGER NOT NULL
          );
          '''
        );
      },
      version: 1,
    );
  }

  Future<void> insertUtente(Utente utente) async {
    final db = await database;
    await db.insert(
      'utenti',
      utente.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

'''

CREATE TABLE prodotti (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  nome TEXT NOT NULL,
  prezzo REAL NOT NULL,
  note TEXT,
  categoria_id INTEGER NOT NULL,
  FOREIGN KEY (categoria_id) REFERENCES categorie(id) ON DELETE CASCADE
);

CREATE TABLE spese (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  prodotto_id INTEGER NOT NULL,
  quantita INTEGER NOT NULL CHECK(quantita > 0),
  data TEXT NOT NULL,
  FOREIGN KEY (prodotto_id) REFERENCES prodotti(id) ON DELETE CASCADE
);

CREATE TABLE liste (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  nome TEXT NOT NULL,
  data_creazione TEXT NOT NULL
);

CREATE TABLE lista_spese (
  lista_id INTEGER NOT NULL,
  spesa_id INTEGER NOT NULL,
  PRIMARY KEY (lista_id, spesa_id),
  FOREIGN KEY (lista_id) REFERENCES liste(id) ON DELETE CASCADE,
  FOREIGN KEY (spesa_id) REFERENCES spese(id) ON DELETE CASCADE
);
''';

}