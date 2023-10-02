import 'package:dictionary/app/data/models/word_model.dart';

abstract class WordInterface {
  Future<bool> add(WordModel word);

  Future<bool> update(WordModel word);

  Future<bool> delete(int idWord);

  Future<List<WordModel>> get();

  Future<WordModel?> getById(int idWord);

  Future<WordModel?> getByDescription(String word);
}