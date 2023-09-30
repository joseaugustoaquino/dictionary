import 'package:dictionary/app/data/models/definition_words_model.dart';

abstract class DefinitionWordInterface {
  Future<DefinitionWordModel?> get(String word);
}