import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UnitController extends GetxController {
  RxInt selectIndex = 2.obs;

  RxInt bodyIndex = 4.obs;

  RxBool glucoseLevel = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getGlucoseLevel();
  }

  Future<bool?> getGlucoseLevel() async {
    final prefs = await SharedPreferences.getInstance();
    glucoseLevel.value =  prefs.getBool('BloodGlucoseLevel') ?? false;
  }

  Future<void> saveGlucoseLevel(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('BloodGlucoseLevel', value);
    glucoseLevel.value = value;
  }

  bool getGlucoseLevelPreference() {
    return glucoseLevel.value;
  }
}