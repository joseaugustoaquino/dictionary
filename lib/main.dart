import 'package:dictionary/app/data/databases/data_base.dart';
import 'package:dictionary/app/routes/app_routes.dart';
import 'package:dictionary/app/routes/routes.dart';
import 'package:dictionary/app/ui/theme/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Initial Local Storage
  await GetStorage.init();

  /// Initial instace DBSet
  await DBSet.instance.database;
  
  /// Initial License Font Theme
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/UFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  
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

    return GetMaterialApp(
      title: "Dictionary",
  
      transitionDuration: Get.defaultTransitionDuration,
      opaqueRoute: Get.isOpaqueRouteDefault,
      defaultTransition: Transition.zoom,
      popGesture: Get.isPopGestureEnable,
      debugShowCheckedModeBanner: false,
      defaultGlobalState: true,
      enableLog: true,

      theme: ThemeSystem.theme(context),
      initialRoute: Routes.login,
      getPages: AppRoutes.routes,
  
      localizationsDelegates: const [
        DefaultCupertinoLocalizations.delegate,
        DefaultMaterialLocalizations.delegate,
  
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      
      locale: const Locale('en', 'US'),
      supportedLocales: const [Locale('en', 'US')],
    );
  }
}