import 'package:dictionary/app/data/databases/data_base.dart';
import 'package:dictionary/app/data/models/user_model.dart';
import 'package:dictionary/app/data/models/word_model.dart';
import 'package:dictionary/app/data/providers/user_provider.dart';
import 'package:dictionary/app/data/providers/word_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:dictionary/app/data/models/word_history_model.dart';
import 'package:dictionary/app/data/interfaces/word_history_interface.dart';

class WordHistoryProvider implements WordHistoryInterface {
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
  Future<List<WordHistoryModel>> get() async {
    _db = await DBSet.instance.database;
    if (_db == null) return [];

    List<Map<String, dynamic>> result = await _db?.query("wordHistory") ?? [];

    List<UserModel> resultUsers = await UserProvider().get();
    List<WordModel> resultWords = await WordProvider().get();

    return result.map((m) => WordHistoryModel(
      id: m["id"],
      idUser: m['idUser'], 
      idWord: m['idWord'], 
      lastAcess: m['lastAcess'], 
      favorite: m['favorite'], 
      user: resultUsers.singleWhere((s) => s.id == m['idUser'], orElse: () => UserModel()), 
      word: resultWords.singleWhere((s) => s.id == m['idWord'], orElse: () => WordModel()),
    )).toList();
  }

  @override
  Future<WordHistoryModel?> getById(int idWordHistory) async {
    _db = await DBSet.instance.database;
    if (_db == null) return null;

    List<Map<String, dynamic>> result = await _db?.rawQuery('''
      SELECT * FROM wordHistory
      WHERE id = ?;
    ''', [idWordHistory]) ?? [];


    return result.isEmpty ? null : WordHistoryModel.fromMap(result.first);
  }
  
  @override
  Future<List<WordHistoryModel>> getByUser(int idUser) async {
    _db = await DBSet.instance.database;
    if (_db == null) return [];

    List<Map<String, dynamic>> result = await _db?.query("wordHistory") ?? [];

    List<UserModel> resultUsers = await UserProvider().get();
    List<WordModel> resultWords = await WordProvider().get();

    return result.map((m) => WordHistoryModel(
      id: m["id"],
      idUser: m['idUser'], 
      idWord: m['idWord'], 
      lastAcess: m['lastAcess'], 
      favorite: m['favorite'], 
      user: resultUsers.singleWhere((s) => s.id == m['idUser'], orElse: () => UserModel()), 
      word: resultWords.singleWhere((s) => s.id == m['idWord'], orElse: () => WordModel()),
    )).where((w) => w.idUser == idUser).toList();
  } 

}