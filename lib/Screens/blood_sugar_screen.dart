import 'package:flutter/material.dart';
import 'package:health_care_dairy/ConstFile/constColors.dart';
import 'package:health_care_dairy/Screens/blood_sugar_second_screen.dart';


import '../ConstFile/constFonts.dart';
import 'home_screen.dart';

class BloodSugar extends StatefulWidget {
  const BloodSugar({super.key});

  @override
  State<BloodSugar> createState() => _BloodSugarState();
}

class _BloodSugarState extends State<BloodSugar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ConstColour.appColor,
        elevation: 0.0,
        title: Text(
            "Blood Sugar",
          style: TextStyle(
              color: ConstColour.textColor,
              fontFamily: ConstFont.regular,
              fontWeight: FontWeight.w800,
              overflow: TextOverflow.ellipsis
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => HomeScreen()),
            );
          },
          icon: Icon(Icons.arrow_back),
          color: ConstColour.textColor,
        ),
      ),
      backgroundColor: ConstColour.bgColor,
      body: Center(

      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
            onPressed: navigateToAddPage,
          child: Icon(Icons.add),
          backgroundColor: ConstColour.buttonColor,
        ),
      ),
    );
  }

  Future<void> navigateToAddPage() async {
    final route = MaterialPageRoute(
      builder: (context) => BloodSugarScreen(),
    );
    await Navigator.push(context, route);
  }
}
