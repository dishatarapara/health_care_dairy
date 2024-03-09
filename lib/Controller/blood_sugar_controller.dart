import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_care_dairy/Controller/date_time_controller.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../Common/bottom_button.dart';
import '../ConstFile/constApi.dart';
import '../ConstFile/constColors.dart';
import '../ConstFile/constFonts.dart';
import '../ConstFile/constPreferences.dart';
import '../Screens/Blood_Sugar/blood_sugar_add_screen.dart';
import '../model/insert_category_detail_model.dart';
import '../model/get_category_model.dart';
import '../model/measured_type_model.dart';

class BloodSugarController extends GetxController {
  TextEditingController bloodGlucoseController = TextEditingController();
  TextEditingController commentController = TextEditingController();

  int? messageCode;
  RxString measuredType = ''.obs;
  RxInt measuredId = 0.obs;
  RxBool isLoading = true.obs;


  RxList<CategoryList> bloodSugarLists = <CategoryList>[].obs;
  RxList<CategoryList> updatebloodSugarList = <CategoryList>[].obs;
  RxList<MeasuredTypesList> measuredTypes = <MeasuredTypesList>[].obs;

  DateTimeController dateTimeController = Get.put(DateTimeController());

  RxString catId = ''.obs;

  RxInt sugarId = 0.obs;


  void updateCatId(String id) {
    catId.value = id.toString();
    debugPrint("Cat_Id  $id");
  }

  RxInt selectedType = 0.obs;
  RxBool weekNameType = false.obs;

  setSelectedType(val) {
    selectedType.value = val;
    if (selectedType.value == 1) {
      weekNameType.value = false;
    } else if (selectedType.value == 2) {
      weekNameType.value = false;
    } else if (selectedType.value == 3) {
      weekNameType.value = false;
    } else if (selectedType.value == 4) {
      weekNameType.value = false;
    } else {
      weekNameType.value = true;
    }
    debugPrint(selectedType.value.toString());
  }








  // List<String> measuredTypes = <String> [
  //   "Before Breakfast",
  //   "After Breakfast",
  //   "Before Lunch",
  //   "After Lunch",
  //   "Before Dinner",
  //   "After Dinner",
  //   "Before Sleep",
  //   "After Sleep",
  //   "Fasting",
  //   "Other",
  // ];

  Future<void> BloodSugarList(String date, String glucose, String comment,
      String time) async {
    int? userId = await ConstPreferences().getUserId('UserId');
    debugPrint("User_Id  $userId");

    int? categoryId = int.tryParse(catId.value);
    debugPrint("Category_Id " + catId.value);

    // var date =  DateFormat('dd/MM/yyyy').format(dateTimeController.selectedDate.value);
    // var time =  DateFormat('h:mm a').format(DateTime(dateTimeController.selectedTime.value.hour,dateTimeController.selectedTime.value.minute,));


    var body = jsonEncode({
      "Id": 0,
      "UserId": userId,
      "Cat_Id": categoryId,
      "DateTime": date.toString(),
      "BloodGlucose": glucose.toString(),
      "MeasuredTypeId": measuredId.value.toString(),
      "SystolicPressure": 0,
      "DiastolicPressure": 0,
      "PulseRate": 0,
      "Hand": "",
      "BodyTemperature": "",
      "BloodOxygenSaturation": 0,
      "MeasurementTypeId": 0,
      "AverageSugarConcentration": "",
      "Weight": "",
      "MedicationName": "",
      "SelectDataTypeId": 0,
      "Dosage": 0,
      "TimesAndDay": 0,
      "Color": "",
      "Comments": comment.toString(),
      "Unit": null,
      "Time": time.toString()
    });

    var headers = {
      'Content-Type': 'application/json',
    };
    var response = await http.post(Uri.parse(ConstApi.categoryDetail),
      headers: headers,
      body: body,
    );

    var data = response.body;
    debugPrint(data.toString());

    if (response.statusCode == 200) {
      final responseData = insertCategoryDetailFromJson(response.body);
      debugPrint(responseData.toString());
      messageCode = responseData.messageCode;
      debugPrint(messageCode.toString());

      if (messageCode == 1) {
        debugPrint("Add Successfully");
        getCategoryList();
        Get.back();
      } else {
        debugPrint("Add Error");
      }
    } else {}
  }

  Future<void> getCategoryList() async {
    int? userId = await ConstPreferences().getUserId('UserId');
    debugPrint("User_Id  $userId");

    int? categoryId = int.tryParse(catId.value);
    var body = jsonEncode({
      "UserId": userId,
      "CategoryId": categoryId
    });
    var headers = {
      'Content-Type': 'application/json',
    };
    final response = await http.post(Uri.parse(ConstApi.getCategory),
        headers: headers,
        body: body);
    var data = response.body;
    debugPrint(data.toString());

    if (response.statusCode == 200) {
      final responseData = categoryFromJson(response.body);
      debugPrint(responseData.toString());
      messageCode = responseData.messageCode;
      debugPrint(messageCode.toString());

      if (messageCode == 1) {
        bloodSugarLists.clear();
        bloodSugarLists.addAll(responseData.data);
        debugPrint("categoryIdDetails Successfully");
      } else {
        debugPrint("categoryIdDetails Error");
      }
    } else {}
  }

  Future<void> measuredTypeList() async {
    final response = await http.post(Uri.parse(ConstApi.measuredTypeDetail),);
    var data = response.body;
    debugPrint(data.toString());

    if (response.statusCode == 200) {
      final responseData = measuredTypeFromJson(response.body);
      debugPrint(responseData.toString());
      messageCode = responseData.messageCode;
      debugPrint(messageCode.toString());

      if (messageCode == 1) {
        measuredTypes.clear();
        measuredTypes.addAll(responseData.data);
        debugPrint("MeasuredTypes Successfully");
      } else {
        debugPrint("MeasuredTypes Error");
      }
    } else {}
  }

  Future<void> UpdateList(int id, String date, String glucose, String comment,
      String time) async {
    int? userId = await ConstPreferences().getUserId('UserId');
    debugPrint("User_Id  $userId");

    int? categoryId = int.tryParse(catId.value);
    debugPrint("Category_Id " + catId.value);

    // var date =  DateFormat('dd/MM/yyyy').format(dateTimeController.selectedDate.value);
    var body = jsonEncode({
      "Id": id,
      "UserId": userId,
      "Cat_Id": categoryId,
      "DateTime": date.toString(),
      "BloodGlucose": glucose.toString(),
      "MeasuredTypeId": measuredId.value.toString(),
      "SystolicPressure": 0,
      "DiastolicPressure": 0,
      "PulseRate": 0,
      "Hand": true,
      "BodyTemperature": "0",
      "BloodOxygenSaturation": 0,
      "MeasurementTypeId": 0,
      "AverageSugarConcentration": "",
      "Weight": "",
      "MedicationName": "",
      "SelectDataTypeId": 0,
      "Dosage": 0,
      "TimesAndDay": 0,
      "Color": "",
      "Comments": comment.toString(),
      "Unit": null,
      "Time": time.toString()
    });

    var headers = {
      'Content-Type': 'application/json',
    };
    var response = await http.post(Uri.parse(ConstApi.categoryDetail),
      headers: headers,
      body: body,
    );

    var data = response.body;
    debugPrint(data.toString());

    if (response.statusCode == 200) {
      final responseData = insertCategoryDetailFromJson(response.body);
      debugPrint(responseData.toString());
      messageCode = responseData.messageCode;
      debugPrint(messageCode.toString());

      if (messageCode == 1) {
        debugPrint("Update Successfully");
        getCategoryList();
        Get.back();
      } else {
        debugPrint("Update Error");
      }
    } else {}
  }

  // Future<void> getEditBloodSugarList(String id) async {
  //   final response = await http.get(Uri.parse('${ConstApi.getCategoryDetail}$id'));
  //   var data = response.body;
  //   debugPrint(data.toString());
  //
  //   if (response.statusCode == 200) {
  //     final responseData = categoryFromJson(response.body);
  //     debugPrint(responseData.toString());
  //     messageCode = responseData.messageCode;
  //     debugPrint(messageCode.toString());
  //
  //     if (messageCode == 1) {
  //       bloodSugarLists.clear();
  //       bloodSugarLists.addAll(responseData.data);
  //       debugPrint("EditCategoryDetail Successfully");
  //     } else {
  //       debugPrint("EditCategoryDetail Error");
  //     }
  //   } else {}
  // }

  Future<void> getUpdateBloodSugarList(String id) async {
    final response = await http.get(
        Uri.parse('${ConstApi.getCategoryDetail}$id'));
    var data = response.body;
    debugPrint(data.toString());

    if (response.statusCode == 200) {
      final responseData = categoryFromJson(response.body);
      debugPrint(responseData.toString());
      messageCode = responseData.messageCode;
      debugPrint(messageCode.toString());

      if (messageCode == 1) {
        updatebloodSugarList.clear();
        updatebloodSugarList.addAll(responseData.data);
        var dateFormate = DateFormat('dd/MM/yyyy');
        var dateTime = dateFormate.parse(
            updatebloodSugarList[0].dateTime.toString());
        dateTimeController.selectedDate.value = dateTime;
        dateTimeController.formattedTime.value =
            updatebloodSugarList[0].time.toString();
        bloodGlucoseController.text =
            updatebloodSugarList[0].bloodGlucose.toString();
        commentController.text = updatebloodSugarList[0].comments.toString();
        measuredType.value =
            updatebloodSugarList[0].measuredTypeName.toString();

        for (int i = 0; i < measuredTypes.length; i++) {
          if (measuredTypes[i].name.toString() ==
              updatebloodSugarList[0].measuredTypeName.toString()) {
            measuredId.value = measuredTypes[i].id.toInt();
          }
        }
        // measuredType.value = updatebloodSugarList[0].measuredTypeName.toString();
        debugPrint("EditCategoryDetail Successfully");
      } else {
        debugPrint("EditCategoryDetail Error");
      }
    } else {}
  }

  void showDialogBox(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        var deviceHeight = MediaQuery
            .of(context)
            .size
            .height;
        var deviceWidth = MediaQuery
            .of(context)
            .size
            .width;
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              insetAnimationCurve: Curves.linear,
              backgroundColor: ConstColour.appColor,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: ConstColour.appColor,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: ConstColour.appColor,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: deviceWidth * 0.03
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(top: deviceHeight * 0.01),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(Icons.close)),
                          )
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: deviceHeight * 0.01),
                        child: Image.asset(
                          'assets/Icons/filter.png',
                          fit: BoxFit.cover,
                          height: deviceHeight * 0.08,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: deviceHeight * 0.01),
                        child: Text(
                          "Filter",
                          style: TextStyle(
                              fontSize: 23,
                              color: ConstColour.textColor,
                              fontFamily: ConstFont.bold
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: deviceHeight * 0.01,
                            left: deviceWidth * 0.01
                        ),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Type",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                fontFamily: ConstFont.regular
                            ),
                          ),
                        ),
                      ),
                      Obx(() =>
                          Padding(
                            padding: EdgeInsets.only(top: deviceHeight * 0.02),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: deviceHeight * 0.05,
                                  width: deviceWidth * 0.35,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 0.3
                                    ),
                                    color: ConstColour.appColor,
                                    // Background color
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Expanded(
                                      child: Row(
                                        children: [
                                          Radio(
                                            value: 1,
                                            groupValue: selectedType.value,
                                            onChanged: setSelectedType,
                                            activeColor: ConstColour
                                                .buttonColor,
                                          ),
                                          Text(
                                            "This Week",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontFamily: ConstFont.regular,
                                                color: selectedType.value == 1
                                                    ? ConstColour.textColor
                                                    : ConstColour.greyTextColor
                                            ),
                                          ),
                                        ],
                                      )
                                  ),
                                ),
                                Container(
                                  height: deviceHeight * 0.05,
                                  width: deviceWidth * 0.35,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 0.3
                                    ),
                                    color: ConstColour.appColor,
                                    // Background color
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Expanded(
                                      child: Row(
                                        children: [
                                          Radio(
                                            value: 2,
                                            groupValue: selectedType.value,
                                            onChanged: setSelectedType,
                                            activeColor: ConstColour
                                                .buttonColor,
                                          ),
                                          Text(
                                            "Last Week",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontFamily: ConstFont.regular,
                                                color: selectedType.value == 2
                                                    ? ConstColour.textColor
                                                    : ConstColour.greyTextColor
                                            ),
                                          ),
                                        ],
                                      )
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ),
                      Obx(() =>
                          Padding(
                            padding: EdgeInsets.only(top: deviceHeight * 0.02),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: deviceHeight * 0.05,
                                  width: deviceWidth * 0.35,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 0.3
                                    ),
                                    color: ConstColour.appColor,
                                    // Background color
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Expanded(
                                      child: Row(
                                        children: [
                                          Radio(
                                            value: 3,
                                            groupValue: selectedType.value,
                                            onChanged: selectedType,
                                            activeColor: ConstColour
                                                .buttonColor,
                                          ),
                                          Text(
                                            "This Month",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontFamily: ConstFont.regular,
                                                color: selectedType.value == 3
                                                    ? ConstColour.textColor
                                                    : ConstColour.greyTextColor
                                            ),
                                          ),
                                        ],
                                      )
                                  ),
                                ),
                                Container(
                                  height: deviceHeight * 0.05,
                                  width: deviceWidth * 0.35,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 0.3
                                    ),
                                    color: ConstColour.appColor,
                                    // Background color
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Expanded(
                                      child: Row(
                                        children: [
                                          Radio(
                                            value: 4,
                                            groupValue: selectedType.value,
                                            onChanged: setSelectedType,
                                            activeColor: ConstColour
                                                .buttonColor,
                                          ),
                                          Text(
                                            "Last Month",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontFamily: ConstFont.regular,
                                                color: selectedType.value == 4
                                                    ? ConstColour.textColor
                                                    : ConstColour.greyTextColor
                                            ),
                                          ),
                                        ],
                                      )
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ),
                      Obx(() =>
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Custom Filter",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: ConstFont.regular,
                                    color: ConstColour.textColor
                                ),
                              ),
                              Radio(
                                value: 5,
                                groupValue: selectedType.value,
                                onChanged: setSelectedType,
                                activeColor: ConstColour.buttonColor,)
                            ],
                          ),
                      ),
                      Obx(() =>
                          Visibility(
                              visible: weekNameType.value,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Container(
                                      height: deviceHeight * 0.05,
                                      width: deviceWidth * 0.35,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 0.3
                                        ),
                                        color: ConstColour.appColor,
                                        // Background color
                                        borderRadius: BorderRadius.circular(
                                            8.0),
                                      ),
                                      child: Expanded(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .spaceEvenly,
                                            children: [
                                              Icon(
                                                Icons.calendar_today,
                                                size: 20,
                                                color: Colors.black,),
                                              Text(
                                                "Calendar",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontFamily: ConstFont
                                                        .regular,
                                                    color: ConstColour.textColor
                                                ),
                                              )
                                            ],
                                          )
                                      ),
                                    ),
                                    Container(
                                      height: deviceHeight * 0.05,
                                      width: deviceWidth * 0.35,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 0.3
                                        ),
                                        color: ConstColour.appColor,
                                        // Background color
                                        borderRadius: BorderRadius.circular(
                                            8.0),
                                      ),
                                      child: Expanded(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .spaceEvenly,
                                            children: [
                                              Icon(
                                                Icons.calendar_today,
                                                size: 20,
                                                color: Colors.black,),
                                              Text(
                                                "Calendar",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontFamily: ConstFont
                                                        .regular,
                                                    color: ConstColour.textColor
                                                ),
                                              )
                                            ],
                                          )
                                      ),
                                    ),
                                  ])
                          )
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: deviceHeight * 0.01,
                        ),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            " Measured Type",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                fontFamily: ConstFont.regular
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(
                            top: deviceHeight * 0.02
                        ),
                        child: Container(
                          height: deviceHeight * 0.05,
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 0.3
                            ),
                            color: ConstColour.appColor, // Background color
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Expanded(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: deviceWidth * 0.02),
                                    child: Text(
                                      "All",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: ConstFont.regular,
                                          color: ConstColour.textColor
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    child: Icon(
                                      Icons.arrow_drop_down,
                                      size: 30,
                                      color: Colors.black,),
                                  ),
                                ]),
                          ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(top: deviceHeight * 0.02),
                        child: NextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          btnName: "Save",
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: deviceHeight * 0.01),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  elevation: 0.0,
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide.none,
                                      borderRadius: BorderRadius.circular(50)),
                                  minimumSize: Size(
                                      deviceWidth * 0.9, deviceHeight * 0.06),
                                  backgroundColor: ConstColour.appColor
                              ),
                              onPressed: () {

                                },
                                // Navigator.pop(context);

                              child: Text(
                                "Clear",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: ConstColour.textColor
                                ),
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                              )
                          )
                      ),
                      SizedBox(
                        height: deviceHeight * 0.01,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

}