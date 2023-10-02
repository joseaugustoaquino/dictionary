import 'package:dictionary/app/data/models/word_history_model.dart';
import 'package:dictionary/app/data/providers/word_history_provider.dart';

class WordHistoryRepository implements WordHistoryProvider {
  final WordHistoryProvider provider = WordHistoryProvider();

  @override
  Future<bool> add(WordHistoryModel wordHistory) async {
    return await provider.add(wordHistory);
  }

  @override
  Future<bool> update(WordHistoryModel wordHistory) async {
    return await provider.update(wordHistory);
  }

  @override
  Future<bool> delete(int idWordHistory) async {
    return await provider.delete(idWordHistory);
  }

  @override
  Future<List<WordHistoryModel>> get() async {
    return await provider.get();
  }

  @override
  Future<WordHistoryModel?> getById(int idWordHistory) async {
    return await provider.getById(idWordHistory);
  }

  @override
  Future<List<WordHistoryModel>> getByUser(int idUser) async {
    return await provider.getByUser(idUser);
  }
  
  @override
  Future<WordHistoryModel?> getByWord(int idUser, int idWord) async {
    return await provider.getByWord(idUser, idWord);
  }
  
}