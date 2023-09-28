import 'package:dictionary/app/data/databases/data_base.dart';
import 'package:sqflite/sqflite.dart';
import 'package:dictionary/app/data/models/word_history_model.dart';
import 'package:dictionary/app/data/interfaces/word_history_interface.dart';

class WordHistoryService implements WordHistoryInterface {
  Database? _db;

  @override
  Future<bool> add(WordHistoryModel wordHistory) async {
    _db = await DBSet.instance.database;
    if (_db == null) return false;

    int de = await _db?.rawInsert(
      "INSERT INTO wordHistory (idUser, idWord, lastAcess, favorite) VALUES (?,?,?,?)", 
      [wordHistory.idUser , wordHistory.idWord , wordHistory.lastAcess , wordHistory.favorite]
    ) ?? 0;
    
    return de != 0;
  }

  @override
  Future<bool> update(WordHistoryModel wordHistory) async {
    _db = await DBSet.instance.database;
    if (_db == null) return false;

    int de = await _db?.rawUpdate(
      "UPDATE wordHistory SET idUser = ?, idWord = ?, lastAcess = ?, favorite = ? WHERE id = ?", 
      [wordHistory.idUser , wordHistory.idWord , wordHistory.lastAcess , wordHistory.favorite, wordHistory.id]
    ) ?? 0;
    
    return de != 0;
  }

  @override
  Future<bool> delete(int idWordHistory) async {
    _db = await DBSet.instance.database;
    if (_db == null) return false;

    int de = await _db?.rawDelete(
      "DELETE FROM wordHistory WHERE id = ?", 
      [idWordHistory]
    ) ?? 0;
    
    return de != 0;
  }

  @override
  Future<List<WordHistoryModel>> get({int? idUser}) async {
    _db = await DBSet.instance.database;
    if (_db == null) return [];

    List<Map<String, dynamic>> result = await _db?.query("wordHistory") ?? [];

    print(result);

    return [];
  }
}