import 'package:dictionary/app/data/models/user_model.dart';
import 'package:dictionary/app/data/providers/user_provider.dart';

class UserRepository implements UserProvider {
  final UserProvider provider = UserProvider();

  @override
  Future<bool> add(UserModel user) async {
    return await provider.add(user);
  }

  @override
  Future<bool> update(UserModel user) async {
    return await provider.update(user);
  }
  
  @override
  Future<bool> delete(int idUser) async {
    return await provider.delete(idUser);
  }

  @override
  Future<List<UserModel>> get() async {
    return await provider.get();
  }

  @override
  Future<UserModel?> getById(int idUser) async {
    return await provider.getById(idUser);
  }
  
  @override
  Future<UserModel?> getByEmail(String email) async {
    return await provider.getByEmail(email);
  }
}