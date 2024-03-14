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

class WeightController extends GetxController {
  BloodSugarController bloodSugarController = Get.put(BloodSugarController());

  TextEditingController bodyWeightController = TextEditingController();
  TextEditingController weightCommentController = TextEditingController();

  RxList<CategoryList> updateWeightList = <CategoryList>[].obs;

  int? messageCode;
  DateTimeController dateTimeController = Get.put(DateTimeController());
  RxString catId = ''.obs;
  // RxBool isKGSelected = false.obs;
  RxBool newVal = false.obs;
  // var pref;


  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    // isKGSelected.value =  (await ConstPreferences().getOtherUnit())!;
    // print(isKGSelected.value);
  }

  // void setPref() async {
  //   isKGSelected.value = (await ConstPreferences().getOtherUnit())!;
  //   print("object"+isKGSelected.toString());
  //   newVal.value = isKGSelected.value;
  //   // print("prefs" + isKGSelected.toString());
  //   print("prefs" + newVal.toString());
  // }

  void updateCatId(String id) {
    catId.value = id.toString();
    debugPrint("hgkjgjhghjghj  $id");
  }

  RxInt weightId = 0.obs;

  Future<void> WeightList(
      String date, String weight, String comment, String time) async {
    try {
      bloodSugarController.isLoading.value = true;
      int? userId = await ConstPreferences().getUserId('UserId');
      debugPrint("User_Id  $userId");

      int? categoryId = int.tryParse(catId.value);
      debugPrint("Category_Id " + catId.value);

      // var date =  DateFormat('dd/MM/yyyy').format(dateTimeController.selectedDate.value);
      var body = jsonEncode({
        "Id": 0,
        "UserId": userId,
        "Cat_Id": categoryId,
        "DateTime": date.toString(),
        "BloodGlucose": 0.0,
        "MeasuredTypeId": 0,
        "SystolicPressure": 0,
        "DiastolicPressure": 0,
        "PulseRate": 0,
        "Hand": "",
        "BodyTemperature": "",
        "BloodOxygenSaturation": 0,
        "MeasurementTypeId": 0,
        "AverageSugarConcentration": "",
        "Weight": weight,
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
          debugPrint("WeightList Successfully");
          bloodSugarController.getCategoryList();
          Get.back();
        } else {
          debugPrint("WeightList Error");
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

  Future<void> UpdateweightList(
      int id, String date, String weight, String comment, String time) async {
    try {
      bloodSugarController.isLoading.value = true;
      int? userId = await ConstPreferences().getUserId('UserId');
      debugPrint("User_Id  $userId");

      int? categoryId = int.tryParse(catId.value);
      debugPrint("Category_Id " + catId.value);

      String unitWeight;
      String unitWeightValue;
      var iskg = await ConstPreferences().getOtherUnit();
      if(iskg == true) { // kg to lbs
        unitWeight = 'lbs';
        unitWeightValue = weight.toString(); // lbs
      } else { // lbs to kg
        unitWeight = 'kg';
        unitWeightValue = (double.parse(weight) / 2.2046).toString(); // kg
      }

      var body = jsonEncode({
        "Id": id,
        "UserId": userId,
        "Cat_Id": categoryId,
        "DateTime": date.toString(),
        "BloodGlucose": 0.0,
        "MeasuredTypeId": 0,
        "SystolicPressure": 0,
        "DiastolicPressure": 0,
        "PulseRate": 0,
        "Hand": "",
        "BodyTemperature": "",
        "BloodOxygenSaturation": 0,
        "MeasurementTypeId": 0,
        "AverageSugarConcentration": "",
        "Weight": unitWeightValue,
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

  Future<void> getUpdateWeightList(String id) async {
    final response =
        await http.get(Uri.parse('${ConstApi.getCategoryDetail}$id'));
    var data = response.body;
    debugPrint(data.toString());

    if (response.statusCode == 200) {
      final responseData = categoryFromJson(response.body);
      debugPrint(responseData.toString());
      messageCode = responseData.messageCode;
      debugPrint(messageCode.toString());

      if (messageCode == 1) {
        updateWeightList.clear();
        updateWeightList.addAll(responseData.data);
        var dateFormate = DateFormat('dd/MM/yyyy');
        var dateTime = dateFormate.parse(updateWeightList[0].dateTime.toString());
        dateTimeController.selectedDate.value = dateTime;
        dateTimeController.selectedTime.value = dateTimeController.stringToTime(updateWeightList[0].time.toString());
        dateTimeController.formattedTime.value = updateWeightList[0].time.toString();

        String unitWeight;
        String unitWeightValue;
        var iskg = await ConstPreferences().getOtherUnit();
        if(iskg == true) { // kg to lbs
          unitWeight = 'lbs';
          unitWeightValue = updateWeightList[0].weight.toStringAsFixed(1); // lbs
        } else { // lbs to kg
          unitWeight = 'kg';
          unitWeightValue = (updateWeightList[0].weight * 2.2046).toStringAsFixed(1); // kg
        }
        bodyWeightController.text = unitWeightValue;
        // bodyWeightController.text = updateWeightList[0].weight.toString();
        weightCommentController.text = updateWeightList[0].comments.toString();
        debugPrint("EditCategoryDetail Successfully");
      } else {
        debugPrint("EditCategoryDetail Error");
      }
    } else {}
  }

  // String convertWeightValue(double value, bool toLbs) {
  //   if (toLbs) {
  //     // Convert KG to LBS
  //     double convertedValue = value / 0.45359237;
  //     return convertedValue.toStringAsFixed(1);
  //   } else {
  //     // Convert LBS to KG
  //     double convertedValue = value * 0.45359237;
  //     return convertedValue.toStringAsFixed(1);
  //   }
  // }
}
