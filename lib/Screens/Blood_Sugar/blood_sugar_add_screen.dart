import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:health_care_dairy/Controller/unit_controller.dart';
import 'package:intl/intl.dart';

import '../../Common/bottom_button.dart';
import '../../Common/snackbar.dart';
import '../../ConstFile/constColors.dart';
import '../../ConstFile/constFonts.dart';
import '../../Controller/blood_sugar_controller.dart';
import '../../Controller/date_time_controller.dart';

class BloodSugarAddScreen extends StatefulWidget {
  const BloodSugarAddScreen({super.key});

  @override
  State<BloodSugarAddScreen> createState() => _BloodSugarAddScreenState();
}

class _BloodSugarAddScreenState extends State<BloodSugarAddScreen> {
  UnitController unitController = Get.put(UnitController());
  BloodSugarController bloodSugarController = Get.put(BloodSugarController());
  DateTimeController dateTimeController = Get.put(DateTimeController());
  DateTime current_Datetime = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      DateTime.now().hour,
      DateTime.now().minute);
  DateFormat formatter = DateFormat('h:mm a');


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloodSugarController.measuredTypeList();
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
          "Add Blood Sugar",
          style: TextStyle(
              color: ConstColour.textColor,
              fontFamily: ConstFont.regular,
              fontWeight: FontWeight.w800,
              overflow: TextOverflow.ellipsis),
        ),
        leading: IconButton(
          onPressed: () {
            // Get.to(() => BloodSugar());
            Get.back();
          },
          icon: Icon(Icons.arrow_back),
          color: ConstColour.textColor,
        ),
      ),
      backgroundColor: ConstColour.bgColor,
      body: Obx(
        () => Form(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: deviceWidth * 0.02,
                    vertical: deviceHeight * 0.02),
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
                              vertical: deviceHeight * 0.015),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Date',
                                style: TextStyle(
                                    fontSize: 18, fontFamily: ConstFont.bold),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    DateFormat('dd/MM/yyyy').format(
                                        dateTimeController.selectedDate.value),
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: ConstFont.regular),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: deviceWidth * 0.03),
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
                              vertical: deviceHeight * 0.015),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Time',
                                style: TextStyle(
                                    fontSize: 18, fontFamily: ConstFont.bold),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    dateTimeController.formattedTime.value.isEmpty
                                        ? formatter.format(current_Datetime)
                                        : dateTimeController.formattedTime.value,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: ConstFont.regular),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: deviceWidth * 0.03),
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
                            vertical: deviceHeight * 0.004),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Blood glucose',
                              style: TextStyle(
                                  fontSize: 18, fontFamily: ConstFont.bold),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      controller: bloodSugarController
                                          .bloodGlucoseController,
                                      cursorColor: ConstColour.buttonColor,
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: ConstColour.textColor,
                                          fontFamily: ConstFont.regular),
                                      autocorrect: true,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'^\d+\.?\d*')),
                                        LengthLimitingTextInputFormatter(7)
                                      ],
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "0",
                                        hintStyle: TextStyle(
                                            fontSize: 20,
                                            color: ConstColour.greyTextColor,
                                            fontFamily: ConstFont.regular),
                                      ),
                                      // validator: (value) {
                                      //   if (value!.isEmpty) {
                                      //     return '';
                                      //   }
                                      //   return null;
                                      // },
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: deviceWidth * 0.03),
                                    child: Text(
                                      unitController.getGlucoseLevelPreference()
                                          ? 'mmol/L'
                                          : 'mg/dL',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: ConstColour.greyTextColor,
                                          fontFamily: ConstFont.regular),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () => showBottomSheetButton(),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: deviceWidth * 0.03,
                              vertical: deviceHeight * 0.006),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                bloodSugarController.measuredType.isEmpty
                                    ? "Before Breakfast"
                                    : bloodSugarController.measuredType.value
                                        .toString(),
                                style: TextStyle(
                                    fontSize: 18, fontFamily: ConstFont.bold),
                              ),
                              Icon(
                                Icons.arrow_drop_down,
                                color: ConstColour.greyTextColor,
                                size: 35,
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: deviceWidth * 0.03,
                            vertical: deviceHeight * 0.004),
                        child: Row(
                          children: [
                            Text(
                              'Comments',
                              style: TextStyle(
                                  fontSize: 18, fontFamily: ConstFont.bold),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    EdgeInsets.only(left: deviceWidth * 0.02),
                                child: TextFormField(
                                  cursorColor: ConstColour.buttonColor,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  controller:
                                      bloodSugarController.commentController,
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: ConstColour.textColor,
                                      fontFamily: ConstFont.regular),
                                  autocorrect: true,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Enter your comments",
                                    hintStyle: TextStyle(
                                        fontSize: 20,
                                        color: ConstColour.greyTextColor,
                                        fontFamily: ConstFont.regular),
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
              Obx(() => Padding(
                padding: EdgeInsets.only(
                    top: deviceHeight * 0.01,
                    left: deviceWidth * 0.02,
                    right: deviceWidth * 0.02),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        minimumSize: Size(deviceWidth * 0.9, deviceHeight * 0.06),
                        backgroundColor: ConstColour.buttonColor
                    ),
                    onPressed: () async {
                      try{
                        if (bloodSugarController.bloodGlucoseController.text.isEmpty) {
                          Utils().snackBar('Blood Glucose', "Please Enter Blood Glucose Level");
                          return;
                        }
                        // else {
                        // double bloodGlucose = unitController.getGlucoseLevelPreference()
                        //     ? double.parse(bloodSugarController.bloodGlucoseController.text) * 18
                        //     : double.parse(bloodSugarController.bloodGlucoseController.text);
                          double bloodGlucose = 0;
                          if(unitController.getGlucoseLevelPreference()) { // mg/dl
                            bloodGlucose = double.parse(bloodSugarController.bloodGlucoseController.text) * 18;
                          } else {
                            bloodGlucose = double.parse(bloodSugarController.bloodGlucoseController.text);
                          }
                          var date =  DateFormat('dd/MM/yyyy').format(dateTimeController.selectedDate.value);
                          var time = dateTimeController.formattedTime.value.isEmpty
                              ? formatter.format(current_Datetime)
                              : dateTimeController.formattedTime.value;

                          // bloodSugarController.isLoading.value = true;
                          await bloodSugarController.BloodSugarList(
                              date.toString(),
                              bloodGlucose.toStringAsFixed(2),
                              bloodSugarController.commentController.text,
                              time.toString()
                          );
                        }
                      // }
                      catch (error) {
                        debugPrint("Error: $error");
                      }
                      // finally {
                      //   bloodSugarController.isLoading.value = false;
                      // }
                      // Get.to(() => BloodSugar(id: '',));
                      // Get.back();
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
                ),
                // NextButton(
                //   onPressed: () {
                //     // bloodSugarController.isLoading.value = true;
                //     if (bloodSugarController.bloodGlucoseController.text.isEmpty) {
                //       Utils().snackBar('Blood Glucose', "Please Enter Blood Glucose Level");
                //     } else {
                //       double bloodGlucose = 0;
                //       if(unitController.getGlucoseLevelPreference()) { // mg/dl
                //         bloodGlucose = double.parse(bloodSugarController.bloodGlucoseController.text) * 18;
                //       } else {
                //         bloodGlucose = double.parse(bloodSugarController.bloodGlucoseController.text);
                //       }
                //       var date =  DateFormat('dd/MM/yyyy').format(dateTimeController.selectedDate.value);
                //       var time = dateTimeController.formattedTime.value.isEmpty
                //           ? formatter.format(current_Datetime)
                //           : dateTimeController.formattedTime.value;
                //       bloodSugarController.BloodSugarList(
                //           date.toString(),
                //           bloodGlucose.toStringAsFixed(2),
                //           bloodSugarController.commentController.text,
                //           time.toString()
                //       );
                //       // bloodSugarController.isLoading.value = false;
                //     }
                //     // Get.to(() => BloodSugar(id: '',));
                //     // Get.back();
                //   },
                //   btnName: bloodSugarController.isLoading.value
                //       ? Center(
                //     child: CircularProgressIndicator(
                //       color: ConstColour.buttonColor,
                //     ),
                //   )
                //   // "Loading..."
                //       : "Save",
                // ),
              ))
            ],
          ),
        ),
      ),
    );
  }

  void showBottomSheetButton() {
    showModalBottomSheet(
      elevation: 0.0,
      enableDrag: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      )),
      context: context,
      builder: (context) {
        var deviceHeight = MediaQuery.of(context).size.height;
        var deviceWidth = MediaQuery.of(context).size.width;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: deviceHeight * 0.03),
              child: Center(
                child: Text(
                  "MEASURED TYPE",
                  style: TextStyle(fontSize: 23, fontFamily: ConstFont.bold),
                ),
              ),
            ),
            ListView.builder(
              // physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              controller: ScrollController(),
              itemCount: bloodSugarController.measuredTypes.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    bloodSugarController.measuredType.value = bloodSugarController.measuredTypes[index].name;
                    bloodSugarController.measuredId.value = bloodSugarController.measuredTypes[index].id;
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: deviceWidth * 0.02,
                        vertical: deviceHeight * 0.01
                    ),
                    child: Text(
                      bloodSugarController.measuredTypes[index].name,
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: ConstFont.regular,
                          color: ConstColour.textColor),
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Text(
                    //       bloodSugarController.measuredTypes[index].name,
                    //       style: TextStyle(
                    //           fontSize: 20,
                    //           fontFamily: ConstFont.regular,
                    //           color: ConstColour.textColor),
                    //     ),
                    //     Radio(
                    //       value: bloodSugarController.measuredId.value = bloodSugarController.measuredTypes[index].id,
                    //       groupValue: bloodSugarController.selectedMesuredListType.value,
                    //       onChanged: bloodSugarController.setSelectedListType,
                    //       activeColor: ConstColour.buttonColor,
                    //     ),
                    //   ],
                    // ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
