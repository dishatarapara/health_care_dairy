import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../Common/bottom_button.dart';
import '../ConstFile/constColors.dart';
import '../ConstFile/constFonts.dart';
import '../Controller/unit_controller.dart';
import 'home_screen.dart';

class UnitScreen extends StatefulWidget {
  const UnitScreen({super.key});

  @override
  State<UnitScreen> createState() => _UnitScreenState();
}

class _UnitScreenState extends State<UnitScreen> {
  UnitController unitController = Get.put(UnitController());

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: ConstColour.appColor,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(9.0),
        child: NextButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                )
            );
          },
          btnName: "NEXT",
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'MySugar - Track Blood Sugar, Blood \n Pressure',
            style: TextStyle(
                fontFamily: ConstFont.bold,
                fontSize: 25
            ),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: EdgeInsets.only(
              top: deviceHeight * 0.01,
            ),
            child: Text(
              "Let's set up the application for you",
              style: TextStyle(
                color: Colors.grey,
                  fontFamily: ConstFont.regular,
                  fontSize: 18
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: deviceHeight * 0.01,
            ),
            child: Text(
              'What are the units of \n measurement?',
              style: TextStyle(
                  fontFamily: ConstFont.bold,
                  fontSize: 28
              ),
            textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: deviceHeight * 0.07
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: deviceHeight * 0.021,
                  child: ClipRRect(
                      child: Image.asset("assets/Icons/blood_sugar.png",fit: BoxFit.cover)),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: deviceWidth * 0.03
                  ),
                  child: Text(
                      'Blood Glucose Level',
                      style: TextStyle(
                        fontSize: 25,
                        fontFamily: ConstFont.bold,
                      ),
                      overflow: TextOverflow.ellipsis
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: deviceHeight * 0.02
            ),
            child: Container(
              height: deviceHeight * 0.05,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                color: ConstColour.bgColor
              ),
              child: ToggleSwitch(
                minWidth: 105,
                cornerRadius: 30.0,
                activeBgColors: [[ConstColour.buttonColor], [ConstColour.buttonColor]],
                activeFgColor: ConstColour.appColor,
                inactiveBgColor: ConstColour.bgColor,
                inactiveFgColor: ConstColour.textColor,
                initialLabelIndex: 0,
                totalSwitches: 2,
                labels: ['mmol/L', 'mg/dL'],
                customTextStyles: [
                  TextStyle(
                      fontFamily: ConstFont.bold,
                      fontSize: 16
                  )
                ],
                radiusStyle: true,
              ),
              // child: Padding(
              //   padding: EdgeInsets.only(
              //     left: deviceWidth * 0.05,
              //     right: deviceWidth * 0.05
              //   ),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       InkWell(
              //         onTap: () {},
              //         child: Text(
              //             'mmol/L',
              //           style: TextStyle(
              //             fontSize: 18,
              //             color: ConstColour.textColor,
              //             fontFamily: ConstFont.bold
              //           ),
              //         ),
              //       ),
              //       InkWell(
              //         onTap: () {},
              //         child: Text(
              //           'mg/dL',
              //           style: TextStyle(
              //               fontSize: 18,
              //               color: ConstColour.textColor,
              //               fontFamily: ConstFont.bold
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: deviceHeight * 0.05
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: deviceHeight * 0.021,
                  child: ClipRRect(
                      child: Image.asset("assets/Icons/weight.png",fit: BoxFit.cover)),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: deviceWidth * 0.03
                  ),
                  child: Text(
                      'Other units',
                      style: TextStyle(
                        fontSize: 25,
                        fontFamily: ConstFont.bold,
                      ),
                      overflow: TextOverflow.ellipsis
                  ),
                ),
              ],
            ),
          ),
          Obx(() => Padding(
            padding: EdgeInsets.only(
                top: deviceHeight * 0.02
            ),
            child: Container(
              height: deviceHeight * 0.05,
              width: deviceWidth * 0.55,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  color: ConstColour.bgColor
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: deviceHeight * 0.05,
                    width: deviceWidth * 0.3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      color: unitController.selectIndex.value == 1 ? ConstColour.bgColor : ConstColour.buttonColor,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        unitController.selectIndex.value = 2;
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: deviceHeight * 0.012,
                          left: deviceWidth * 0.06,
                        ),
                        child: RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: 'MATRIC',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: unitController.selectIndex.value == 1 ? ConstColour.textColor : ConstColour.bgColor,
                                    fontFamily: ConstFont.bold
                                ),
                              ),
                              TextSpan(
                                text: ' kg',
                                style: TextStyle(
                                    fontSize: 11,
                                    color: unitController.selectIndex.value == 1 ? ConstColour.textColor : ConstColour.bgColor,
                                    fontFamily: ConstFont.regular
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: deviceHeight * 0.05,
                    width: deviceWidth * 0.25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      color: unitController.selectIndex.value == 2 ? ConstColour.bgColor : ConstColour.buttonColor,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        unitController.selectIndex.value = 1;
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: deviceHeight * 0.012,
                          left: deviceWidth * 0.08,
                        ),
                        child: RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: 'US',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: unitController.selectIndex.value == 2 ? ConstColour.textColor : ConstColour.bgColor,
                                    fontFamily: ConstFont.bold
                                ),
                              ),
                              TextSpan(
                                text: ' lbs',
                                style: TextStyle(
                                    fontSize: 11,
                                    color: unitController.selectIndex.value == 2 ? ConstColour.textColor : ConstColour.bgColor,
                                    fontFamily: ConstFont.regular
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
          Padding(
            padding: EdgeInsets.only(
                top: deviceHeight * 0.05
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: deviceHeight * 0.021,
                  child: ClipRRect(
                      child: Image.asset("assets/Icons/body_temperature.png",fit: BoxFit.cover)),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: deviceWidth * 0.03
                  ),
                  child: Text(
                      'Body Temperature',
                      style: TextStyle(
                        fontSize: 25,
                        fontFamily: ConstFont.bold,
                      ),
                      overflow: TextOverflow.ellipsis
                  ),
                ),
              ],
            ),
          ),
          Obx(() => Padding(
            padding: EdgeInsets.only(
                top: deviceHeight * 0.02
            ),
            child: Container(
              height: deviceHeight * 0.05,
              width: deviceWidth * 0.7,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  color: ConstColour.bgColor
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: deviceHeight * 0.05,
                    width: deviceWidth * 0.35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      color: unitController.bodyIndex.value == 3 ? ConstColour.bgColor : ConstColour.buttonColor,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        unitController.bodyIndex.value = 4;
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: deviceHeight * 0.012,
                          left: deviceWidth * 0.09,
                        ),
                        child: RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Celsius',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: unitController.bodyIndex.value == 3 ? ConstColour.textColor : ConstColour.bgColor,
                                    fontFamily: ConstFont.bold
                                ),
                              ),
                              TextSpan(
                                text: ' ℃',
                                style: TextStyle(
                                    fontSize: 11,
                                    color: unitController.bodyIndex.value == 3 ? ConstColour.textColor : ConstColour.bgColor,
                                    fontFamily: ConstFont.regular
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: deviceHeight * 0.05,
                    width: deviceWidth * 0.35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      color: unitController.bodyIndex.value == 4 ? ConstColour.bgColor : ConstColour.buttonColor,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        unitController.bodyIndex.value = 3;
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                        top: deviceHeight * 0.012,
                        left: deviceWidth * 0.06,
                      ),
                        child: RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Fahrenheit',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: unitController.bodyIndex.value == 4 ? ConstColour.textColor : ConstColour.bgColor,
                                    fontFamily: ConstFont.bold
                                ),
                              ),
                              TextSpan(
                                text: ' ºf',
                                style: TextStyle(
                                    fontSize: 11,
                                    color: unitController.bodyIndex.value == 4 ? ConstColour.textColor : ConstColour.bgColor,
                                    fontFamily: ConstFont.regular
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }
}
