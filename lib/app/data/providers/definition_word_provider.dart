import 'package:dictionary/app/data/interfaces/definition_word_interface.dart';
import 'package:dictionary/app/data/models/definition_words_model.dart';
import 'package:dio/dio.dart';

class DefinitionWordProvider implements DefinitionWordInterface {
  static const String _urlBase = "https://wordsapiv1.p.rapidapi.com";
  static const String _apiKey = "e748f7784amshb02eeed214fcee8p143cecjsn550713edeb10";
  static const String _headerKey = "X-RapidAPI-Key";

  @override
  Future<DefinitionWordModel?> get(String word) async {
    var result = await Dio(BaseOptions(
      headers: { _headerKey: _apiKey }
    )).get('$_urlBase/words/$word');

    if (result.statusCode == 200 && result.data != null) {
      var convert = DefinitionWordModel.fromMap(result.data);
      return convert;
    } else {
      return null;
    }
  }
}