import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../ConstFile/constColors.dart';

class HomeController extends GetxController {

  List<DiaryList> diarylists = <DiaryList>[
    DiaryList(name: "Blood Sugar", image: "assets/Icons/blood_sugar.png", color: ConstColour.bloodSugarbgColor,),
    DiaryList(name: "Blood Pressure", image: "assets/Icons/blood_pressure.png", color: ConstColour.bloodPressurebgColor),
    DiaryList(name: "Body Temperature", image: "assets/Icons/body_temperature.png", color: ConstColour.bodyTembgColor),
    DiaryList(name: "Blood Oxygen Saturation", image: "assets/Icons/blood_oxygen_saturation.png", color: ConstColour.bloodOxygenbgColor),
    DiaryList(name: "Hemoglobin (A1C)", image: "assets/Icons/hemoglobin.png", color: ConstColour.hemoglobinbgColor),
    DiaryList(name: "Weight", image: "assets/Icons/weight.png", color: ConstColour.weightbgColor),
    DiaryList(name: "Medication", image: "assets/Icons/medication.png", color: ConstColour.medicationbgColor),
  ];
}

class DiaryList {
  DiaryList({required this.name, required this.image, required this.color});

  final String name;
  final String image;
  final Color color;
}