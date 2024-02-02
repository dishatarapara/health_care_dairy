import 'package:flutter/material.dart';
import 'package:health_care_dairy/login_screen.dart';
import 'package:health_care_dairy/setting.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text ('Home',),
        actions: [
        IconButton(
    icon: const Icon(Icons.settings),
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Settingscreen()),
      );
      },
    ),
    ]),
      body: Center(child: Text("Home",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),)) ,
    
    );
  }
}
