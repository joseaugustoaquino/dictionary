import 'package:dictionary/app/data/databases/data_base.dart';
import 'package:sqflite/sqflite.dart';
import 'package:dictionary/app/data/models/word_model.dart';
import 'package:dictionary/app/data/interfaces/word_interface.dart';

class WordProvider implements WordInterface {
  Database? _db;
  
  @override
  Future<bool> add(WordModel word) async {
    _db = await DBSet.instance.database;
    if (_db == null) return false;

    int de = await _db?.rawInsert(
      "INSERT INTO words (description) VALUES (?)", 
      [word.description]
    ) ?? 0;
    
    return de != 0;
  }

  @override
  Future<bool> update(WordModel word) async {
    _db = await DBSet.instance.database;
    if (_db == null) return false;

    int de = await _db?.rawUpdate(
      "UPDATE words SET description = ? WHERE id = ?", 
      [word.description, word.id]
    ) ?? 0;
    
    return de != 0;
  }
  
  @override
  Future<bool> delete(int idWord) async {
    _db = await DBSet.instance.database;
    if (_db == null) return false;

    int de = await _db?.rawDelete(
      "DELETE FROM words WHERE id = ?", 
      [idWord]
    ) ?? 0;
    
    return de != 0;
  }

  @override
  Future<List<WordModel>> get() async {
    _db = await DBSet.instance.database;
    if (_db == null) return [];

    List<Map<String, dynamic>> result = await _db?.query("words") ?? [];
    return result.map((m) => WordModel(
      id: m["id"],
      description: m["description"],
    )).toList();
  }

  @override
  Future<WordModel?> getById(int idWord) async {
    _db = await DBSet.instance.database;
    if (_db == null) return null;

    List<Map<String, dynamic>> result = await _db?.rawQuery('''
      SELECT * FROM words
      WHERE id = ?;
    ''', [idWord]) ?? [];


    return result.isEmpty ? null : WordModel.fromMap(result.first);
  }
  
  @override
  Future<WordModel?> getByDescription(String word) async {
    _db = await DBSet.instance.database;
    if (_db == null) return null;

    List<Map<String, dynamic>> result = await _db?.rawQuery('''
      SELECT * FROM words
      WHERE description = ?;
    ''', [word]) ?? [];


    return result.isEmpty ? null : WordModel.fromMap(result.first);
  } 
}