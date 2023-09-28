import 'package:dictionary/app/data/models/user_model.dart';

abstract class UserInterface {
  Future<bool> add(UserModel user);

  Future<bool> update(UserModel user);

  Future<bool> delete(int idUser);

  Future<List<UserModel>> get();
}