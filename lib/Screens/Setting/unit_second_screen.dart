import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_care_dairy/ConstFile/constPreferences.dart';
import 'package:health_care_dairy/Controller/body_temperature_controller.dart';
import 'package:health_care_dairy/Screens/Setting/setting_screen.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../ConstFile/constColors.dart';
import '../../ConstFile/constFonts.dart';
import '../../Controller/unit_controller.dart';
import '../../Controller/weight_controller.dart';

class UnitSecondScreen extends StatefulWidget {
  const UnitSecondScreen({super.key});

  @override
  State<UnitSecondScreen> createState() => _UnitSecondScreenState();
}

class _UnitSecondScreenState extends State<UnitSecondScreen> {
  UnitController unitController = Get.put(UnitController());
  WeightController weightController = Get.put(WeightController());
  BodyTemperatureController bodyTemperatureController = Get.put(BodyTemperatureController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
    getBodyPref();
  }


  void getPref() async{
    print("otherunit "+weightController.newVal.value.toString());
    await ConstPreferences().saveOtherUnit(weightController.newVal.value);
    var otherUnitval = await ConstPreferences().getOtherUnit();
    weightController.newVal.value = otherUnitval!;
    print("otherval "+otherUnitval.toString());
  }

  void getBodyPref() async{
    print("bodyTemperature "+bodyTemperatureController.newValue.value.toString());
    await ConstPreferences().saveBodyTemperature(bodyTemperatureController.newValue.value);
    var val = await ConstPreferences().getBodyTemperature();
    weightController.newVal.value = val!;
    print("val "+val.toString());
  }


  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: ConstColour.appColor,
      appBar: AppBar(
        backgroundColor: ConstColour.appColor,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Get.to(() => SettingScreen());
          },
          icon: Icon(Icons.arrow_back),
          color: ConstColour.textColor,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'What are the units of \n measurement?',
            style: TextStyle(
                fontFamily: ConstFont.bold,
                fontSize: 30
            ),
            textAlign: TextAlign.center,
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
                initialLabelIndex: unitController.glucoseLevel.value ? 0 : 1,
                totalSwitches: 2,
                labels: ['mmol/L', 'mg/dL'],
                customTextStyles: [
                  TextStyle(
                      fontFamily: ConstFont.bold,
                      fontSize: 16
                  )
                ],
                radiusStyle: true,
                onToggle: (index) {
                  unitController.saveGlucoseLevel(index == 0);
                },
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
                      //     color: unitController.selectIndex.value == 1 ? ConstColour.bgColor : ConstColour.buttonColor,
                      color: weightController.newVal.value == false ? ConstColour.bgColor : ConstColour.buttonColor,
                    ),
                    child: GestureDetector(
                      onTap: () async {
                        await ConstPreferences().saveOtherUnit(true);
                        weightController.newVal.value = true;
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
                                    color: weightController.newVal.value == false ? ConstColour.textColor : ConstColour.bgColor,
                                    fontFamily: ConstFont.bold
                                ),
                              ),
                              TextSpan(
                                text: ' kg',
                                style: TextStyle(
                                    fontSize: 11,
                                    color: weightController.newVal.value == false ? ConstColour.textColor : ConstColour.bgColor,
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
                      color: weightController.newVal.value == true ? ConstColour.bgColor : ConstColour.buttonColor,
                    ),
                    child: GestureDetector(
                      onTap: () async {
                        await ConstPreferences().saveOtherUnit(false);
                        unitController.selectIndex.value = 1;
                        weightController.newVal.value = false;
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
                                    color: weightController.newVal.value == true ? ConstColour.textColor : ConstColour.bgColor,
                                    fontFamily: ConstFont.bold
                                ),
                              ),
                              TextSpan(
                                text: ' lbs',
                                style: TextStyle(
                                    fontSize: 11,
                                    color: weightController.newVal.value == true ? ConstColour.textColor : ConstColour.bgColor,
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
          // Obx(() => Padding(
          //   padding: EdgeInsets.only(
          //       top: deviceHeight * 0.02
          //   ),
          //   child: Container(
          //     height: deviceHeight * 0.05,
          //     width: deviceWidth * 0.55,
          //     decoration: BoxDecoration(
          //         borderRadius: BorderRadius.all(Radius.circular(30)),
          //         color: ConstColour.bgColor
          //     ),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         Container(
          //           height: deviceHeight * 0.05,
          //           width: deviceWidth * 0.3,
          //           decoration: BoxDecoration(
          //             borderRadius: BorderRadius.all(Radius.circular(30)),
          //             color: unitController.selectIndex.value == 1 ? ConstColour.bgColor : ConstColour.buttonColor,
          //           ),
          //           child: GestureDetector(
          //             onTap: () async {
          //               await ConstPreferences().saveOtherUnit(true);
          //               print("true 262");
          //               unitController.selectIndex.value = 2;
          //             },
          //             child: Padding(
          //               padding: EdgeInsets.only(
          //                 top: deviceHeight * 0.012,
          //                 left: deviceWidth * 0.06,
          //               ),
          //               child: RichText(
          //                 text: TextSpan(
          //                   children: <TextSpan>[
          //                     TextSpan(
          //                       text: 'MATRIC',
          //                       style: TextStyle(
          //                           fontSize: 16,
          //                           color: unitController.selectIndex.value == 1 ? ConstColour.textColor : ConstColour.bgColor,
          //                           fontFamily: ConstFont.bold
          //                       ),
          //                     ),
          //                     TextSpan(
          //                       text: ' kg',
          //                       style: TextStyle(
          //                           fontSize: 11,
          //                           color: unitController.selectIndex.value == 1 ? ConstColour.textColor : ConstColour.bgColor,
          //                           fontFamily: ConstFont.regular
          //                       ),
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ),
          //         Container(
          //           height: deviceHeight * 0.05,
          //           width: deviceWidth * 0.25,
          //           decoration: BoxDecoration(
          //             borderRadius: BorderRadius.all(Radius.circular(30)),
          //             color: unitController.selectIndex.value == 2 ? ConstColour.bgColor : ConstColour.buttonColor,
          //           ),
          //           child: GestureDetector(
          //             onTap: () async {
          //               await ConstPreferences().saveOtherUnit(false);
          //               print("false 151");
          //               unitController.selectIndex.value = 1;
          //             },
          //             child: Padding(
          //               padding: EdgeInsets.only(
          //                 top: deviceHeight * 0.012,
          //                 left: deviceWidth * 0.08,
          //               ),
          //               child: RichText(
          //                 text: TextSpan(
          //                   children: <TextSpan>[
          //                     TextSpan(
          //                       text: 'US',
          //                       style: TextStyle(
          //                           fontSize: 16,
          //                           color: unitController.selectIndex.value == 2 ? ConstColour.textColor : ConstColour.bgColor,
          //                           fontFamily: ConstFont.bold
          //                       ),
          //                     ),
          //                     TextSpan(
          //                       text: ' lbs',
          //                       style: TextStyle(
          //                           fontSize: 11,
          //                           color: unitController.selectIndex.value == 2 ? ConstColour.textColor : ConstColour.bgColor,
          //                           fontFamily: ConstFont.regular
          //                       ),
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // )),
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
                      // color: unitController.bodyIndex.value == 3 ? ConstColour.bgColor : ConstColour.buttonColor,
                      color: bodyTemperatureController.newValue.value == false ? ConstColour.bgColor : ConstColour.buttonColor,
                    ),
                    child: GestureDetector(
                      onTap: () async {
                        await ConstPreferences().saveBodyTemperature(true);
                        bodyTemperatureController.newValue.value = true;
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
                                    // color: unitController.bodyIndex.value == 3 ? ConstColour.textColor : ConstColour.bgColor,
                                    color: bodyTemperatureController.newValue.value == false ? ConstColour.textColor : ConstColour.bgColor,
                                    fontFamily: ConstFont.bold
                                ),
                              ),
                              TextSpan(
                                text: ' ℃',
                                style: TextStyle(
                                    fontSize: 11,
                                    color: bodyTemperatureController.newValue.value == false ? ConstColour.textColor : ConstColour.bgColor,                                    fontFamily: ConstFont.regular
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
                      // color: unitController.bodyIndex.value == 4 ? ConstColour.bgColor : ConstColour.buttonColor,
                      color: bodyTemperatureController.newValue.value == true ? ConstColour.bgColor : ConstColour.buttonColor,
                    ),
                    child: GestureDetector(
                      onTap: () async {
                        await ConstPreferences().saveBodyTemperature(false);
                        unitController.bodyIndex.value = 3;
                        bodyTemperatureController.newValue.value = false;
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
                                    // color: unitController.bodyIndex.value == 4 ? ConstColour.textColor : ConstColour.bgColor,
                                    color: bodyTemperatureController.newValue.value == true ? ConstColour.textColor : ConstColour.bgColor,
                                    fontFamily: ConstFont.bold
                                ),
                              ),
                              TextSpan(
                                text: ' ºf',
                                style: TextStyle(
                                    fontSize: 11,
                                    color: bodyTemperatureController.newValue.value == true ? ConstColour.textColor : ConstColour.bgColor,                                    fontFamily: ConstFont.regular
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
          // Obx(() => Padding(
          //   padding: EdgeInsets.only(
          //       top: deviceHeight * 0.02
          //   ),
          //   child: Container(
          //     height: deviceHeight * 0.05,
          //     width: deviceWidth * 0.7,
          //     decoration: BoxDecoration(
          //         borderRadius: BorderRadius.all(Radius.circular(30)),
          //         color: ConstColour.bgColor
          //     ),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         Container(
          //           height: deviceHeight * 0.05,
          //           width: deviceWidth * 0.35,
          //           decoration: BoxDecoration(
          //             borderRadius: BorderRadius.all(Radius.circular(30)),
          //             color: unitController.bodyIndex.value == 3 ? ConstColour.bgColor : ConstColour.buttonColor,
          //           ),
          //           child: GestureDetector(
          //             onTap: () async {
          //              // await ConstPreferences().saveOtherUnit(true);
          //               unitController.bodyIndex.value = 4;
          //             },
          //             child: Padding(
          //               padding: EdgeInsets.only(
          //                 top: deviceHeight * 0.012,
          //                 left: deviceWidth * 0.09,
          //               ),
          //               child: RichText(
          //                 text: TextSpan(
          //                   children: <TextSpan>[
          //                     TextSpan(
          //                       text: 'Celsius',
          //                       style: TextStyle(
          //                           fontSize: 16,
          //                           color: unitController.bodyIndex.value == 3 ? ConstColour.textColor : ConstColour.bgColor,
          //                           fontFamily: ConstFont.bold
          //                       ),
          //                     ),
          //                     TextSpan(
          //                       text: ' ℃',
          //                       style: TextStyle(
          //                           fontSize: 11,
          //                           color: unitController.bodyIndex.value == 3 ? ConstColour.textColor : ConstColour.bgColor,
          //                           fontFamily: ConstFont.regular
          //                       ),
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ),
          //         Container(
          //           height: deviceHeight * 0.05,
          //           width: deviceWidth * 0.35,
          //           decoration: BoxDecoration(
          //             borderRadius: BorderRadius.all(Radius.circular(30)),
          //             color: unitController.bodyIndex.value == 4 ? ConstColour.bgColor : ConstColour.buttonColor,
          //           ),
          //           child: GestureDetector(
          //             onTap: () async {
          //             //  await ConstPreferences().saveOtherUnit(false);
          //               unitController.bodyIndex.value = 3;
          //             },
          //             child: Padding(
          //               padding: EdgeInsets.only(
          //                 top: deviceHeight * 0.012,
          //                 left: deviceWidth * 0.06,
          //               ),
          //               child: RichText(
          //                 text: TextSpan(
          //                   children: <TextSpan>[
          //                     TextSpan(
          //                       text: 'Fahrenheit',
          //                       style: TextStyle(
          //                           fontSize: 16,
          //                           color: unitController.bodyIndex.value == 4 ? ConstColour.textColor : ConstColour.bgColor,
          //                           fontFamily: ConstFont.bold
          //                       ),
          //                     ),
          //                     TextSpan(
          //                       text: ' ºf',
          //                       style: TextStyle(
          //                           fontSize: 11,
          //                           color: unitController.bodyIndex.value == 4 ? ConstColour.textColor : ConstColour.bgColor,
          //                           fontFamily: ConstFont.regular
          //                       ),
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // )),
        ],
      ),
    );
  }
}
