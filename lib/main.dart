import 'package:dictionary/app/data/databases/data_base.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Initial instace DBSet
  await DBSet.instance.database;
  runApp(const MyApp());
}

class MyApp extends StatefulWidget{
  const MyApp({Key? key, }) : super(key: key); //constructor of MyApp class

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    return main(context);
  }

  Widget main(BuildContext context) {
    return GetMaterialApp(
      title: "Dictionary",
  
      transitionDuration: Get.defaultTransitionDuration,
      opaqueRoute: Get.isOpaqueRouteDefault,
      defaultTransition: Transition.zoom,
      popGesture: Get.isPopGestureEnable,
      debugShowCheckedModeBanner: false,
      defaultGlobalState: true,
      enableLog: true,

      home: Scaffold(
        appBar: AppBar(),
      ),
  
      localizationsDelegates: const [
        DefaultCupertinoLocalizations.delegate,
        DefaultMaterialLocalizations.delegate,
  
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      
      supportedLocales: const [
        Locale('en', 'US'),
        Locale("pt", "BR"),
      ],
      
      locale: const Locale("pt", "BR"),
    );
  }
}