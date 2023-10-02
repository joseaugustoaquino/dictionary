import 'package:dictionary/app/data/models/word_model.dart';
import 'package:dictionary/app/data/providers/word_provider.dart';

class WordRepository implements WordProvider {
  final WordProvider provider = WordProvider();

  @override
  Future<bool> add(WordModel word) async {
    return await provider.add(word);
  }

  @override
  Future<bool> update(WordModel word) async {
    return await provider.update(word);
  }
  
  @override
  Future<bool> delete(int idWord) async {
    return await provider.delete(idWord);
  }

  @override
  Future<List<WordModel>> get() async {
    return await provider.get();
  }

  @override
  Future<WordModel?> getById(int idWord) async {
    return await provider.getById(idWord);
  }
  
  @override
  Future<WordModel?> getByDescription(String word) async {
    return await provider.getByDescription(word);
  }

}