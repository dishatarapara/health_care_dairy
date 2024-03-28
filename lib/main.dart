import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'ConstFile/constColors.dart';
import 'Screens/Setting/notification/notification_service.dart';
import 'Screens/splash_screen.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await NotificationService().initializeNotifications();
  tz.initializeTimeZones();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
      statusBarColor: ConstColour.appColor,
    ));

    return GetMaterialApp(
      title: 'Healthcare Diary',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          textSelectionTheme: TextSelectionThemeData(
            selectionHandleColor: ConstColour.buttonColor,
          ),
          useMaterial3: false),
      home: const SplashScreen(),
      // home: NotificationHelper(),
      // home:  MyAppsss(),
      // home:  MultiSelectionDeleteDemo(),
      // home: const HomeScreen(),
    );
  }
}