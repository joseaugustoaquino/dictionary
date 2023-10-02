import 'dart:async';

import 'package:dictionary/app/controllers/word_controller.dart';
import 'package:dictionary/app/widgets/progress_bar_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:zezis_widget/zezis_widget.dart';

class WordView extends StatefulWidget {
  const WordView({super.key});

  @override
  State<WordView> createState() => _WordViewState();
}

class _WordViewState extends State<WordView> {
  final FlutterTts flutterTts = FlutterTts();
  final WordController _ = Get.put(WordController());

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

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

        body: body(context),
      ),
    ));
  }

  Widget body(BuildContext context) {
    return ChangeNotifierProvider<TimeState>(
      create: (context) => TimeState(),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// Card Informations 
              Card(
                elevation: 5,
                color: Colors.grey[400],
                child: SizedBox(
                  height: 220,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _.word.value.word?.description ?? "",
                        overflow: TextOverflow.clip,
                        style: GoogleFonts.roboto(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
    
                      const SizedBox(height: 10),
    
                      Text(
                        _.wordDefinition.value.pronunciation?.all ?? "",
                        overflow: TextOverflow.clip,
                        style: GoogleFonts.roboto(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            
              /// Card Play
              Container(
                padding: const EdgeInsets.only(top: 50.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                     Consumer<TimeState>(
                      builder: (context, timeState, con) => InkWell(
                        child: Icon(
                          Icons.play_arrow_rounded, 
                          color: Colors.green[300],
                        ),

                        onTap: () async {
                          if (_.word.value.word?.description.isNotEmpty ?? false) {
                            await flutterTts.setLanguage("en-US");
                            await flutterTts.setSpeechRate(0.05);
                            await flutterTts.isLanguageAvailable("en-US");

                            print(await flutterTts.speak(_.word.value.word?.description ?? "Ops, Unidentified word!"));
                          }

                          // Timer.periodic(const Duration(seconds: 1), (timer) {
                          //   if(timeState.time == 0) {
                          //     timer.cancel();
                          //   } else {
                          //     timeState.time -= 1;
                          //   }
                          // });
                        },
                      )
                    ),

                    // Consumer<TimeState>(
                    //   builder: (context, timeState, con) => ProgressBarCustom(
                    //     width: 420,
                    //     totalValue: 100,
                    //     value: timeState.time,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}