import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_care_dairy/Controller/blood_sugar_controller.dart';
import 'package:http/http.dart' as http;

import '../ConstFile/constApi.dart';
import '../ConstFile/constPreferences.dart';
import '../model/get_category_model.dart';
import '../model/insert_category_detail_model.dart';
import '../model/select_data_model.dart';

class MedicationController extends GetxController {

  BloodSugarController bloodSugarController = Get.put(BloodSugarController());

  TextEditingController medicationNameController = TextEditingController();
  TextEditingController dosageController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  Rx<Color> selectedColor = Rx<Color>(Colors.black);
  RxList<CategoryList> updateMedicationList = <CategoryList>[].obs;
  RxList<SelectData> selectedDataList = <SelectData>[].obs;

  int? messageCode;
  RxString unit = ''.obs;
  RxInt selectedDataTypeId = 0.obs;
  RxInt medicationId = 0.obs;

  RxString catId = ''.obs;

  void updateCatId(String id) {
    catId.value = id.toString();
    debugPrint("hgkjgjhghjghj  $id");
  }


  // List<String> units = <String> [
  //   "Unit",
  //   "Mg.",
  //   "G.",
  //   "Ml.",
  //   "Mcg.",
  //   "Pill",
  //   "Oz",
  //   "Drop",
  // ];

  Future<void> MedicationList(String medicationName, String dosage, String timesAndDay, String comment) async {
    try {
      bloodSugarController.isLoading.value = true;
      int? userId = await ConstPreferences().getUserId('UserId');
      debugPrint("User_Id  $userId");

      int? categoryId =int.tryParse(catId.value);
      debugPrint("Category_Id " + catId.value);

      var body = jsonEncode({
        "Id" : 0,
        "UserId" : userId,
        "Cat_Id" : categoryId,
        "DateTime" : "",
        "BloodGlucose" : 0.0,
        "MeasuredTypeId" : 0,
        "SystolicPressure" : 0,
        "DiastolicPressure" : 0,
        "PulseRate" : 0,
        "Hand" : "",
        "BodyTemperature" : "",
        "BloodOxygenSaturation" : 0,
        "MeasurementTypeId" : 0,
        "AverageSugarConcentration" : "",
        "Weight" : "",
        "MedicationName" : medicationName.toString(),
        "SelectDataTypeId" : selectedDataTypeId.value.toString(),
        "Dosage" : dosage.toString(),
        "TimesAndDay" : timesAndDay.toString(),
        "Color" : selectedColor.toString(),
        "Comments" : comment.toString(),
        "Unit": null,
        "Time": ""
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
          debugPrint("MedicationList Successfully");
          bloodSugarController.getCategoryList();
          Get.back();
        } else {
          debugPrint("MedicationList Error");
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

  Future<void> UpdateMedicationList(int id, String medicationName, String dosage, String timesAndDay, String comment) async {
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
        "DateTime" : "",
        "BloodGlucose" : 0.0,
        "MeasuredTypeId" : 0,
        "SystolicPressure" : 0,
        "DiastolicPressure" : 0,
        "PulseRate" : 0,
        "Hand" : "",
        "BodyTemperature" : "",
        "BloodOxygenSaturation" : 0,
        "MeasurementTypeId" : 0,
        "AverageSugarConcentration" : "",
        "Weight" : "",
        "MedicationName" : medicationName.toString(),
        "SelectDataTypeId" : selectedDataTypeId.value.toString(),
        "Dosage" : dosage.toString(),
        "TimesAndDay" : timesAndDay.toString(),
        "Color" : selectedColor.toString(),
        "Comments" : comment.toString(),
        "Unit": null,
        "Time": ""
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
      } else {
        debugPrint("API Error: ${response.statusCode}");
      }
    } catch(error) {
      debugPrint("API Error: $error");
    } finally {
      bloodSugarController.isLoading.value = false;
    }
  }

  Future<void> getUpdateMedicationList(String id) async {
    final response = await http.get(Uri.parse('${ConstApi.getCategoryDetail}$id'));
    var data = response.body;
    debugPrint(data.toString());

    if (response.statusCode == 200) {
      final responseData = categoryFromJson(response.body);
      debugPrint(responseData.toString());
      messageCode = responseData.messageCode;
      debugPrint(messageCode.toString());

      if (messageCode == 1) {
        updateMedicationList.clear();
        updateMedicationList.addAll(responseData.data);
        medicationNameController.text = updateMedicationList[0].medicationName.toString();
        unit.value = updateMedicationList[0].selectDataTypeName.toString();
        dosageController.text = updateMedicationList[0].dosage.toString();
        timeController.text = updateMedicationList[0].timesAndDay.toString();
        String colorString = updateMedicationList[0].color.toString();
        RegExp hexColorRegex = RegExp(r'0x([a-fA-F0-9]+)');
        String hexColor = hexColorRegex.firstMatch(colorString)?.group(1) ?? 'ff5722';
        selectedColor.value = Color(int.parse(hexColor, radix: 16) + 0xFF000000);
        noteController.text = updateMedicationList[0].comments.toString();
        // selectedColor.value = Color(int.parse(updateMedicationList[0].color.toString().replaceAll('#', '0x'), radix: 16));
        // selectedColor.value = updateMedicationList[0].color.toString();
        debugPrint("EditCategoryDetail Successfully");
      } else {
        debugPrint("EditCategoryDetail Error");
      }
    } else {}
  }

  Future<void> selectDataList() async {
    final response = await http.post(Uri.parse(ConstApi.selectDataType));
    var data = response.body;
    debugPrint(data.toString());

    if (response.statusCode == 200) {
      final responseData = selectedDataFromJson(response.body);
      debugPrint(responseData.toString());
      messageCode = responseData.messageCode;
      debugPrint(messageCode.toString());

      if (messageCode == 1) {
        selectedDataList.clear();
        selectedDataList.addAll(responseData.data);
        debugPrint("SelectedDataList Successfully");
      } else {
        debugPrint("SelectedDataList Error");
      }
    } else {}
  }

}