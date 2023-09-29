import 'package:dictionary/app/data/models/user_model.dart';
import 'package:dictionary/app/data/providers/user_provider.dart';

class UserRepository implements UserProvider {
  final UserProvider provider = UserProvider();

  @override
  Future<bool> add(UserModel user) {
    return provider.add(user);
  }

  @override
  Future<bool> update(UserModel user) {
    return provider.update(user);
  }
  
  @override
  Future<bool> delete(int idUser) {
    return provider.delete(idUser);
  }

  @override
  Future<List<UserModel>> get() {
    return provider.get();
  }

  @override
  Future<UserModel?> getById(int idUser) {
    return provider.getById(idUser);
  }
  
  @override
  Future<UserModel?> getByEmail(String email) {
    return provider.getByEmail(email);
  }
}