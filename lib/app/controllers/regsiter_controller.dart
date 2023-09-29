import 'package:dictionary/app/controllers/authentication_controller.dart';
import 'package:dictionary/app/data/models/user_model.dart';
import 'package:dictionary/app/data/repositories/user_repository.dart';
import 'package:dictionary/app/routes/routes.dart';
import 'package:dictionary/app/widgets/snack_bar_custom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zezis_functions/zezis_functions.dart';

class RegisterController extends GetxController {
  static RegisterController get to => Get.find();
  
  final UserRepository _userRep = UserRepository();
  final AuthenticationController _authCon = AuthenticationController();
  
  var loading = RxBool(true);
  var textName = Rx(TextEditingController());
  var textEmail = Rx(TextEditingController());
  var textPassword = Rx(TextEditingController());

  @override
  void onInit() async {
    loading.value = false;
    super.onInit();
  }

  Future register() async {
    try {
      if (textName.value.text.isNullOrEmpty()) 
      { throw Exception("Ops, Name invalid."); }

      if (textEmail.value.text.isNullOrEmpty()) 
      { throw Exception("Ops, E-mail invalid."); }

      if (textPassword.value.text.isNullOrEmpty()) 
      { throw Exception("Ops, Password invalid."); }

      var already = await _userRep.getByEmail(textEmail.value.text);

      if (already != null) 
      { throw Exception("Ops, E-mail already registered."); }

      var result = await _userRep.add(UserModel(
        name: textName.value.text,
        email: textEmail.value.text,
        password: textPassword.value.text,
      ));

      if (result) {
        _authCon.changeUser = await _userRep.getByEmail(textEmail.value.text) ?? UserModel();
        Get.offAndToNamed(Routes.words);

        showSnackBarCustom("Uhull, Login successfully!");
        return;
      } else {
        throw Exception("Ops, Failed to register user!");
      }
    } on Exception catch (_) {
      showSnackBarCustom(_.toString().replaceAll("Exception:", ""));
      printError(info: _.toString());
      loading.value = false;
      return;
    } catch (_) {
      showSnackBarCustom("Ops, $_");
      printError(info: _.toString());
      loading.value = false;
      return;
    }
  }
}