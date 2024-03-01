import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../ConstFile/constColors.dart';
import '../Controller/home_controller.dart';

class NextButton extends StatelessWidget {
  final VoidCallback? onPressed;
  var btnName;
  NextButton({Key? key, this.onPressed,this.btnName}) : super(key: key);

  HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50)),
          minimumSize: Size(deviceWidth * 0.9, deviceHeight * 0.06),
          backgroundColor: ConstColour.buttonColor
      ),
      onPressed: onPressed,
      child: Text(
        btnName,
        style: TextStyle(
            fontSize: 20,
            color: ConstColour.bgColor
        ),
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
      ),
    );
  }
}