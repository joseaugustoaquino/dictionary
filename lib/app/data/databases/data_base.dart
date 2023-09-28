import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBSet {
  DBSet._();
  
  /// Criar a instancia do DBSet
  static final DBSet instance = DBSet._();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    return await _initDatabase();
  }

  _initDatabase() async => await openDatabase(
    join(await getDatabasesPath(), 'dictionary.db'),
    version: 1,
    onCreate: _onCreate,
  );

  _onCreate(Database db, int version) async {
    await db.execute(_users);
    await db.execute(_words);
    await db.execute(_wordHistory);
  }

  String get _users => '''
    CREATE TABLE IF NOT EXISTS users (
      id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      name VARCHAR(100) NOT NULL,
      user VARCHAR(100) NOT NULL,
      password VARCHAR(100) NOT NULL
    );
  ''';

  String get _words => '''
    CREATE TABLE IF NOT EXISTS words (
      id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      description VARCHAR(100) NOT NULL
    );
  ''';

  String get _wordHistory => '''
    CREATE TABLE wordHistory (
      id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      idUser INT NOT NULL,
      idWord INT NOT NULL,
      lastAcess DATETIME NOT NULL,
      favorite BIT NOT NULL
    );
  ''';
}