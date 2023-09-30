// ignore_for_file: invalid_use_of_protected_member
import 'package:dictionary/app/controllers/words_controller.dart';
import 'package:dictionary/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zezis_widget/z_loading/z_loading_custom/z_loading_custom.dart';

class HistoricView extends StatefulWidget {
  const HistoricView({super.key});

  @override
  State<HistoricView> createState() => _HistoricViewState();
}

class _HistoricViewState extends State<HistoricView> {
  final WordsController _ = Get.put(WordsController());
  
  @override
  Widget build(BuildContext context) {
    return Obx(() => _.loading.value ? const ZLoadingCustom(radius: 30) : Center(
      child: Column(
        children: [
          Expanded(
            child: GridView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: _.history.value.length,
              padding: const EdgeInsets.all(8),

              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                mainAxisSpacing: 20,
                childAspectRatio: 2,
                crossAxisSpacing: 20,
                maxCrossAxisExtent: 200,
              ),

              itemBuilder: (BuildContext context, int index) {
                var word = _.history.value[index];

                return InkWell(
                  onTap: () async => await Get.toNamed(Routes.word, arguments: word.id),
                  child: Card(
                    elevation: 5,
                    color: Colors.white,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  word.word?.description ?? "",
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

                        Icon(
                          Icons.star_rounded,
                          color: word.favorite ? Colors.orange : Colors.grey,
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
}