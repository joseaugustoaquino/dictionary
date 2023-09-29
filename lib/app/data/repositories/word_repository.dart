import 'package:dictionary/app/data/models/word_model.dart';
import 'package:dictionary/app/data/providers/word_provider.dart';

class WordRepository implements WordProvider {
  final WordProvider provider = WordProvider();

  @override
  Future<bool> add(WordModel word) {
    return provider.add(word);
  }

  @override
  Future<bool> update(WordModel word) {
    return provider.update(word);
  }
  
  @override
  Future<bool> delete(int idWord) {
    return provider.delete(idWord);
  }

  @override
  Future<List<WordModel>> get() {
    return provider.get();
  }

  @override
  Future<WordModel?> getById(int idWord) {
    return provider.getById(idWord);
  }

}