import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'ConstFile/constColors.dart';
import 'Screens/splash_screen.dart';
import 'Screens/splash_second_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: ConstColour.appColor,
    ));

    return GetMaterialApp(
      title: 'Healthcare Diary',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: false),
      home: const SplashScreen(),
      // home: const SplashSecondScreen(),
      // home: const HomeScreen(),
    );
  }
}