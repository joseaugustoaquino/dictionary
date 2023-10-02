import 'package:dictionary/app/data/models/word_definition_model.dart';
import 'package:dictionary/app/data/providers/word_definition_provider.dart';

class WordDefinitionRepository implements WordDefinitionProvider {
  final WordDefinitionProvider provider = WordDefinitionProvider();
  
  @override
  Future<WordDefinitionModel?> get(String word) async {
    return await provider.get(word);
  }
}