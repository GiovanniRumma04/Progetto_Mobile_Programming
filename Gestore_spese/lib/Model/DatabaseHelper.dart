
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
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  nome TEXT NOT NULL UNIQUE
);
          
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
  lista_id INTEGER NOT NULL,
  prodotto_id INTEGER NOT NULL,
  quantita INTEGER NOT NULL CHECK(quantita > 0),
  data TEXT NOT NULL,
  PRIMARY KEY (lista_id, prodotto_id, id),
  FOREIGN KEY (lista_id) REFERENCES liste(id) ON DELETE CASCADE,
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
          '''
        );

      },
      version: 1,
    );
  }

  

  Future<void> insertCategorie(Categoria c) async{
    final db = await database;

    await db.insert('categorie', {'nome': c.nomeCategoria}, conflictAlgorithm: ConflictAlgorithm.replace);

    for(Map<String, Object?> p in await db.query('categorie')){
      print(p.toString());
    }
  }

  Future<void> insertProdotto(Prodotto p)async{
    final db = await database;
    await db.query('categoria', where: 'nome=?');
    await db.insert('prodotti', {'nome':p.nomeprodotto,});
  }

  Future<void> insertLista(ListaSpese l) async{
    final db = await database;
  }

  Future<void> cancellaLista(ListaSpese l)async{

  }

  Future<void> insertSpese(Spesa s) async{

  }

/*  Future<List<Categoria>> getCategorie() async{



  }

  Future<List<dynamic>> getProdotti(List<Categoria> l) async{

  }

  Future<List<dynamic>> getListeSpese(Prodotto p) async{

  }


  Future<void> modificaSpesa(ListaSpese old, ListaSpese new) async{

  }
*/
}