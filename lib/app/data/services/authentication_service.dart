import 'package:dictionary/app/data/models/user_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthenticationService extends GetxController {
  final GetStorage _box = GetStorage();

  bool get toRemember => _box.read("toRemember") ?? false;
  set changeToRemeber(bool value) => _box.write("toRemember", value);

  UserModel get user => UserModel.fromJson(_box.read("user") ?? UserModel().toJson());
  set changeUser(UserModel value) => _box.write("user", value.toJson());
}