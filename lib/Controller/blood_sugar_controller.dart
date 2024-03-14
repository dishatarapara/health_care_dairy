import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_care_dairy/Controller/date_time_controller.dart';
import 'package:health_care_dairy/Controller/unit_controller.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../ConstFile/constApi.dart';
import '../ConstFile/constPreferences.dart';
import '../model/insert_category_detail_model.dart';
import '../model/get_category_model.dart';
import '../model/measured_type_model.dart';

class BloodSugarController extends GetxController {
  UnitController unitController = Get.put(UnitController());

  TextEditingController bloodGlucoseController = TextEditingController();
  TextEditingController commentController = TextEditingController();

  int? messageCode;
  RxString measuredType = ''.obs;
  RxInt measuredId = 0.obs;
  var isLoading = false.obs;

  RxInt selectedMesuredListType = 0.obs;
  RxBool mesuredListNameType = false.obs;

  setSelectedListType(val) {
    selectedMesuredListType.value = val;
    if (selectedMesuredListType.value == 0) {
      mesuredListNameType.value = false;
    } else {
      mesuredListNameType.value = true;
    }
    debugPrint(selectedMesuredListType.value.toString());
  }

  String formatDate(String dateString) {
    final dateTime = DateFormat('MM/yyyy').parse(dateString);
    final formattedDate = DateFormat('MMM, yyyy').format(dateTime);
    return formattedDate;
  }

  // RxInt selectedSheetRadio = 5.obs;
  //
  // setSelectedSheetRadio(value) {
  //   selectedSheetRadio.value = value;
  //   print(selectedSheetRadio.value.toString());
  // }


  RxList<CategoryList> bloodSugarLists = <CategoryList>[].obs;
  RxList<CategoryList> updateBloodSugarList = <CategoryList>[].obs;
  RxList<MeasuredTypesList> measuredTypes = <MeasuredTypesList>[].obs;

  DateTimeController dateTimeController = Get.put(DateTimeController());
  RxString catId = ''.obs;

  RxInt sugarId = 0.obs;

  void updateCatId(String id) {
    catId.value = id.toString();
    debugPrint("Cat_Id  $id");
  }

  // RxBool longPressFlag = false.obs;
  //
  // void longPress() {
  //   if(bloodSugarLists.isEmpty) {
  //     longPressFlag.value = false;
  //   } else {
  //     longPressFlag.value = true;
  //   }
  // }

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
    // isLoading.value = true;
    try {
      isLoading.value = true;
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
    } else {
        debugPrint("API Error: ${response.statusCode}");
      }
    } catch(error) {
      debugPrint("API Error: $error");
    } finally {
      isLoading.value = false;
    }
    // isLoading.value = false;
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

        getFilterData(bloodSugarLists);
        debugPrint("categoryIdDetails Successfully");
      } else {
        debugPrint("categoryIdDetails Error");
      }
    } else {}
  }

  void getFilterData(RxList<CategoryList> bloodSugarLists) {
    var list = groupDataByMonth(bloodSugarLists);
    bloodSugarLists.clear();
    //list.sort((a, b) => DateTime.parse(parseDate(a.dateTime)).compareTo(DateTime.parse(parseDate(b.dateTime))));
    list.sort((a, b) => parseDate(b.dateTime).compareTo(parseDate(a.dateTime)));
    bloodSugarLists.addAll(list);
  }

  DateTime parseDate(String dateString) {
    final parts = dateString.split('/');
    final day = int.parse(parts[0]);
    final month = int.parse(parts[1]);
    final year = int.parse(parts[2]);
    return DateTime(year, month, day);
  }

/*
  List<CategoryList> groupDataByMonth() {
    Map<String, List<CategoryList>> groupedData = {};

    for (int i = 0; i < bloodSugarLists.length; i++) {
      String dateString = bloodSugarLists[i].dateTime;

      final monthYear = dateString.substring(3);
      groupedData.putIfAbsent(monthYear, () => []);
      groupedData[monthYear]!.add(bloodSugarLists[i]);

    }


    return groupedData.values.expand((x) => x).toList();
  }
*/

  List<CategoryList> groupDataByMonth(RxList<CategoryList> bloodSugarLists) {
    Map<String, List<CategoryList>> groupedData = {};

    for (int i = 0; i < bloodSugarLists.length; i++) {
      String dateString = bloodSugarLists[i].dateTime;

      //   final monthYear = dateString.substring(3, 10); // Extracting month/year (assuming date format is "DD-MM-YYYY")
      //   groupedData.putIfAbsent(monthYear, () => []);
      //   groupedData[monthYear]!.add(bloodSugarLists[i]);
      // }

      final parts = dateString.split('/');
      if (parts.length >= 3) {
        final monthYear = '${parts[1]}/${parts[2]}'; // Extracting month/year
        groupedData.putIfAbsent(monthYear, () => []);
        groupedData[monthYear]!.add(bloodSugarLists[i]);
      }
    }

    return groupedData.values.expand((x) => x).toList();
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
    try {
      isLoading.value = true;
      int? userId = await ConstPreferences().getUserId('UserId');
      debugPrint("User_Id  $userId");

      int? categoryId =int.tryParse(catId.value);
      debugPrint("Category_Id " + catId.value);

      late String unitType;
      late String unitTypevalue;

      if( unitController.getGlucoseLevelPreference()) {
        unitType = 'mmol/L';

        unitTypevalue =  ((double.parse(glucose)) * 18).toStringAsFixed(2);
      }else{
        unitType =  'mg/dL';
        unitTypevalue = glucose.toString();
      }


      // var date =  DateFormat('dd/MM/yyyy').format(dateTimeController.selectedDate.value);
      var body = jsonEncode({
        "Id" : id,
        "UserId" : userId,
        "Cat_Id" : categoryId,
        "DateTime" : date.toString(),
        "BloodGlucose" : unitTypevalue.toString(),
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
      } else {
        debugPrint("API Error: ${response.statusCode}");
      }
    } catch(error) {
      debugPrint("API Error: $error");
    } finally {
      isLoading.value = false;
    }
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
        updateBloodSugarList.clear();
        updateBloodSugarList.addAll(responseData.data);
        var dateFormate = DateFormat('dd/MM/yyyy');
        var dateTime = dateFormate.parse(updateBloodSugarList[0].dateTime.toString());
        dateTimeController.selectedDate.value = dateTime;
        dateTimeController.selectedTime.value = dateTimeController.stringToTime(updateBloodSugarList[0].time.toString());
        dateTimeController.formattedTime.value = updateBloodSugarList[0].time.toString();

        // if(unitController.getGlucoseLevelPreference()) { // mg/dl
        //   bloodGlucoseController.text = (updateBloodSugarList[0].bloodGlucose / 18).toStringAsFixed(2);
        // } else {
        //   bloodGlucoseController.text = (updateBloodSugarList[0].bloodGlucose).toStringAsFixed(2);
        // }
        String unitType;
        String unitTypeValue;

        if( unitController.getGlucoseLevelPreference()) {
          unitType = 'mmol/L';
          unitTypeValue =  ((updateBloodSugarList[0].bloodGlucose) / 18).toStringAsFixed(2);
        }else{
          unitType =  'mg/dL';
          unitTypeValue = updateBloodSugarList[0].bloodGlucose.toString();
        }

        bloodGlucoseController.text = unitTypeValue;
        commentController.text = updateBloodSugarList[0].comments.toString();
        measuredType.value = updateBloodSugarList[0].measuredTypeName.toString();

        for(int i=0; i<measuredTypes.length; i++) {
          if(measuredTypes[i].name.toString() == updateBloodSugarList[0].measuredTypeName.toString()) {
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

