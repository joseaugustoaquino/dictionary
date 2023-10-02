import 'dart:convert';

import 'package:dictionary/app/data/models/word_definition_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class WordService extends GetxController {
  final GetStorage _box = GetStorage();
  
  List<WordDefinitionModel> get wordDefinition {
    try {
      var p = _box.read("wordDefinition");

      if (p != null && p != "") {
        var j = jsonDecode(p);
        var f = List<WordDefinitionModel>.from(j?.cast<Map<String, dynamic>>().map((itemsJson) => WordDefinitionModel.fromMap(itemsJson)));
        return f;
      } else {
        return [];
      }
    } catch (_) {
      printError(info: "$_");
      return [];
    }
  }

  set changeWordDefinition(List<WordDefinitionModel>  m) =>  _box.write("wordDefinition", json.encode(m.map((e) => e.toMap()).toList()));

}