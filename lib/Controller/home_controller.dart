import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../ConstFile/constApi.dart';
import '../ConstFile/constColors.dart';
import '../ConstFile/constPreferences.dart';
import '../model/home_screen_model.dart';

class HomeController extends GetxController {

  int? messageCode;
  RxList<Data> diaryLists = <Data>[].obs;

  List<String> imagesList = <String>[
    "assets/Icons/blood_sugar.png",
    "assets/Icons/blood_pressure.png",
    "assets/Icons/body_temperature.png",
    "assets/Icons/blood_oxygen_saturation.png",
    "assets/Icons/hemoglobin.png",
    "assets/Icons/weight.png",
    "assets/Icons/medication.png"
  ];

  List<Color> colorList = <Color>[
    ConstColour.bloodSugarbgColor,
    ConstColour.bloodPressurebgColor,
    ConstColour.bodyTembgColor,
    ConstColour.bloodOxygenbgColor,
    ConstColour.hemoglobinbgColor,
    ConstColour.weightbgColor,
    ConstColour.medicationbgColor
  ];

  // List<DiaryList> diarylists = <DiaryList>[
  //   DiaryList(name: "Blood Sugar", image: "assets/Icons/blood_sugar.png", color: ConstColour.bloodSugarbgColor,),
  //   DiaryList(name: "Blood Pressure", image: "assets/Icons/blood_pressure.png", color: ConstColour.bloodPressurebgColor),
  //   DiaryList(name: "Body Temperature", image: "assets/Icons/body_temperature.png", color: ConstColour.bodyTembgColor),
  //   DiaryList(name: "Blood Oxygen Saturation", image: "assets/Icons/blood_oxygen_saturation.png", color: ConstColour.bloodOxygenbgColor),
  //   DiaryList(name: "Hemoglobin (A1C)", image: "assets/Icons/hemoglobin.png", color: ConstColour.hemoglobinbgColor),
  //   DiaryList(name: "Weight", image: "assets/Icons/weight.png", color: ConstColour.weightbgColor),
  //   DiaryList(name: "Medication", image: "assets/Icons/medication.png", color: ConstColour.medicationbgColor),
  // ];

  Future<void> submitData() async {
    final response = await http.post(Uri.parse(ConstApi.dairyList),);
    var data = response.body;
    debugPrint(data.toString());

    if (response.statusCode == 200) {
      final responseData = healthCareDetailFromJson(response.body);
      debugPrint(responseData.toString());
      messageCode = responseData.messageCode;
      debugPrint(messageCode.toString());

      if (messageCode == 1) {
        diaryLists.clear();
        diaryLists.addAll(responseData.data);
        debugPrint("Successfully");
      } else {
        debugPrint("Error");
      }
    } else {}
  }
}

// class DiaryList {
//   DiaryList({required this.name, required this.image, required this.color});
//
//   final String name;
//   final String image;
//   final Color color;
// }