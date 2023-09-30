// ignore_for_file: invalid_use_of_protected_member
import 'package:dictionary/app/controllers/words_controller.dart';
import 'package:dictionary/app/routes/routes.dart';
import 'package:dictionary/app/widgets/text_form_custom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zezis_widget/zezis_widget.dart';

class WordsView extends StatefulWidget {
  const WordsView({super.key});

  @override
  State<WordsView> createState() => _WordsViewState();
}

class _WordsViewState extends State<WordsView> {
  final WordsController _ = Get.put(WordsController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => _.loading.value ? const ZLoadingCustom(radius: 30) : Center(
      child: Column(
        children: [
          getSearchBarUI(context),

          Expanded(
            child: GridView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: _.words.value.length,
              padding: const EdgeInsets.all(8),

              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3
              ), 

              itemBuilder: (BuildContext context, int index) {
                var word = _.words.value[index];
                return InkWell(
                  onTap: () async => await Get.toNamed(Routes.word, arguments: word.id),
                  child: Card(
                    elevation: 5,
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            word.description,
                            overflow: TextOverflow.clip,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ));
  }

  Widget getSearchBarUI(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      child: TextFormCustom(
        inputFormatters: [UpperCaseTextFormatter()],
        textInputAction: TextInputAction.done,
        padding: const EdgeInsets.all(0),
        keyboardType: TextInputType.text,
        controller: _.search.value,
        hintText: 'Search Words',
        autofocus: false,

        suffixIcon: IconButton(
          icon: Icon(
            Icons.search_rounded,
            color: Get.theme.primaryColor,
          ),

          onPressed: () async => _.getWords(),
        ),
      ),
    );
  }

}