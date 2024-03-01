import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_care_dairy/Controller/date_time_controller.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../ConstFile/constApi.dart';
import '../ConstFile/constPreferences.dart';
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

  Future<void> BloodSugarList(String date, String glucose, String comment, String time) async {
    int? userId = await ConstPreferences().getUserId('UserId');
    debugPrint("User_Id  $userId");

    int? categoryId =int.tryParse(catId.value);
    debugPrint("Category_Id " + catId.value);

    // var date =  DateFormat('dd/MM/yyyy').format(dateTimeController.selectedDate.value);
    // var time =  DateFormat('h:mm a').format(DateTime(dateTimeController.selectedTime.value.hour,dateTimeController.selectedTime.value.minute,));


    var body = jsonEncode({
      "Id" : 0,
      "UserId" : userId,
      "Cat_Id" : categoryId,
      "DateTime" : date.toString(),
      "BloodGlucose" : glucose.toString(),
      "MeasuredTypeId" : measuredId.value.toString(),
      "SystolicPressure" : 0,
      "DiastolicPressure" : 0,
      "PulseRate" : 0,
      "Hand" : "",
      "BodyTemperature" : "",
      "BloodOxygenSaturation" : 0,
      "MeasurementTypeId" : 0,
      "AverageSugarConcentration" : "",
      "Weight" : "",
      "MedicationName" : "",
      "SelectDataTypeId" : 0,
      "Dosage" : 0,
      "TimesAndDay" : 0,
      "Color" : "",
      "Comments" : comment.toString(),
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

    int? categoryId =int.tryParse(catId.value);
    var body = jsonEncode({
      "UserId" : userId,
      "CategoryId" : categoryId
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

  Future<void> UpdateList(int id, String date, String glucose, String comment, String time) async {
    int? userId = await ConstPreferences().getUserId('UserId');
    debugPrint("User_Id  $userId");

    int? categoryId =int.tryParse(catId.value);
    debugPrint("Category_Id " + catId.value);

    // var date =  DateFormat('dd/MM/yyyy').format(dateTimeController.selectedDate.value);
    var body = jsonEncode({
      "Id" : id,
      "UserId" : userId,
      "Cat_Id" : categoryId,
      "DateTime" : date.toString(),
      "BloodGlucose" : glucose.toString(),
      "MeasuredTypeId" : measuredId.value.toString(),
      "SystolicPressure" : 0,
      "DiastolicPressure" : 0,
      "PulseRate" :0,
      "Hand" : true,
      "BodyTemperature" : "0",
      "BloodOxygenSaturation" : 0,
      "MeasurementTypeId" : 0,
      "AverageSugarConcentration" : "",
      "Weight" : "",
      "MedicationName" : "",
      "SelectDataTypeId" : 0,
      "Dosage" : 0,
      "TimesAndDay" : 0,
      "Color" : "",
      "Comments" : comment.toString(),
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
    final response = await http.get(Uri.parse('${ConstApi.getCategoryDetail}$id'));
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
        var dateTime = dateFormate.parse(updatebloodSugarList[0].dateTime.toString());
        dateTimeController.selectedDate.value = dateTime;
        dateTimeController.formattedTime.value = updatebloodSugarList[0].time.toString();
        bloodGlucoseController.text = updatebloodSugarList[0].bloodGlucose.toString();
        commentController.text = updatebloodSugarList[0].comments.toString();
        measuredType.value = updatebloodSugarList[0].measuredTypeName.toString();

        for(int i=0; i<measuredTypes.length; i++) {
          if(measuredTypes[i].name.toString() == updatebloodSugarList[0].measuredTypeName.toString()) {
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

}