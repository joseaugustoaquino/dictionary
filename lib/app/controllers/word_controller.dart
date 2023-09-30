import 'package:dictionary/app/controllers/storage/authentication_controller.dart';
import 'package:dictionary/app/data/models/definition_words_model.dart';
import 'package:dictionary/app/data/models/word_history_model.dart';
import 'package:dictionary/app/data/models/word_model.dart';
import 'package:dictionary/app/data/repositories/definition_word_repository.dart';
import 'package:dictionary/app/data/repositories/word_history_repository.dart';
import 'package:dictionary/app/data/repositories/word_repository.dart';
import 'package:dictionary/app/widgets/snack_bar_custom.dart';
import 'package:get/get.dart';

class WordController extends GetxController {
  static WordController get to => Get.find();
  
  final WordRepository _wordRep = WordRepository();
  final WordHistoryRepository _wordHistoryRep = WordHistoryRepository();
  final AuthenticationController _authenticationCon = AuthenticationController();
  final DefinitionWordRepository _definitionWordRep = DefinitionWordRepository();

  var loading = RxBool(true);
  var word = Rx(WordHistoryModel());
  var wordDefinition = Rx(DefinitionWordModel());

  @override
  void onReady() async {
    if (Get.arguments != null && Get.arguments.runtimeType == int) {
      await getById(idWord: Get.arguments);
    } else {
      loading.value = false;
      showSnackBarCustom("Ops, Search argument not found!");
    }

    super.onReady();
  }

  Future getById({required int idWord}) async {
    try {
      loading.value = true;

      if (_authenticationCon.user.id == null) {
        throw Exception("Ops, Unauthorized user!");
      }

      var wordHistoric = await _wordHistoryRep.getByWord(_authenticationCon.user.id!, idWord) ?? WordHistoryModel();

      if (wordHistoric.id != null && wordHistoric.word != null) {
        wordHistoric.lastAcess = DateTime.now();
        word.value = wordHistoric; 
        await updateWord(word.value);
      } else {
        var wordSave = await _wordRep.getById(idWord) ?? WordModel();

        if (wordSave.id == null) {
          throw Exception("Ops, Word not found!");
        } 

        word.value = await addWord(WordHistoryModel(
          idUser: _authenticationCon.user.id,
          idWord: wordSave.id,
          lastAcess: DateTime.now(),
          favorite: false,
          user: _authenticationCon.user,
          word: wordSave,
        )) ?? WordHistoryModel();
      }

      if (word.value.id != null) {
        wordDefinition.value = await getDefinitationWord(word.value.word?.description ?? "") ?? DefinitionWordModel(); 
        return loading.value = false;
      } else {
        throw Exception("Ops, Word not found!");
      }
    } on Exception catch (_) {
      showSnackBarCustom(_.toString().replaceAll("Exception:", ""));
      printError(info: _.toString());
      return loading.value = false;
    } catch (_) {
      showSnackBarCustom("Ops, $_");
      printError(info: _.toString());
      return loading.value = false;
    }
  } 

  Future<DefinitionWordModel?> getDefinitationWord(String word) async {
    try {
      var result = await _definitionWordRep.get(word);

      if (result != null) {
        return result;
      } else {
        throw Exception("Ops, Failed to query definitions!");
      }
    } on Exception catch (_) {
      showSnackBarCustom(_.toString().replaceAll("Exception:", ""));
      printError(info: _.toString());
      return null;
    } catch (_) {
      showSnackBarCustom("Ops, $_");
      printError(info: _.toString());
      return null;
    }
  }

  Future<WordHistoryModel?> updateWord(WordHistoryModel wordHistory) async {
    try {
      loading.value = true;

      if (wordHistory.idUser == null || wordHistory.idWord == null || wordHistory.id == null) {
        throw Exception("Ops, The information sent is not valid!");
      }

      var wordHistoric = await _wordHistoryRep.update(wordHistory);
      var wordHistorySave = await _wordHistoryRep.getByWord(wordHistory.idUser!, wordHistory.idWord!);

      if (wordHistoric || wordHistorySave != null) {
        loading.value = false;
        return wordHistorySave;
      } else {
        throw Exception("Ops, Failed to update information!");
      }
    } on Exception catch (_) {
      showSnackBarCustom(_.toString().replaceAll("Exception:", ""));
      printError(info: _.toString());
      loading.value = false;
      return null;
    } catch (_) {
      showSnackBarCustom("Ops, $_");
      printError(info: _.toString());
      loading.value = false;
      return null;
    }
  }

  Future<WordHistoryModel?> addWord(WordHistoryModel wordHistory) async {
    try {
      if (wordHistory.idUser == null || wordHistory.idWord == null) {
        throw Exception("Ops, The information sent is not valid!");
      }

      var wordHistoric = await _wordHistoryRep.add(wordHistory);
      var wordHistorySave = await _wordHistoryRep.getByWord(wordHistory.idUser!, wordHistory.idWord!);

      if (wordHistoric || wordHistorySave != null) {
        return wordHistorySave;
      } else {
        throw Exception("Ops, Word History not save!");
      }
    } on Exception catch (_) {
      showSnackBarCustom(_.toString().replaceAll("Exception:", ""));
      printError(info: _.toString());
      return null;
    } catch (_) {
      showSnackBarCustom("Ops, $_");
      printError(info: _.toString());
      return null;
    }
  }

}