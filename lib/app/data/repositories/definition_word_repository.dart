import 'package:dictionary/app/data/models/definition_words_model.dart';
import 'package:dictionary/app/data/providers/definition_word_provider.dart';

class DefinitionWordRepository implements DefinitionWordProvider {
  final DefinitionWordProvider provider = DefinitionWordProvider();
  
  @override
  Future<DefinitionWordsModel?> get(String word) {
    return provider.get(word);
  }
}