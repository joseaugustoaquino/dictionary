import 'package:dictionary/app/controllers/word_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zezis_widget/zezis_widget.dart';

class WordView extends StatefulWidget {
  const WordView({super.key});

  @override
  State<WordView> createState() => _WordViewState();
}

class _WordViewState extends State<WordView> {
  final WordController _ = Get.put(WordController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => _.loading.value ? const ZLoadingCustom(radius: 30) : WillPopScope(
      onWillPop: () async {
        Get.back(result: _.word.value);
        return true;
      },

      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Get.theme.primaryColor,
    
          title: Text(
            _.word.value.word?.description ?? "",
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.bold,
            ),
          ),
    
          actions: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: InkWell(
                onTap: () async {
                  _.word.value.favorite = !_.word.value.favorite;
                  await  _.updateWord(_.word.value);
                  setState(() {});
                },
                child: Icon(
                  Icons.star_rounded,
                  color: _.word.value.favorite ? Colors.orange : Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}