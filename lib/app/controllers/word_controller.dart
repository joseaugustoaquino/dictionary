import 'package:dictionary/app/data/repositories/word_repository.dart';
import 'package:get/get.dart';

class WordController extends GetxController {
  static WordController get to => Get.find();
  
  final WordRepository _wordRep = WordRepository();

  var loading = RxBool(true);

  @override
  void onInit() async {
    loading.value = false;
    super.onInit();
  }

}