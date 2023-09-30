import 'package:dictionary/app/controllers/storage/authentication_controller.dart';
import 'package:dictionary/app/controllers/words_controller.dart';
import 'package:dictionary/app/routes/routes.dart';
import 'package:dictionary/app/ui/global/words/views/favorite_view.dart';
import 'package:dictionary/app/ui/global/words/views/historic_view.dart';
import 'package:dictionary/app/ui/global/words/views/words_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zezis_widget/zezis_widget.dart';

class WordsPage extends StatefulWidget {
  const WordsPage({super.key});

  @override
  State<WordsPage> createState() => _WordsPageState();
}

class _WordsPageState extends State<WordsPage> {
  final WordsController _ = Get.put(WordsController());
  final AuthenticationController _auth = Get.put(AuthenticationController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Get.theme.primaryColor,

        title: Row(
          children: [
            const Icon(
              Icons.person_rounded,
            ),
            
            const SizedBox(width: 10),

            Expanded(
              child: Text(
                _auth.user.name,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.roboto(),
              ),
            ),
          ],
        ),

        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: InkWell(
              onTap: () async => await Get.toNamed(Routes.settings),
              child: const Icon(
                Icons.settings_rounded,
              ),
            ),
          )
        ],
      ),
     
      body: _.loading.value ? const Center(child: ZLoadingCustom(radius: 30)) : IndexedStack(
        index: _.page.value.index,
        children: const [
          WordsView(),

          HistoricView(),
          
          FavoriteView(),
        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        elevation: 5,
        currentIndex: _.page.value.index,
        unselectedItemColor: Colors.black,
        selectedItemColor: Get.theme.primaryColor,

        onTap: (index) async => _.page.value = [
          Pages.words,
          Pages.historic,
          Pages.favorite,
        ][index],

        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list_rounded),
            label: 'Words',
          ),
          
          BottomNavigationBarItem(
            icon: Icon(Icons.history_rounded),
            label: 'Historic',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.star_rounded),
            label: 'Favorites',
          ),
        ],
      ),
    ));
  }
}