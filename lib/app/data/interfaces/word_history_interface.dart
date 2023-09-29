import 'package:dictionary/app/data/models/word_history_model.dart';

abstract class WordHistoryInterface {
  Future<bool> add(WordHistoryModel wordHistory);

  Future<bool> update(WordHistoryModel wordHistory);

  Future<bool> delete(int idWordHistory);

  Future<List<WordHistoryModel>> get();

  Future<WordHistoryModel?> getById(int idWordHistory);

  Future<List<WordHistoryModel>> getByUser(int idUser);
}