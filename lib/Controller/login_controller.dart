import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_care_dairy/Controller/home_controller.dart';
import 'package:health_care_dairy/Screens/Setting/unit_screen.dart';
import 'package:health_care_dairy/Screens/home_screen.dart';
import 'package:health_care_dairy/Screens/login_screen.dart';
import 'package:http/http.dart' as http;

import '../Common/snackbar.dart';
import '../ConstFile/constApi.dart';
import '../ConstFile/constPreferences.dart';
import '../Screens/register_screen.dart';
import '../model/login_model.dart';

class LoginController extends GetxController {

  int? messageCode;
  RxList<UserLogin> userDetails = <UserLogin>[].obs;

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  Future<void> login(String email, String password) async {
    final response = await http.post(Uri.parse(ConstApi.userLogin),
    body: {
      "Email" : email,
      "PassWord" : password
    });
    var data = response.body;
    debugPrint(data.toString());

    if (response.statusCode == 200) {
      final responseData = loginFromJson(response.body);
      debugPrint(responseData.toString());
      messageCode = responseData.messageCode;
      debugPrint(messageCode.toString());

      if (messageCode == 1) {
        userDetails.clear();
        userDetails.addAll(responseData.data);

        await ConstPreferences().saveUserId('UserId',responseData.data[0].id);
        // var id = await ConstPreferences().getUserId('UserId');
        debugPrint("Login Successfully");
       // if(id != null){
          Get.to(() => UnitScreen());
        // }else{
        //   Get.to(() => LoginScreen());
       // }

      } else {
        var error = responseData.message.toString();
        Utils().snackBar(response.body, error.toString());
        debugPrint("Error");
      }
    } else {}
  }

}