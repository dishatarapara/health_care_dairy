import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:health_care_dairy/Controller/hemoglobin_controller.dart';
import 'package:health_care_dairy/Controller/unit_controller.dart';
import 'package:intl/intl.dart';

import '../../Common/bottom_button.dart';
import '../../ConstFile/constColors.dart';
import '../../ConstFile/constFonts.dart';
import '../../Controller/blood_sugar_controller.dart';
import '../../Controller/date_time_controller.dart';

class UpdateHemoglobinScreen extends StatefulWidget {
  final String catId;
  const UpdateHemoglobinScreen({super.key, required this.catId});

  @override
  State<UpdateHemoglobinScreen> createState() => _UpdateHemoglobinScreenState();
}

class _UpdateHemoglobinScreenState extends State<UpdateHemoglobinScreen> {
  BloodSugarController bloodSugarController = Get.put(BloodSugarController());
  UnitController unitController = Get.put(UnitController());
  A1CController a1cController = Get.put(A1CController());
  DateTimeController dateTimeController = Get.put(DateTimeController());
  DateTime current_Datetime = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, DateTime.now().hour, DateTime.now().minute);
  DateFormat formatter = DateFormat('h:mm a');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    a1cController.selectedMeasurementType = null;
    a1cController.measurementTypeList();
    dateTimeController.selectedDate.toString();
    dateTimeController.selectedTime.toString();
    a1cController.getUpdateHemoglobinList(widget.catId);
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
            "Update A1C",
            style: TextStyle(
                color: ConstColour.textColor,
                fontFamily: ConstFont.regular,
                fontWeight: FontWeight.w800,
                overflow: TextOverflow.ellipsis
            ),
          ),
          leading: IconButton(
            onPressed: () {
              // Get.to(() => Hemoglobin());
              Get.back();
            },
            icon: Icon(Icons.arrow_back),
            color: ConstColour.textColor,
          ),
        ),
        backgroundColor: ConstColour.bgColor,
        body: Obx(() => a1cController.updateHemoglobinList.isEmpty
            ? Center(child: CircularProgressIndicator(
          color: ConstColour.buttonColor,))
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
                      onTap: () {},
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: deviceWidth * 0.03,
                            vertical: deviceHeight * 0.006
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Measurement Type',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: ConstFont.bold
                              ),
                            ),
                            Container(
                              width: deviceWidth * 0.26,
                              child:DropdownButton(
                                underline: SizedBox(),
                                isExpanded: true,
                                alignment: Alignment.topRight,
                                value: a1cController.selectedMeasurementType,
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.grey,
                                  size: 35,
                                ),
                                items: [
                                  DropdownMenuItem(
                                    value: null,
                                    child: Text(
                                      'Select type',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: ConstFont.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  // Adding other items
                                  ...a1cController.measurementTypes.map((item) {
                                    return DropdownMenuItem(
                                      value: item,
                                      child: Text(
                                        item.name.toString(),
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: ConstFont.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ],
                                onChanged: (newValue) {
                                  setState(() {
                                    // Ensure that newValue is not null
                                    if (newValue != null) {
                                      a1cController.selectedMeasurementType = newValue;
                                    } else {
                                      // Handle the case where newValue is null
                                      // For example, you could set it to the first item in the list
                                      a1cController.selectedMeasurementType = a1cController.measurementTypes.first;
                                    }
                                  });
                                },
                              ),
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
                            'Average Sugar Concentration',
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
                                    controller: a1cController.averageSugarController,
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
                                      LengthLimitingTextInputFormatter(4)
                                    ],
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: a1cController.selectedMeasurementType?.name == null
                                          ? "eAG"
                                          : a1cController.selectedMeasurementType?.name.toString(),
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
                                    a1cController.selectedMeasurementType?.name == "A1C" ?  "%" : unitController.getGlucoseLevelPreference() ? 'mmol/L' : 'mg/dL',
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
                                controller: a1cController.a1cCommentController,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: ConstColour.textColor,
                                    fontFamily: ConstFont.regular
                                ),
                                autocorrect: true,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: a1cController.a1cCommentController.text.isEmpty
                                      ? "Enter your comments"
                                      : a1cController.a1cCommentController.text.toString(),
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
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      minimumSize: Size(deviceWidth * 0.9, deviceHeight * 0.06),
                      backgroundColor: ConstColour.buttonColor
                  ),
                  onPressed: () async {
                    try {
                      var date = DateFormat('dd/MM/yyyy').format(
                          dateTimeController.selectedDate.value);
                      var time = dateTimeController.formattedTime.value.isEmpty
                          ? formatter.format(current_Datetime)
                          : dateTimeController.formattedTime.value;
                      a1cController.UpdatehemoglobinList(
                          a1cController.hemoglobinId.value,
                          date.toString(),
                          a1cController.averageSugarController.text,
                          a1cController.a1cCommentController.text,
                          time.toString());
                    } catch(e) {
                      debugPrint("Error: $e");
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
              //     var date =  DateFormat('dd/MM/yyyy').format(dateTimeController.selectedDate.value);
              //     var time = dateTimeController.formattedTime.value.isEmpty
              //         ? formatter.format(current_Datetime)
              //         : dateTimeController.formattedTime.value;
              //     a1cController.UpdatehemoglobinList(
              //         a1cController.hemoglobinId.value,
              //         date.toString(),
              //         a1cController.averageSugarController.text,
              //         a1cController.a1cCommentController.text,
              //         time.toString());
              //       // bloodSugarController.BloodSugarList();
              //     // Get.to(() => Hemoglobin());
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
