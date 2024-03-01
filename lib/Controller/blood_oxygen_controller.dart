import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '../ConstFile/constApi.dart';
import '../ConstFile/constPreferences.dart';
import '../model/get_category_model.dart';
import '../model/insert_category_detail_model.dart';
import 'blood_sugar_controller.dart';
import 'date_time_controller.dart';

class BloodOxygenController extends GetxController {

  BloodSugarController bloodSugarController = Get.put(BloodSugarController());
  TextEditingController oxygenController = TextEditingController();
  TextEditingController oxygenCommentController = TextEditingController();

  RxInt oxygenId = 0.obs;
  RxList<CategoryList> updateBloodOxygenList = <CategoryList>[].obs;

  int? messageCode;
  DateTimeController dateTimeController = Get.put(DateTimeController());
  RxString catId = ''.obs;

  void updateCatId(String id) {
    catId.value = id.toString();
    debugPrint("hgkjgjhghjghj  $id");
  }

  Future<void> BloodOxygenList(String date, String oxygen, String comment, String time) async {
    int? userId = await ConstPreferences().getUserId('UserId');
    debugPrint("User_Id  $userId");

    // int? categoryId = await ConstPreferences().getCategoryId('CategoryId');
    // debugPrint("Category_Id  $categoryId");

    int? categoryId =int.tryParse(catId.value);
    debugPrint("Category_Id " + catId.value);

    // var date =  DateFormat('dd/MM/yyyy').format(dateTimeController.selectedDate.value);
    var body = jsonEncode({
      "Id" : 0,
      "UserId" : userId,
      "Cat_Id" : categoryId,
      "DateTime" : date.toString(),
      "BloodGlucose" : "",
      "MeasuredTypeId" : 0,
      "SystolicPressure" : 0,
      "DiastolicPressure" : 0,
      "PulseRate" : 0,
      "Hand" : "",
      "BodyTemperature" : "",
      "BloodOxygenSaturation" : oxygen.toString(),
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
    var response = await http.post(
      Uri.parse(ConstApi.categoryDetail),
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
        debugPrint("BloodPressureList Successfully");
        bloodSugarController.getCategoryList();
        Get.back();
      } else {
        debugPrint("BloodPressureList Error");
      }
    } else {}
  }

  Future<void> UpdateOxygenList(int id, String date, String oxygen, String comment, String time) async {
    int? userId = await ConstPreferences().getUserId('UserId');
    debugPrint("User_Id  $userId");

    // int? categoryId = await ConstPreferences().getCategoryId('CategoryId');
    // debugPrint("Category_Id  $categoryId");

    int? categoryId =int.tryParse(catId.value);
    debugPrint("Category_Id " + catId.value);

    // var date =  DateFormat('dd/MM/yyyy').format(dateTimeController.selectedDate.value);
    var body = jsonEncode({
      "Id" : id,
      "UserId" : userId,
      "Cat_Id" : categoryId,
      "DateTime" : date.toString(),
      "BloodGlucose" : "",
      "MeasuredTypeId" : 0,
      "SystolicPressure" : 0,
      "DiastolicPressure" : 0,
      "PulseRate" : 0,
      "Hand" : "",
      "BodyTemperature" : "",
      "BloodOxygenSaturation" : oxygen.toString(),
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
    var response = await http.post(
      Uri.parse(ConstApi.categoryDetail),
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
        bloodSugarController.getCategoryList();
        Get.back();
      } else {
        debugPrint("Update Error");
      }
    } else {}
  }

  Future<void> getUpdateBloodOxygenList(String id) async {
    final response = await http.get(Uri.parse('${ConstApi.getCategoryDetail}$id'));
    var data = response.body;
    debugPrint(data.toString());

    if (response.statusCode == 200) {
      final responseData = categoryFromJson(response.body);
      debugPrint(responseData.toString());
      messageCode = responseData.messageCode;
      debugPrint(messageCode.toString());

      if (messageCode == 1) {
        updateBloodOxygenList.clear();
        updateBloodOxygenList.addAll(responseData.data);
        var dateFormate = DateFormat('dd/MM/yyyy');
        var dateTime = dateFormate.parse(updateBloodOxygenList[0].dateTime.toString());
        dateTimeController.selectedDate.value = dateTime;
        dateTimeController.formattedTime.value = updateBloodOxygenList[0].time.toString();
        oxygenController.text = updateBloodOxygenList[0].bloodOxygenSaturation.toString();
        oxygenCommentController.text = updateBloodOxygenList[0].comments.toString();
        debugPrint("EditCategoryDetail Successfully");
      } else {
        debugPrint("EditCategoryDetail Error");
      }
    } else {}
  }
}