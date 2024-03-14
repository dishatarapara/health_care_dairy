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

class BloodPressureController extends GetxController {

  BloodSugarController bloodSugarController = Get.put(BloodSugarController());

  TextEditingController systolicPressureController = TextEditingController();
  TextEditingController diastolicPressureController = TextEditingController();
  TextEditingController pulesRateController = TextEditingController();
  TextEditingController pressureCommentController = TextEditingController();

  int? messageCode;
  RxInt selectedRadio = 0.obs;

  RxList<CategoryList> updateBloodPressureList = <CategoryList>[].obs;

  setSelectedRadio(value) {
    selectedRadio.value = value;
    print(selectedRadio.value.toString());
    ConstPreferences().saveHand(value == 0);
  }

  DateTimeController dateTimeController = Get.put(DateTimeController());
  RxString catId = ''.obs;

  void updateCatId(String id) {
    catId.value = id.toString();
    debugPrint("hgkjgjhghjghj  $id");
  }

  RxInt pressureId = 0.obs;

  Future<void> BloodPressureList(String date, String systolic, String diastolic, String pulesrate, String comment, String time) async {
    try {
      bloodSugarController.isLoading.value = true;
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
        "BloodGlucose" : "",
        "MeasuredTypeId" : 0,
        "SystolicPressure" : systolic.toString(),
        "DiastolicPressure" : diastolic.toString(),
        "PulseRate" : pulesrate.toString(),
        "Hand" : selectedRadio.value == 1 ? true : false,
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
      } else {
        debugPrint("API Error: ${response.statusCode}");
      }
    } catch(error) {
      debugPrint("API Error: $error");
    } finally {
      bloodSugarController.isLoading.value = false;
    }
  }

  Future<void> UpdatebloodPressureList(int id, String date, String systolic, String diastolic, String pulesrate, String comment, String time) async {
    try {
      bloodSugarController.isLoading.value = true;
      int? userId = await ConstPreferences().getUserId('UserId');
      debugPrint("User_Id  $userId");

      int? categoryId =int.tryParse(catId.value);
      debugPrint("Category_Id " + catId.value);

      var body = jsonEncode({
        "Id" : id,
        "UserId" : userId,
        "Cat_Id" : categoryId,
        "DateTime" : date.toString(),
        "BloodGlucose" : "",
        "MeasuredTypeId" : 0,
        "SystolicPressure" : systolic,
        "DiastolicPressure" : diastolic,
        "PulseRate" : pulesrate,
        "Hand" : selectedRadio.value == 1 ? true : false,
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
      } else {
        debugPrint("API Error: ${response.statusCode}");
      }
    } catch(error) {
      debugPrint("API Error: $error");
    } finally {
      bloodSugarController.isLoading.value = false;
    }
  }

  Future<void> getUpdateBloodPressureList(String id) async {
    final response = await http.get(Uri.parse('${ConstApi.getCategoryDetail}$id'));
    var data = response.body;
    debugPrint(data.toString());

    if (response.statusCode == 200) {
      final responseData = categoryFromJson(response.body);
      debugPrint(responseData.toString());
      messageCode = responseData.messageCode;
      debugPrint(messageCode.toString());

      if (messageCode == 1) {
        updateBloodPressureList.clear();
        updateBloodPressureList.addAll(responseData.data);
        var dateFormate = DateFormat('dd/MM/yyyy');
        var dateTime = dateFormate.parse(updateBloodPressureList[0].dateTime.toString());
        dateTimeController.selectedDate.value = dateTime;
        dateTimeController.selectedTime.value = dateTimeController.stringToTime(updateBloodPressureList[0].time.toString());
        dateTimeController.formattedTime.value = updateBloodPressureList[0].time.toString();
        systolicPressureController.text = updateBloodPressureList[0].systolicPressure.toString();
        diastolicPressureController.text = updateBloodPressureList[0].diastolicPressure.toString();
        pulesRateController.text = updateBloodPressureList[0].pulseRate.toString();
        selectedRadio.value = updateBloodPressureList[0].hand ? 1 : 0;
        pressureCommentController.text = updateBloodPressureList[0].comments.toString();
        debugPrint("EditCategoryDetail Successfully");
      } else {
        debugPrint("EditCategoryDetail Error");
      }
    } else {}
  }

}