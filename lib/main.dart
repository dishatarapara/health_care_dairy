import 'package:flutter/material.dart';
import 'package:health_care_dairy/register_screen.dart';
import 'package:health_care_dairy/terms.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        textTheme: Typography.blackCupertino,
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: TermsScreen(),
    );

  }
}



