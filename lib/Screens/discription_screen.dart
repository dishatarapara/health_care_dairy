import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_care_dairy/ConstFile/constColors.dart';
import '../ConstFile/constFonts.dart';

class DiscriptionScreen extends StatefulWidget {
  final String title;
  final String description;
  final String detailedDescription;

  const DiscriptionScreen({
    Key? key,
    required this.title,
    required this.description,
    required this.detailedDescription,
  }) : super(key: key);

  @override
  State<DiscriptionScreen> createState() => _DiscriptionScreenState();
}

class _DiscriptionScreenState extends State<DiscriptionScreen> {
  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ConstColour.appColor,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back),
          color: ConstColour.textColor,
        ),
        elevation: 0.0,
      ),
      backgroundColor: ConstColour.appColor,
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          left: deviceWidth * 0.03,
          right: deviceWidth * 0.03,
          bottom: deviceHeight * 0.02,
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            minimumSize: Size(deviceWidth * 1.0, deviceHeight * 0.06),
            backgroundColor: ConstColour.buttonColor,
          ),
          onPressed: () {
            Get.back();
          },
          child: Text(
            "Got it",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Text(
                widget.title,
                style: TextStyle(
                  fontSize: 25,
                  color: ConstColour.buttonColor,
                  fontFamily: ConstFont.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: deviceHeight * 0.03,
                  left: deviceWidth * 0.08,
                right: deviceWidth * 0.08
              ),
              child: Text(
                widget.description,
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: ConstFont.regular,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: deviceHeight * 0.03,
                  left: deviceWidth * 0.08,
                  right: deviceWidth * 0.08
              ),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  widget.detailedDescription,
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: ConstFont.regular,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
