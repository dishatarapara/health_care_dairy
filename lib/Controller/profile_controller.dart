import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ConstFile/constPreferences.dart';

class ProfileController extends GetxController{

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  RxString imagePath = ''.obs;

  // var Username = "Username";
  // var Email = "Email";

  void getImageGallery() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imagePath.value = image.path;
    }
  }

  void getImageCamera() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      imagePath.value = image.path;
    }
  }

  void removePicture() async {
    ConstPreferences().clearPreferences();
    imagePath.value = "";
  }


  void saveImage(String? path) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("imagepath", path ?? "");
  }


  void loadImage() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
      imagePath.value = preferences.getString("imagepath") ?? "";
  }

  // void saveStringTo(String? username, String? email) async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   preferences.setString('Username', username ?? '');
  //   preferences.setString('Email', email ?? '');
  // }
  //
  // void getStringTo() async  {
  //   var sharedPref = await SharedPreferences.getInstance();
  //   Username = sharedPref.getString('Username') ?? '';
  //   Email = sharedPref.getString('Email') ?? '';
  // }

    // String username = profileController.emailController.text;
    // String email = profileController.emailController.text;
    //
    // profileController.saveImage(profileController.imagePath.value);
    // var sharedPref = await SharedPreferences.getInstance();
    // sharedPref.setString('Username', username);
    // sharedPref.setString('Email', email);
  }


