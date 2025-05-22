import 'package:gestore_spese/Model/ListaSpese.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseManager {
  DatabaseManager._privateConstructor();
  static final DatabaseManager instance = DatabaseManager._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'gestorespeseDB.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE Lista(id INTEGER PRIMARY KEY Auto Increment, nomelista TEXT, numelementi INTEGER, spesatotale double)'
              'CREATE Table Spesa (id Integer Primary Key Auto Increment, nomeprodotto TEXT',
        );
      },
      version: 1,
    );
  }

  Future<List<Map<String, Object?>>> ottieniElementi() async {
    return _database!.query('Lista');
  }

  Future<void> insertLista(ListaSpese l) async {
    final db = await database;
    await db.insert(
      'Lista',
      l as Map<String, Object?>,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

}
