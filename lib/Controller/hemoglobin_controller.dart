import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_care_dairy/Controller/blood_sugar_controller.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../ConstFile/constApi.dart';
import '../ConstFile/constPreferences.dart';
import '../model/get_category_model.dart';
import '../model/insert_category_detail_model.dart';
import '../model/measurement_type_model.dart';
import 'date_time_controller.dart';

class A1CController extends GetxController {

  BloodSugarController bloodSugarController = Get.put(BloodSugarController());

  TextEditingController averageSugarController = TextEditingController();
  TextEditingController a1cCommentController = TextEditingController();

  var arr = [];

  int? messageCode;
  RxList<CategoryList> updateHemoglobinList = <CategoryList>[].obs;
  RxList<MeasurementTypesList> measurementTypes = <MeasurementTypesList>[].obs;
  MeasurementTypesList? selectedMeasurementType;

  DateTimeController dateTimeController = Get.put(DateTimeController());
  RxString catId = ''.obs;
  RxInt measurementId = 0.obs;
  RxInt hemoglobinId = 0.obs;

  void updateCatId(String id) {
    catId.value = id.toString();
    debugPrint("hgkjgjhghjghj  $id");
  }

  Future<void> HemoglobinList(String date, String averageSugar, String comment, String time) async {
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
        "SystolicPressure" : 0,
        "DiastolicPressure" : 0,
        "PulseRate" : 0,
        "Hand" : "",
        "BodyTemperature" : "",
        "BloodOxygenSaturation" : 0,
        "MeasurementTypeId" : measurementId.value.toString(),
        "AverageSugarConcentration" : averageSugar,
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
    } catch(e) {
      debugPrint("API Error: $e");
    } finally {
      bloodSugarController.isLoading.value = false;
    }
  }

  Future<void> UpdatehemoglobinList(int id, String date, String averageSugar, String comment, String time) async {
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
        "SystolicPressure" : 0,
        "DiastolicPressure" : 0,
        "PulseRate" : 0,
        "Hand" : "",
        "BodyTemperature" : "",
        "BloodOxygenSaturation" : 0,
        "MeasurementTypeId" : measurementId.value.toString(),
        "AverageSugarConcentration" : averageSugar,
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

  Future<void> measurementTypeList() async {
    final response = await http.post(Uri.parse(ConstApi.measurementType));
    var data = response.body;
    debugPrint(data.toString());

    if (response.statusCode == 200) {
      final responseData = measurementTypeFromJson(response.body);
      debugPrint(responseData.toString());
      messageCode = responseData.messageCode;
      debugPrint(messageCode.toString());

      if (messageCode == 1) {
        measurementTypes.clear();
        measurementTypes.addAll(responseData.data);
        for(int i =0 ; i<measurementTypes.length ; i ++ ){
          arr.add(measurementTypes[i].name.toString());
          print("object"+arr.toString());
        }
        print("measurementTypes"+responseData.data.toString());
        debugPrint("MeasurementTypes Successfully");
      } else {
        debugPrint("MeasurementTypes Error");
      }
    } else {}
  }

  Future<void> getUpdateHemoglobinList(String id) async {
    final response = await http.get(Uri.parse('${ConstApi.getCategoryDetail}$id'));
    var data = response.body;
    debugPrint(data.toString());

    if (response.statusCode == 200) {
      final responseData = categoryFromJson(response.body);
      debugPrint(responseData.toString());
      messageCode = responseData.messageCode;
      debugPrint(messageCode.toString());

      if (messageCode == 1) {
        updateHemoglobinList.clear();
        updateHemoglobinList.addAll(responseData.data);
        var dateFormate = DateFormat('dd/MM/yyyy');
        var dateTime = dateFormate.parse(updateHemoglobinList[0].dateTime.toString());
        dateTimeController.selectedDate.value = dateTime;
        dateTimeController.selectedTime.value = dateTimeController.stringToTime(updateHemoglobinList[0].time.toString());
        dateTimeController.formattedTime.value = updateHemoglobinList[0].time.toString();
        averageSugarController.text = updateHemoglobinList[0].averageSugarConcentration.toString();
        a1cCommentController.text = updateHemoglobinList[0].comments.toString();
        // selectedMeasurementType!.value = updateHemoglobinList[0].measurementTypeName.toString();
        debugPrint("EditCategoryDetail Successfully");
      } else {
        debugPrint("EditCategoryDetail Error");
      }
    } else {}
  }

}