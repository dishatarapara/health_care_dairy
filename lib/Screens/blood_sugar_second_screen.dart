import 'package:flutter/material.dart';
import 'package:health_care_dairy/ConstFile/constColors.dart';

import '../ConstFile/constFonts.dart';
import 'blood_sugar_screen.dart';

class BloodSugarScreen extends StatefulWidget {
  const BloodSugarScreen({super.key});

  @override
  State<BloodSugarScreen> createState() => _BloodSugarScreenState();
}

class _BloodSugarScreenState extends State<BloodSugarScreen> {
  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ConstColour.appColor,
        elevation: 0.0,
        title: Text(
          "Add Blood Sugar",
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
                  builder: (context) => BloodSugar()),
            );
          },
          icon: Icon(Icons.arrow_back),
          color: ConstColour.textColor,
        ),
      ),
      backgroundColor: ConstColour.bgColor,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: deviceHeight * 0.02,
              left: deviceWidth * 0.03,
              right: deviceWidth * 0.03
            ),
            child: Card(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: ConstColour.appColor
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            'Date',
                            style: TextStyle(
                              fontFamily: ConstFont.bold
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: deviceHeight * 0.02,
                        left: deviceWidth * 0.02,
                        bottom: deviceHeight * 0.01
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Time',
                            style: TextStyle(
                                fontFamily: ConstFont.bold
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: deviceHeight * 0.02,
                          left: deviceWidth * 0.02,
                          bottom: deviceHeight * 0.01
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Blood glucose',
                            style: TextStyle(
                                fontFamily: ConstFont.bold
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: deviceHeight * 0.02,
                          left: deviceWidth * 0.02,
                          bottom: deviceHeight * 0.01
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Measured type',
                            style: TextStyle(
                                fontFamily: ConstFont.bold
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: deviceHeight * 0.02,
                          left: deviceWidth * 0.02,
                          bottom: deviceHeight * 0.015
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Comments',
                            style: TextStyle(
                                fontFamily: ConstFont.bold
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
