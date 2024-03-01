import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../ConstFile/constColors.dart';



class Utils{

  void snackBar(String title,String message){
    Get.snackbar(title, message,
        reverseAnimationCurve: Curves.bounceIn,
        forwardAnimationCurve: Curves.bounceInOut,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 5),
        colorText: Colors.white,
        backgroundColor: ConstColour.buttonColor);
  }

  void errorSnackBar(String title,String message){

    Get.snackbar(title, message,
        reverseAnimationCurve: Curves.bounceIn,
        forwardAnimationCurve: Curves.bounceInOut,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 5),
        colorText: Colors.white,
        backgroundColor: Colors.redAccent);
  }

}