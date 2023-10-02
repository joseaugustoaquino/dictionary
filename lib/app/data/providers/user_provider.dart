import 'package:dictionary/app/data/databases/data_base.dart';
import 'package:sqflite/sqflite.dart';
import 'package:dictionary/app/data/models/user_model.dart';
import 'package:dictionary/app/data/interfaces/user_interface.dart';

class UserProvider implements UserInterface {
  Database? _db;

  @override
  Future<bool> add(UserModel user) async {
    _db = await DBSet.instance.database;
    if (_db == null) return false;

    int de = await _db?.rawInsert(
      "INSERT INTO users (name, email, password) VALUES (?,?,?)", 
      [user.name, user.email, user.password]
    ) ?? 0;
    
    return de != 0;
  }

  @override
  Future<bool> update(UserModel user) async {
    _db = await DBSet.instance.database;
    if (_db == null) return false;

    int de = await _db?.rawUpdate(
      "UPDATE users SET name = ?, email = ?, password = ? WHERE id = ?", 
      [user.name, user.email, user.password, user.id]
    ) ?? 0;
    
    return de != 0;
  }

  @override
  Future<bool> delete(int idUser) async {
    _db = await DBSet.instance.database;
    if (_db == null) return false;

    int de = await _db?.rawDelete(
      "DELETE FROM users WHERE id = ?", 
      [idUser]
    ) ?? 0;
    
    return de != 0;
  }

  @override
  Future<List<UserModel>> get() async {
    _db = await DBSet.instance.database;
    if (_db == null) return [];

    List<Map<String, dynamic>> result = await _db?.query("users") ?? [];
    return result.map((m) => UserModel(
      id: m["id"],
      name: m["name"],
      email: m["email"],
      password: m["password"],
    )).toList();
  }
  
  @override
  Future<UserModel?> getById(int idUser) async {
    _db = await DBSet.instance.database;
    if (_db == null) return null;

    List<Map<String, dynamic>> result = await _db?.rawQuery('''
      SELECT * FROM users
      WHERE id = ?;
    ''', [idUser]) ?? [];


    return result.isEmpty ? null : UserModel.fromMap(result.first);
  }
  
  @override
  Future<UserModel?> getByEmail(String email) async {
    _db = await DBSet.instance.database;
    if (_db == null) return null;

    List<Map<String, dynamic>> result = await _db?.rawQuery('''
      SELECT * FROM users
      WHERE email = ?;
    ''', [email]) ?? [];


    return result.isEmpty ? null : UserModel.fromMap(result.first);
  } 


}