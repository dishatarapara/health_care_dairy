import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_care_dairy/Screens/login_screen.dart';
import 'package:http/http.dart' as http;

import '../Common/snackbar.dart';
import '../ConstFile/constApi.dart';
import '../Screens/Setting/unit_screen.dart';
import '../model/register_model.dart';

class RegisterController extends GetxController {
  int? messageCode;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> register(String name, String email, String password) async {
    final response = await http.post(Uri.parse(ConstApi.userRegister),
        body: {
          "Name" : name,
          "Email" : email,
          "PassWord" : password
        });
    var data = response.body;
    debugPrint(data.toString());

    if (response.statusCode == 200) {
      final responseData = registerFromJson(response.body);
      debugPrint(responseData.toString());
      messageCode = responseData.messageCode;
      debugPrint(messageCode.toString());

      if (messageCode == 1) {
        debugPrint("Register Successfully");
        Get.to(() => LoginScreen());
      } else {
        var error = responseData.message.toString();
        Utils().errorSnackBar(response.body, error.toString());
        debugPrint("Error");
      }
    } else {}
  }

}