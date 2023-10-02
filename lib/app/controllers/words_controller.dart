// ignore_for_file: invalid_use_of_protected_member

import 'dart:convert';

import 'package:dictionary/app/data/repositories/word_repository.dart';
import 'package:dictionary/app/data/services/authentication_service.dart';
import 'package:dictionary/app/data/models/word_history_model.dart';
import 'package:dictionary/app/data/models/word_model.dart';
import 'package:dictionary/app/data/repositories/word_history_repository.dart';
import 'package:dictionary/app/widgets/snack_bar_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

enum Pages {
  words, // 0
  historic, // 1
  favorite, // 2
}

class WordsController extends GetxController {
  static WordsController get to => Get.find();  

  final WordRepository _wordRep = WordRepository();
  final AuthenticationService _authServ = AuthenticationService();
  final WordHistoryRepository _wordHistoriyRep = WordHistoryRepository();

  var loading = RxBool(true);
  var page = Rx(Pages.words);
  var search = Rx(TextEditingController());

  var words = RxList([WordModel()]);
  var history = RxList([WordHistoryModel()]);
  var favorite = RxList([WordHistoryModel()]);

  @override
  void onInit() async {
    words.value.clear();
    history.value.clear();
    favorite.value.clear();
    super.onInit();
  }

  @override
  void onReady() async {
    await getWords();
    super.onReady();
  }

  /// DATA
  Future getWords() async {
    try {
      loading.value = true;
      
      var wordsJson = await rootBundle.loadString('assets/wrods.json');
      Map<String, dynamic> wordsMap = json.decode(wordsJson);

      words.value = wordsMap.entries
                            .map((entry) => WordModel(description: entry.key.toString().toUpperCase()))
                            .toList();

      if (words.value.isEmpty) 
      { throw Exception("Ops, We did not identify any registered words!"); }

      if (search.value.text.isNotEmpty) 
      { words.value = words.value.where((w) => w.description.contains(search.value.text)).toList(); }

      return loading.value = false;
    } on Exception catch (_) {
      showSnackBarCustom(_.toString().replaceAll("Exception:", ""));
      printError(info: _.toString());
      return loading.value = false;
    } catch (_) {
      showSnackBarCustom("Ops, $_");
      printError(info: _.toString());
      return loading.value = false;
    }
  } 

  Future getHistory() async {
    try {
      loading.value = true;

      if (_authServ.user.id == null) {
        throw Exception("Ops, Unauthorized user!");
      }

      var result = await _wordHistoriyRep.getByUser(_authServ.user.id!);

      if (result.isNotEmpty) {
        history.value = result;
        history.value.sort((a, b) => (b.lastAcess ?? DateTime.now()).compareTo(a.lastAcess ?? DateTime.now()));
        return loading.value = false;
      } else {
        throw Exception("Ops, No history found!");
      }
    } on Exception catch (_) {
      showSnackBarCustom(_.toString().replaceAll("Exception:", ""));
      printError(info: _.toString());
      return loading.value = false;
    } catch (_) {
      showSnackBarCustom("Ops, $_");
      printError(info: _.toString());
      return loading.value = false;
    }
  } 

  Future getFavotire() async {
    try {
      loading.value = true;

      if (_authServ.user.id == null) {
        throw Exception("Ops, Unauthorized user!");
      }

      var result = await _wordHistoriyRep.getByUser(_authServ.user.id!);

      if (result.isNotEmpty) {
        favorite.value = result.where((w) => w.favorite).toList();
        favorite.value.sort((a, b) => (b.lastAcess ?? DateTime.now()).compareTo(a.lastAcess ?? DateTime.now()));
        return loading.value = false;
      } else {
        throw Exception("Ops, No history found!");
      }
    } on Exception catch (_) {
      showSnackBarCustom(_.toString().replaceAll("Exception:", ""));
      printError(info: _.toString());
      return loading.value = false;
    } catch (_) {
      showSnackBarCustom("Ops, $_");
      printError(info: _.toString());
      return loading.value = false;
    }
  } 

  Future<WordModel?> addWord({required String description}) async {
    try {
      loading.value = true;
      
      var searchWord = await _wordRep.getByDescription(description);

      if (searchWord == null) { 
        var word = await _wordRep.add(WordModel(description: description)); 
        if (word) {
          searchWord = await _wordRep.getByDescription(description);
        } else {
          throw Exception("Ops, Failed to add word!"); 
        }
      } 

      if (searchWord?.id == null) {
        throw Exception("Ops, Word not found!");
      } 

      loading.value = false;
      return searchWord;
    } on Exception catch (_) {
      showSnackBarCustom(_.toString().replaceAll("Exception:", ""));
      printError(info: _.toString());
      loading.value = false;
      return null;
    } catch (_) {
      showSnackBarCustom("Ops, $_");
      printError(info: _.toString());
      loading.value = false;
      return null;
    }
  } 
  /// FUNCTIONS
  void changePage(Pages value) async {
    if (loading.value) {
      showSnackBarCustom("Ops, Wait for loading!");
      return;
    } 

    page.value = value;
    switch (page.value) {
      case Pages.words: 
        await getWords();
        break;

      case Pages.historic:
        await getHistory();
        break;

      case Pages.favorite:
        await getFavotire();
        break;

      default:
        return;
    }
  }
}