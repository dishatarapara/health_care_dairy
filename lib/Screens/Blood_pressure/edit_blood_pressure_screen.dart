import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:health_care_dairy/ConstFile/constPreferences.dart';
import 'package:health_care_dairy/Controller/blood_sugar_controller.dart';
import 'package:health_care_dairy/Controller/date_time_controller.dart';
import 'package:intl/intl.dart';

import '../../Common/bottom_button.dart';
import '../../ConstFile/constColors.dart';
import '../../ConstFile/constFonts.dart';
import '../../Controller/blood_pressure_controller.dart';

class UpdateBloodPressureScreen extends StatefulWidget {
  final String catId;
  const UpdateBloodPressureScreen({super.key,  required this.catId});

  @override
  State<UpdateBloodPressureScreen> createState() => _UpdateBloodPressureScreenState();
}

class _UpdateBloodPressureScreenState extends State<UpdateBloodPressureScreen> {
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
    dateTimeController.selectedDate.toString();
    dateTimeController.selectedTime.toString();
    bloodPressureController.getUpdateBloodPressureList(widget.catId);
  }

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        bloodSugarController.getCategoryList();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ConstColour.appColor,
          elevation: 0.0,
          title: Text(
            "Update Blood Pressure",
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
              // bloodSugarController.getCategoryList();
            },
            icon: Icon(Icons.arrow_back),
            color: ConstColour.textColor,
          ),
        ),
        backgroundColor: ConstColour.bgColor,
        body: Obx(() => bloodPressureController.updateBloodPressureList.isEmpty
            ? Center(child: CircularProgressIndicator(color: ConstColour.buttonColor,))
            : Column(
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
                                  fontSize: 15,
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
                                  fontSize: 15,
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
                                fontSize: 15,
                                fontFamily: ConstFont.bold
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
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
                                      hintText: bloodPressureController.systolicPressureController.text.isEmpty ? "0" : bloodPressureController.systolicPressureController.text.toString(),
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
                                fontSize: 15,
                                fontFamily: ConstFont.bold
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
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
                                      hintText: bloodPressureController.diastolicPressureController.text.isEmpty ? "0" : bloodPressureController.diastolicPressureController.text.toString(),
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
                                fontSize: 15,
                                fontFamily: ConstFont.bold
                            ),
                          ),
                          Expanded(
                            child: TextFormField(
                              autovalidateMode: AutovalidateMode.onUserInteraction,
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
                                hintText: bloodPressureController.pulesRateController.text.isEmpty
                                    ? "beats per minute"
                                    : bloodPressureController.pulesRateController.text.toString(),
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
                                        fontSize: 15,
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
                                        fontSize: 15,
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
                                fontSize: 15,
                                fontFamily: ConstFont.bold
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: deviceWidth * 0.02
                              ),
                              child: TextFormField(
                                cursorColor: ConstColour.buttonColor,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
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
                                  hintText: bloodPressureController.pressureCommentController.text.isEmpty
                                      ? "Enter your comments"
                                      : bloodPressureController.pressureCommentController.text.toString(),
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
              padding: EdgeInsets.only(top: deviceHeight * 0.01),
              child: NextButton(
                onPressed: () {
                  var date =  DateFormat('dd/MM/yyyy').format(dateTimeController.selectedDate.value);
                  var time = dateTimeController.formattedTime.value.isEmpty ? formatter.format(current_Datetime) : dateTimeController.formattedTime.value;
                  bloodPressureController.UpdatebloodPressureList(
                      bloodPressureController.pressureId.value,
                      date.toString(),
                      bloodPressureController.systolicPressureController.text,
                      bloodPressureController.diastolicPressureController.text,
                      bloodPressureController.pulesRateController.text,
                      bloodPressureController.pressureCommentController.text,
                      time.toString()
                  );
                  // bloodPressureController.BloodPressureList(time.toString());
                  // bloodSugarController.BloodSugarList();
                  // Get.to(() => BloodPressure());
                },
                btnName: "Save",
              ),
            ),
          ],
        ),
        ),
      ),
    );
  }
}
