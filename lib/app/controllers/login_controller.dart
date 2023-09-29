import 'package:dictionary/app/controllers/authentication_controller.dart';
import 'package:dictionary/app/data/repositories/user_repository.dart';
import 'package:dictionary/app/routes/routes.dart';
import 'package:dictionary/app/widgets/snack_bar_custom.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:zezis_functions/zezis_functions.dart';

class LoginController extends GetxController {
  static LoginController get to => Get.find();
  
  final UserRepository _userRep = UserRepository();
  final AuthenticationController _authCon = AuthenticationController();

  var loading = RxBool(true);
  var textEmail = Rx(TextEditingController());
  var textPassword = Rx(TextEditingController());

  @override
  void onInit() async {
    loading.value = false;

    if (_authCon.toRemember) {
      textEmail.value.text = _authCon.user.email;
      textPassword.value.text = _authCon.user.password;
    }
    
    super.onInit();
  }

  Future login() async {
    try {
      if (textEmail.value.text.isNullOrEmpty()) 
      { throw Exception("Ops, E-mail invalid."); }

      if (textPassword.value.text.isNullOrEmpty()) 
      { throw Exception("Ops, Password invalid."); }

      var result = await _userRep.getByEmail(textEmail.value.text);

      if (result != null) {
        if (result.password != textPassword.value.text) 
        { throw Exception("Ops, Incorrect password");}

        _authCon.changeUser = result;
        Get.offAndToNamed(Routes.words);

        showSnackBarCustom("Uhull, Login successfully!");
        return;
      } else {
        throw Exception("Ops, User not found!");
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