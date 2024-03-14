import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ConstFile/constPreferences.dart';

class ProfileController extends GetxController{

  RxString imagePath = ''.obs;

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
}


