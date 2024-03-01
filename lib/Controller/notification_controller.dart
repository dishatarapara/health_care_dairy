import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {

  TextEditingController notificationNameController = TextEditingController();

  RxInt selectedType = 0.obs;
  RxBool weekNameType = false.obs;

  setSelectedType(val) {
    selectedType.value = val;
    if (selectedType.value == 1) {
      weekNameType.value = false;
    } else {
      weekNameType.value = true;
    }
    debugPrint(selectedType.value.toString());
  }

  List<String> weekNames = <String>[
    "Sun",
    "Mon",
    "Tue",
    "Wed",
    "Thu",
    "Fri",
    "Sat"
  ];
}