import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_care_dairy/Controller/blood_sugar_controller.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import '../ConstFile/constApi.dart';
import '../ConstFile/constPreferences.dart';
import '../model/get_category_model.dart';
import '../model/insert_category_detail_model.dart';
import 'date_time_controller.dart';

class BodyTemperatureController extends GetxController {

  BloodSugarController bloodSugarController = Get.put(BloodSugarController());

  TextEditingController temperatureController = TextEditingController();
  TextEditingController temperatureCommentController = TextEditingController();


  int? messageCode;
  DateTimeController dateTimeController = Get.put(DateTimeController());
  RxString catId = ''.obs;
  RxInt temperatureId = 0.obs;
  void updateCatId(String id) {
    catId.value = id.toString();
    debugPrint("hgkjgjhghjghj  $id");
  }

  RxList<CategoryList> updateBodyTemperatureList = <CategoryList>[].obs;


  Future<void> BodyTemperatureList(String date, String temperature, String comment, String time) async {
    int? userId = await ConstPreferences().getUserId('UserId');
    debugPrint("User_Id  $userId");

    int? categoryId =int.tryParse(catId.value);
    debugPrint("Category_Id " + catId.value);

    // var date =  DateFormat('dd/MM/yyyy').format(dateTimeController.selectedDate.value);
    var body = jsonEncode({
      "Id" : 0,
      "UserId" : userId,
      "Cat_Id" : categoryId,
      "DateTime" : date.toString(),
      "BloodGlucose" : 0.0,
      "MeasuredTypeId" : 0,
      "SystolicPressure" : 0,
      "DiastolicPressure" : 0,
      "PulseRate" : 0,
      "Hand" : "",
      "BodyTemperature" : temperature.toString(),
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
        debugPrint("BloodTemperatureList Successfully");
        bloodSugarController.getCategoryList();
        Get.back();
      } else {
        debugPrint("BloodTemperatureList Error");
      }
    } else {}
  }

  Future<void> UpdatebodyTemperatureList(int id, String date, String temperature, String comment, String time) async {
    int? userId = await ConstPreferences().getUserId('UserId');
    debugPrint("User_Id  $userId");

    int? categoryId =int.tryParse(catId.value);
    debugPrint("Category_Id " + catId.value);

    var body = jsonEncode({
      "Id" : id,
      "UserId" : userId,
      "Cat_Id" : categoryId,
      "DateTime" : date.toString(),
      "BloodGlucose" : 0.0,
      "MeasuredTypeId" : 0,
      "SystolicPressure" : 0,
      "DiastolicPressure" : 0,
      "PulseRate" : 0,
      "Hand" : "",
      "BodyTemperature" : temperature.toString(),
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
        bloodSugarController.getCategoryList();
        Get.back();
      } else {
        debugPrint("Update Error");
      }
    } else {}
  }

  Future<void> getUpdateBodyTemperatureList(String id) async {
    final response = await http.get(Uri.parse('${ConstApi.getCategoryDetail}$id'));
    var data = response.body;
    debugPrint(data.toString());

    if (response.statusCode == 200) {
      final responseData = categoryFromJson(response.body);
      debugPrint(responseData.toString());
      messageCode = responseData.messageCode;
      debugPrint(messageCode.toString());

      if (messageCode == 1) {
        updateBodyTemperatureList.clear();
        updateBodyTemperatureList.addAll(responseData.data);
        var dateFormate = DateFormat('dd/MM/yyyy');
        var dateTime = dateFormate.parse(updateBodyTemperatureList[0].dateTime.toString());
        dateTimeController.selectedDate.value = dateTime;
        dateTimeController.formattedTime.value = updateBodyTemperatureList[0].time.toString();
        temperatureController.text = updateBodyTemperatureList[0].bodyTemperature.toString();
        temperatureCommentController.text = updateBodyTemperatureList[0].comments.toString();
        debugPrint("EditCategoryDetail Successfully");
      } else {
        debugPrint("EditCategoryDetail Error");
      }
    } else {}
  }

}