import 'package:dictionary/app/data/models/word_history_model.dart';
import 'package:dictionary/app/data/providers/word_history_provider.dart';

class WordHistoryRepository implements WordHistoryProvider {
  final WordHistoryProvider provider = WordHistoryProvider();

  @override
  Future<bool> add(WordHistoryModel wordHistory) {
    return provider.add(wordHistory);
  }

  @override
  Future<bool> update(WordHistoryModel wordHistory) {
    return provider.update(wordHistory);
  }

  @override
  Future<bool> delete(int idWordHistory) {
    return provider.delete(idWordHistory);
  }

  @override
  Future<List<WordHistoryModel>> get() {
    return provider.get();
  }

  @override
  Future<WordHistoryModel?> getById(int idWordHistory) {
    return provider.getById(idWordHistory);
  }

  @override
  Future<List<WordHistoryModel>> getByUser(int idUser) {
    return provider.getByUser(idUser);
  }
  
  @override
  Future<WordHistoryModel?> getByWord(int idUser, int idWord) {
    return provider.getByWord(idUser, idWord);
  }
  
}