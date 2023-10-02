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

        body: body(context),
      ),
    ));
  }

  Widget body(BuildContext context) {
    var wordDefinition = _.wordDefinition.value.results?.firstOrNull;

    return Padding(
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
            
            const SizedBox(height: 20),

            /// Card Play
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                /// Start
                InkWell(
                  child: Icon(
                    Icons.play_arrow_rounded, 
                    size: 35,
                    color: Colors.green[300],
                  ),

                  onTap: () async {
                    if (_.word.value.word?.description.isNotEmpty ?? false) {
                      await _.flutterTts.speak(_.word.value.word?.description ?? "Ops, Unidentified word!");
                    }
                  },
                ),

                /// Stop
                InkWell(
                  child: Icon(
                    Icons.stop_rounded, 
                    size: 35,
                    color: Colors.red[300],
                  ),

                  onTap: () async {
                    if (_.word.value.word?.description.isNotEmpty ?? false) {
                      await _.flutterTts.stop();
                    }
                  },
                ),
              ],
            ),

            const SizedBox(height: 20),
            
            /// Card Syllables
            _.wordDefinition.value.syllables == null ? const SizedBox() : Card(
              elevation: 5,
              child: ListTile(
                title: Text(
                  "Syllables: N°${_.wordDefinition.value.syllables?.count ?? 0}".toUpperCase(),
                  overflow: TextOverflow.clip,
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.bold,
                  ),
                ),
            
                subtitle: Text(
                  _.wordDefinition.value.syllables?.list?.join(" - ") ?? "",
                ),
              ),
            ),
          
            const SizedBox(height: 15),
            
            /// Card Syllables
            wordDefinition == null ? const SizedBox() : Card(
              elevation: 5,
              child: ListTile(
                title: Text(
                  "Meaning".toUpperCase(),
                  overflow: TextOverflow.clip,
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.bold,
                  ),
                ),
            
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: wordDefinition.partOfSpeech == null ? 0 : 10),

                    title("Part Of Speech: ", wordDefinition.partOfSpeech ?? ""),

                    SizedBox(height: wordDefinition.partOfSpeech == null ? 0 : 10),

                    title("TypeOf: ", wordDefinition.typeOf?.join(", ") ?? ""),

                    SizedBox(height: wordDefinition.hasTypes == null ? 0 : 10),

                    title("Has Types: ", wordDefinition.hasTypes?.join(", ") ?? ""),

                    SizedBox(height: wordDefinition.derivation == null ? 0 : 10),

                    title("Derivation: ", wordDefinition.derivation?.join(", ") ?? ""),

                    SizedBox(height: wordDefinition.synonyms == null ? 0 : 10),

                    title("Synonyms: ", wordDefinition.synonyms?.join(", ") ?? ""),

                    SizedBox(height: _.wordDefinition.value.results == null ? 0 :15),

                    _.wordDefinition.value.results == null ? const SizedBox() : Text(
                      "Definitions".toUpperCase(),
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _.wordDefinition.value.results?.length ?? 0,

                      itemBuilder: (context, index) {
                        var definition = _.wordDefinition.value.results?[index];

                        if (definition == null) { return const SizedBox(); } 

                        return Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                          child: Text(
                            "- ${definition.definition ?? ""}",
                          ),
                        );
                      }
                    ),
                  ],
                )
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget title(String title, String result) {
    if (result.isEmpty) { return const SizedBox(); }

    return Row(
      children: [
        Text(
          title,
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w600
          ),
        ),

        Expanded(
          child: Text(
            result,
          ),
        )
      ],
    );
  }
}