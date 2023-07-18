import 'package:bettersolver/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(
    //   SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent),
    // );
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
    );
    return GetMaterialApp(
      title: 'Better Solver',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ).copyWith(
          accentTextTheme: GoogleFonts.reemKufiTextTheme(),
          primaryTextTheme: GoogleFonts.reemKufiTextTheme(),
          textTheme: GoogleFonts.reemKufiTextTheme()),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      builder: EasyLoading.init(),
    );
  }
}
