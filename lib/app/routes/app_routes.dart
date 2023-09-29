import 'package:dictionary/app/routes/routes.dart';
import 'package:dictionary/app/ui/global/login/login_page.dart';
import 'package:dictionary/app/ui/global/login/register_page.dart';
import 'package:dictionary/app/ui/global/settings/settings_page.dart';
import 'package:dictionary/app/ui/global/words/views/word_view.dart';
import 'package:dictionary/app/ui/global/words/words_page.dart';
import 'package:get/get_navigation/get_navigation.dart';

abstract class AppRoutes {
  static final routes = [
    GetPage(name: Routes.login, page:()=> const LoginPage()),
    GetPage(name: Routes.register, page:()=> const RegisterPage()),
    GetPage(name: Routes.settings, page:()=> const SettingsPage()),

    GetPage(name: Routes.word, page:()=> const WordView()),
    GetPage(name: Routes.words, page:()=> const WordsPage()),
  ];
}