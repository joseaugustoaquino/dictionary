// ignore_for_file: invalid_use_of_protected_member

import 'dart:convert';

import 'package:dictionary/app/data/models/word_model.dart';
import 'package:dictionary/app/data/repositories/word_repository.dart';
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

  var loading = RxBool(true);
  var page = Rx(Pages.words);
  var words = RxList([WordModel()]);
  var search = Rx(TextEditingController());

  @override
  void onInit() async {
    loading.value = false;
    words.value.clear();
    super.onInit();
  }

  @override
  void onReady() async {
    await get();
    super.onReady();
  }

  Future get() async {
    try {
      loading.value = true;
      words.value = await _wordRep.get();

      if (words.value.isEmpty) {
        var wordsJson = await rootBundle.loadString('assets/wrods.json');
        Map<String, dynamic> wordsMap = json.decode(wordsJson);

        words.value = wordsMap.entries
                              .map((entry) => WordModel(description: entry.key.toString().toUpperCase()))
                              .toList();

        for (var w in words.value) { await _wordRep.add(w); }
        words.value = await _wordRep.get();
      }

      if (words.value.isEmpty) 
      { throw Exception("Ops, We did not identify any registered words!"); }

      if (search.value.text.isNotEmpty) 
      { words.value = words.value.where((w) => w.description.contains(search.value.text)).toList(); }

      return await Future.delayed(const Duration(milliseconds: 1000), () => loading.value = false);
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