import 'package:dictionary/app/data/models/word_definition_model.dart';

abstract class WordDefinitionInterface {
  Future<WordDefinitionModel?> get(String word);
}