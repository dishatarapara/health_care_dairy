import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:health_care_dairy/Controller/blood_sugar_controller.dart';
import 'package:health_care_dairy/Controller/unit_controller.dart';
import 'package:intl/intl.dart';

import '../../Common/bottom_button.dart';
import '../../ConstFile/constColors.dart';
import '../../ConstFile/constFonts.dart';
import '../../Controller/body_temperature_controller.dart';
import '../../Controller/date_time_controller.dart';

class UpdateBodyTemperatureScreen extends StatefulWidget {
  final String catId;
  const UpdateBodyTemperatureScreen({super.key,  required this.catId});

  @override
  State<UpdateBodyTemperatureScreen> createState() => _UpdateBodyTemperatureScreenState();
}

class _UpdateBodyTemperatureScreenState extends State<UpdateBodyTemperatureScreen> {
  BloodSugarController bloodSugarController = Get.put(BloodSugarController());
  UnitController unitController = Get.put(UnitController());
  BodyTemperatureController bodyTemperatureController = Get.put(BodyTemperatureController());
  DateTimeController dateTimeController = Get.put(DateTimeController());
  DateTime current_Datetime = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, DateTime.now().hour, DateTime.now().minute);
  DateFormat formatter = DateFormat('h:mm a');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      bodyTemperatureController.getUpdateBodyTemperatureList(widget.catId);
    });
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
            "Update Body Temperature",
            style: TextStyle(
                color: ConstColour.textColor,
                fontFamily: ConstFont.regular,
                fontWeight: FontWeight.w800,
                overflow: TextOverflow.ellipsis
            ),
          ),
          leading: IconButton(
            onPressed: () {
              // Get.to(() => BodyTemperature());
              Get.back();
            },
            icon: Icon(Icons.arrow_back),
            color: ConstColour.textColor,
          ),
        ),
        backgroundColor: ConstColour.bgColor,
        body: Obx(() => bodyTemperatureController.updateBodyTemperatureList.isEmpty
            ? Center(child: CircularProgressIndicator(color: ConstColour.buttonColor),)
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
                            'Body Temperature',
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
                                    controller: bodyTemperatureController.temperatureController,
                                    cursorColor: ConstColour.buttonColor,
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: ConstColour.textColor,
                                        fontFamily: ConstFont.regular
                                    ),
                                    autocorrect: true,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*')),
                                      LengthLimitingTextInputFormatter(5)
                                    ],
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "0",
                                      // bodyTemperatureController.temperatureController.text.isEmpty
                                      //     ? "0"
                                      //     : bodyTemperatureController.temperatureController.text.toString(),
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
                                    ' ${bodyTemperatureController.newValue.value == true ? '℃' : 'ºf'}',
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
                                controller: bodyTemperatureController.temperatureCommentController,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: ConstColour.textColor,
                                    fontFamily: ConstFont.regular
                                ),
                                autocorrect: true,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: bodyTemperatureController.temperatureCommentController.text.isEmpty
                                      ? "Enter your comments"
                                      : bodyTemperatureController.temperatureCommentController.text.toString(),
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
                    var date =  DateFormat('dd/MM/yyyy').format(dateTimeController.selectedDate.value);
                    var time = dateTimeController.formattedTime.value.isEmpty ? formatter.format(current_Datetime) : dateTimeController.formattedTime.value;
                    await bodyTemperatureController.UpdatebodyTemperatureList(
                        bodyTemperatureController.temperatureId.value,
                        date.toString(),
                        bodyTemperatureController.temperatureController.text,
                        bodyTemperatureController.temperatureCommentController.text,
                        time.toString());
                  } catch(e) {
                    debugPrint(" Error: $e");
                  }
                  // bloodSugarController.BloodSugarList();
                  // Get.to(() => BodyTemperature());
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
              //     var date =  DateFormat('dd/MM/yyyy').format(dateTimeController.selectedDate.value);
              //     var time = dateTimeController.formattedTime.value.isEmpty ? formatter.format(current_Datetime) : dateTimeController.formattedTime.value;
              //     bodyTemperatureController.UpdatebodyTemperatureList(
              //       bodyTemperatureController.temperatureId.value,
              //         date.toString(),
              //         bodyTemperatureController.temperatureController.text,
              //         bodyTemperatureController.temperatureCommentController.text,
              //         time.toString());
              //       // bloodSugarController.BloodSugarList();
              //     // Get.to(() => BodyTemperature());
              //   },
              //   btnName: "Save",
              // ),
            )
          ],
        )),
      ),
    );
  }
}
