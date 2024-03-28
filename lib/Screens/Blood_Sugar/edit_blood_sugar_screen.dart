import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:health_care_dairy/Controller/unit_controller.dart';
import 'package:intl/intl.dart';

import '../../Common/bottom_button.dart';
import '../../ConstFile/constColors.dart';
import '../../ConstFile/constFonts.dart';
import '../../Controller/blood_sugar_controller.dart';
import '../../Controller/date_time_controller.dart';

class UpdateBloodSugarScreen extends StatefulWidget {
  final String catId;
  const UpdateBloodSugarScreen({super.key, required this.catId});

  @override
  State<UpdateBloodSugarScreen> createState() => _UpdateBloodSugarScreenState();
}

class _UpdateBloodSugarScreenState extends State<UpdateBloodSugarScreen> {
  UnitController unitController = Get.put(UnitController());
  BloodSugarController bloodSugarController = Get.put(BloodSugarController());
  DateTimeController dateTimeController = Get.put(DateTimeController());
  DateTime current_Datetime = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, DateTime.now().hour, DateTime.now().minute);
  DateFormat formatter = DateFormat('h:mm a');


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      bloodSugarController.measuredTypeList();
      dateTimeController.selectedDate.toString();
      dateTimeController.selectedTime.toString();
      bloodSugarController.getUpdateBloodSugarList(widget.catId);
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
            "Update Blood Sugar",
            style: TextStyle(
                color: ConstColour.textColor,
                fontFamily: ConstFont.regular,
                fontWeight: FontWeight.w800,
                overflow: TextOverflow.ellipsis
            ),
          ),
          leading: IconButton(
            onPressed: () {
              // Get.to(() => BloodSugar());
              Get.back();
              // bloodSugarController.getCategoryList();
            },
            icon: Icon(Icons.arrow_back),
            color: ConstColour.textColor,
          ),
        ),
        backgroundColor: ConstColour.bgColor,
        body: Obx(() => bloodSugarController.updateBloodSugarList.isEmpty
            ? Center(
            child: CircularProgressIndicator(
              color: ConstColour.buttonColor,
            ))
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
                                Text(DateFormat('dd/MM/yyyy').format(dateTimeController.selectedDate.value),
                                  /*Text(bloodSugarController.updatebloodSugarList.isEmpty
                                    ? (DateFormat('dd/MM/yyyy').format(dateTimeController.selectedDate.value))
                                  : (bloodSugarController.updatebloodSugarList[0].dateTime.toString()),*/
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
                                Text(dateTimeController.formattedTime.value.isEmpty
                                ? formatter.format(current_Datetime)
                              : dateTimeController.formattedTime.value,
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
                          vertical: deviceHeight * 0.004
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Blood glucose',
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
                                    controller: bloodSugarController.bloodGlucoseController,
                                    cursorColor: ConstColour.buttonColor,
                                 //   textAlign: TextAlign.end,
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: ConstColour.textColor,
                                        fontFamily: ConstFont.regular
                                    ),
                                    autocorrect: true,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*')),
                                      LengthLimitingTextInputFormatter(7)
                                    ],
                                    textAlign: TextAlign.right,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      // label: Align(
                                      //   alignment: Alignment.topRight,
                                      //     child: Text(bloodSugarController.updatebloodSugarList[0].bloodGlucose.toString(),)),
                                     //  labelText: bloodSugarController.bloodGlucoseController.value.text.isEmpty ? "0" : bloodSugarController.bloodGlucoseController.text.toString(),
                                      border: InputBorder.none,
                                      hintText: bloodSugarController.bloodGlucoseController.value.text.isEmpty
                                          ? "0"
                                          :  bloodSugarController.bloodGlucoseController.value.text.toString(),
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
                                    unitController.getGlucoseLevelPreference() ? 'mmol/L' : 'mg/dL',
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
                    InkWell(
                      onTap: () => showBottomSheetButton(),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: deviceWidth * 0.03,
                            vertical: deviceHeight * 0.006
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              bloodSugarController.measuredType.isEmpty
                                  ? "Before Breakfast"
                                  : bloodSugarController.measuredType.value.toString(),
                              style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: ConstFont.bold
                              ),
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
                          vertical: deviceHeight * 0.004
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
                                controller: bloodSugarController.commentController,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: ConstColour.textColor,
                                    fontFamily: ConstFont.regular
                                ),
                                autocorrect: true,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                //  labelText: bloodSugarController.updatebloodSugarList[0].comments,
                                  border: InputBorder.none,
                                  hintText: bloodSugarController.commentController.text.isEmpty
                                      ? "Enter your comments"
                                      : bloodSugarController.commentController.text.toString(),
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
                      // bloodSugarController.isLoading.value = true;
                      var date =  DateFormat('dd/MM/yyyy').format(dateTimeController.selectedDate.value);
                      var time = dateTimeController.formattedTime.value.isEmpty
                          ? formatter.format(current_Datetime)
                          : dateTimeController.formattedTime.value;
                      await bloodSugarController.UpdateList(
                          bloodSugarController.sugarId.value,
                          date.toString(),
                          bloodSugarController.bloodGlucoseController.text,
                          bloodSugarController.commentController.text,
                          time.toString()
                      );
                    } catch (error) {
                      debugPrint(" Error: $error");
                    }
                    // finally {
                    //   bloodSugarController.isLoading.value = false;
                    // }
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
              //     bloodSugarController.UpdateList(
              //         bloodSugarController.sugarId.value,
              //         date.toString(),
              //         bloodSugarController.bloodGlucoseController.text,
              //         bloodSugarController.commentController.text,
              //         time.toString()
              //     );
              //     // bloodSugarController.BloodSugarList(
              //     //     date.toString(),
              //     //     bloodSugarController.bloodGlucoseController.text,
              //     //     bloodSugarController.measuredType.value,
              //     //     time.toString()
              //     // );
              //     //  Get.back();
              //   },
              //   btnName: "Save",
              // ),
            )
          ],
        ),
        ),
      ),
    );
  }

  void showBottomSheetButton() {
    showModalBottomSheet(
      elevation: 0,
      enableDrag: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          )
      ),
      context: context,
      builder: (context) {
        var deviceHeight = MediaQuery.of(context).size.height;
        var deviceWidth = MediaQuery.of(context).size.width;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: deviceHeight * 0.03),
              child: Center(
                child: Text(
                  "MEASURED TYPE",
                  style: TextStyle(
                      fontSize: 23,
                      fontFamily: ConstFont.bold
                  ),
                ),
              ),
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              controller: ScrollController(),
              itemCount: bloodSugarController.measuredTypes.length,
              itemBuilder: (context, index) {
                final bool isSelected = bloodSugarController.measuredType.value == bloodSugarController.measuredTypes[index].name;
                return GestureDetector(
                  onTap: () {
                    bloodSugarController.measuredType.value = bloodSugarController.measuredTypes[index].name;
                    bloodSugarController.measuredId.value = bloodSugarController.measuredTypes[index].id;
                    Navigator.pop(context);
                  },
                  child: Container(
                    color: isSelected
                        ? ConstColour.buttonColor.withOpacity(0.5)
                        : Colors.transparent,
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
                            color: ConstColour.textColor
                        ),
                      ),
                    ),
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
