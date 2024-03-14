import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:health_care_dairy/ConstFile/constPreferences.dart';
import 'package:health_care_dairy/Controller/blood_sugar_controller.dart';
import 'package:health_care_dairy/Controller/date_time_controller.dart';
import 'package:intl/intl.dart';

import '../../Common/bottom_button.dart';
import '../../Common/snackbar.dart';
import '../../ConstFile/constColors.dart';
import '../../ConstFile/constFonts.dart';
import '../../Controller/blood_pressure_controller.dart';

class BloodPressureScreen extends StatefulWidget {
  const BloodPressureScreen({super.key});

  @override
  State<BloodPressureScreen> createState() => _BloodPressureScreenState();
}

class _BloodPressureScreenState extends State<BloodPressureScreen> {
  BloodSugarController bloodSugarController = Get.put(BloodSugarController());
  BloodPressureController bloodPressureController = Get.put(BloodPressureController());
  DateTimeController dateTimeController = Get.put(DateTimeController());
  DateTime current_Datetime = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, DateTime.now().hour, DateTime.now().minute);
  DateFormat formatter = DateFormat('h:mm a');

  final formkey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloodPressureController.selectedRadio.value = 0;
  }

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ConstColour.appColor,
        elevation: 0.0,
        title: Text(
          "Add Blood Pressure",
          style: TextStyle(
              color: ConstColour.textColor,
              fontFamily: ConstFont.regular,
              fontWeight: FontWeight.w800,
              overflow: TextOverflow.ellipsis
          ),
        ),
        leading: IconButton(
          onPressed: () {
            // Get.to(() => BloodPressure());
            Get.back();
          },
          icon: Icon(Icons.arrow_back),
          color: ConstColour.textColor,
        ),
      ),
      backgroundColor: ConstColour.bgColor,
      body: Obx(() => Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: deviceWidth * 0.02,
                vertical: deviceHeight * 0.02
            ),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  InkWell(
                    onTap: () => dateTimeController.pickDate(),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: deviceWidth * 0.03,
                          vertical: deviceHeight * 0.015
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Date',
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: ConstFont.bold
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                DateFormat('dd/MM/yyyy').format(dateTimeController.selectedDate.value),
                                style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: ConstFont.regular
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: deviceWidth * 0.03
                                ),
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  size: 20,
                                  color: ConstColour.textColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => dateTimeController.pickTime(),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: deviceWidth * 0.03,
                          vertical: deviceHeight * 0.015
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Time',
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: ConstFont.bold
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                dateTimeController.formattedTime.value.isEmpty
                                    ? formatter.format(current_Datetime)
                                    : dateTimeController.formattedTime.value,
                                // dateTimeController.formattedTime.value,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: ConstFont.regular
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: deviceWidth * 0.03
                                ),
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  size: 20,
                                  color: ConstColour.textColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: deviceWidth * 0.03,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Systolic Pressure',
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: ConstFont.bold
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: bloodPressureController.systolicPressureController,
                                  cursorColor: ConstColour.buttonColor,
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: ConstColour.textColor,
                                      fontFamily: ConstFont.regular
                                  ),
                                  autocorrect: true,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(5)
                                  ],
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "0",
                                    hintStyle: TextStyle(
                                        fontSize: 20,
                                        color: ConstColour.greyTextColor,
                                        fontFamily: ConstFont.regular
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: deviceWidth * 0.03
                                ),
                                child: Text(
                                  'mmHg',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: ConstColour.greyTextColor,
                                      fontFamily: ConstFont.regular
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: deviceWidth * 0.03,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Diastolic Pressure',
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: ConstFont.bold
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: bloodPressureController.diastolicPressureController,
                                  cursorColor: ConstColour.buttonColor,
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: ConstColour.textColor,
                                      fontFamily: ConstFont.regular
                                  ),
                                  autocorrect: true,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(5)
                                  ],
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "0",
                                    hintStyle: TextStyle(
                                        fontSize: 20,
                                        color: ConstColour.greyTextColor,
                                        fontFamily: ConstFont.regular
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: deviceWidth * 0.03
                                ),
                                child: Text(
                                  'mmHg',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: ConstColour.greyTextColor,
                                      fontFamily: ConstFont.regular
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: deviceWidth * 0.03,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Pulse Rate',
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: ConstFont.bold
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            controller: bloodPressureController.pulesRateController,
                            cursorColor: ConstColour.buttonColor,
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontSize: 18,
                                color: ConstColour.textColor,
                                fontFamily: ConstFont.regular
                            ),
                            autocorrect: true,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(5)
                            ],
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "beats per minute",
                              hintStyle: TextStyle(
                                  fontSize: 20,
                                  color: ConstColour.greyTextColor,
                                  fontFamily: ConstFont.regular
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                          child: InkWell(
                            onTap: () async {
                              bloodPressureController.setSelectedRadio(1);
                              await ConstPreferences().saveHand(true);
                              print(bloodPressureController.setSelectedRadio.toString());
                              print("true");
                              // bloodSugarController.selectedRadio.value = 1;
                            },
                            child: Row(
                              children: [
                                Radio(
                                  value: 1,
                                  groupValue: bloodPressureController.selectedRadio.value,
                                  onChanged: bloodPressureController.setSelectedRadio,
                                  activeColor: ConstColour.buttonColor,
                                ),
                                Text(
                                  "Left Hand",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: ConstFont.regular,
                                      color: bloodPressureController.selectedRadio.value == 1
                                          ? ConstColour.textColor
                                          : ConstColour.greyTextColor
                                  ),
                                ),
                              ],
                            ),
                          )
                      ),
                      Expanded(
                          child: InkWell(
                            onTap: () async {
                              bloodPressureController.setSelectedRadio(0);
                              await ConstPreferences().saveHand(false);
                              print(bloodPressureController.setSelectedRadio.toString());
                              print("false");
                              // bloodSugarController.selectedRadio.value = 0;
                            },
                            child: Row(
                              children: [
                                Radio(
                                  value: 0,
                                  groupValue: bloodPressureController.selectedRadio.value,
                                  onChanged: bloodPressureController.setSelectedRadio,
                                  activeColor: ConstColour.buttonColor,
                                ),
                                Text(
                                  "Right Hand",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: ConstFont.regular,
                                      color: bloodPressureController.selectedRadio.value == 0
                                          ? ConstColour.textColor
                                          : ConstColour.greyTextColor
                                  ),
                                ),
                              ],
                            ),
                          )
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: deviceWidth * 0.03,
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Comments',
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: ConstFont.bold
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: deviceWidth * 0.02
                            ),
                            child: TextField(
                              cursorColor: ConstColour.buttonColor,
                              controller: bloodPressureController.pressureCommentController,
                              style: TextStyle(
                                  fontSize: 18,
                                  color: ConstColour.textColor,
                                  fontFamily: ConstFont.regular
                              ),
                              autocorrect: true,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Enter your comments",
                                hintStyle: TextStyle(
                                    fontSize: 20,
                                    color: ConstColour.greyTextColor,
                                    fontFamily: ConstFont.regular
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: deviceHeight * 0.01,
                left: deviceWidth * 0.02,
                right: deviceWidth * 0.02
            ),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    minimumSize: Size(deviceWidth * 0.9, deviceHeight * 0.06),
                    backgroundColor: ConstColour.buttonColor
                ),
                onPressed: () async {
                  try {
                    if (bloodPressureController.systolicPressureController.text.isEmpty) {
                      Utils().snackBar('Systolic Pressure', "Please Enter Systolic Pressure");
                      return;
                    } else if (bloodPressureController.diastolicPressureController.text.isEmpty) {
                      Utils().snackBar('Diastolic Pressure', "Please Enter Diastolic Pressure");
                      return;
                    }
                    // else {
                      // bloodSugarController.BloodSugarList();
                      var date =  DateFormat('dd/MM/yyyy').format(dateTimeController.selectedDate.value);
                      var time = dateTimeController.formattedTime.value.isEmpty ? formatter.format(current_Datetime) : dateTimeController.formattedTime.value;
                      await bloodPressureController.BloodPressureList(
                          date.toString(),
                          bloodPressureController.systolicPressureController.text,
                          bloodPressureController.diastolicPressureController.text,
                          bloodPressureController.pulesRateController.text,
                          bloodPressureController.pressureCommentController.text,
                          time.toString());
                    // }
                  } catch(error) {
                    debugPrint("Error: $error");
                  }
                },
                child: bloodSugarController.isLoading.value
                    ? Center(
                  child: CircularProgressIndicator(
                    color: ConstColour.appColor,
                  ),
                )
                    : Text(
                  "Save",
                  style: TextStyle(
                      fontSize: 20,
                      color: bloodSugarController.isLoading.value ? Colors.transparent : ConstColour.bgColor
                  ),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                )
            )
            // NextButton(
            //   onPressed: () {
            //     if (bloodPressureController.systolicPressureController.text.isEmpty) {
            //       Utils().snackBar('Systolic Pressure', "Please Enter Systolic Pressure");
            //     }else if (bloodPressureController.diastolicPressureController.text.isEmpty) {
            //       Utils().snackBar('Diastolic Pressure', "Please Enter Diastolic Pressure");
            //     } else {
            //       // bloodSugarController.BloodSugarList();
            //       var date =  DateFormat('dd/MM/yyyy').format(dateTimeController.selectedDate.value);
            //       var time = dateTimeController.formattedTime.value.isEmpty ? formatter.format(current_Datetime) : dateTimeController.formattedTime.value;
            //       bloodPressureController.BloodPressureList(
            //         date.toString(),
            //           bloodPressureController.systolicPressureController.text,
            //           bloodPressureController.diastolicPressureController.text,
            //           bloodPressureController.pulesRateController.text,
            //           bloodPressureController.pressureCommentController.text,
            //           time.toString());
            //     }
            //     // bloodSugarController.BloodSugarList();
            //     // Get.to(() => BloodPressure());
            //   },
            //   btnName: "Save",
            // ),
          ),
        ],
      ),
      ),
    );
  }
}
