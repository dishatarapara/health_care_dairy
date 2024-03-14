import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_care_dairy/ConstFile/constFonts.dart';
import '../ConstFile/constColors.dart';



class Utils{

  void snackBar(String title,String message){
    Get.snackbar(title, message,
        titleText: Text(title,style: TextStyle(
          fontSize: 20,
          color: Colors.white,
          fontFamily: ConstFont.bold
        ),),
        messageText: Text(message,style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontFamily: ConstFont.regular
        ),),
        reverseAnimationCurve: Curves.bounceIn,
        forwardAnimationCurve: Curves.bounceInOut,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 5),
        colorText: Colors.white,
        backgroundColor: ConstColour.buttonColor);
  }

  void errorSnackBar(String title,String message){
    Get.snackbar(title, message,
        titleText: Text(title,style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontFamily: ConstFont.bold
        ),),
        messageText: Text(message,style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontFamily: ConstFont.regular
        ),),
        reverseAnimationCurve: Curves.bounceIn,
        forwardAnimationCurve: Curves.bounceInOut,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 5),
        colorText: Colors.white,
        backgroundColor: Colors.red);
  }

}