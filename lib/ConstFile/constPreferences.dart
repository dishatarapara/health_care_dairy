import 'package:shared_preferences/shared_preferences.dart';

class ConstPreferences {

  var Average = "Average";
  var BloodGlucoseLevel = "BloodGlucoseLevel";
  var OtherUnits = "OtherUnits";
  var BodyTemperature = "BodyTemperature";
  var Hand = "Hand";

  // Future<void> saveUnitName(String value) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setString(NAME, value);
  // }
  // Future<String?> getUnitName() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.getString(NAME);
  // }

  Future<void> setIntroScreenFlag(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  Future<bool?> isIntroScreenFlag(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  Future<void> saveUserId(String key, int value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key, value);
  }

  Future<int?> getUserId(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key);
  }

  Future<void> saveCategoryId(String key, int value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key, value);
  }

  Future<int?> getCategoryId(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key);
  }

  // Future<void> saveGlucoseLevel(bool value) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setBool(BloodGlucoseLevel, value);
  // }
  //
  // Future<bool?> getGlucoseLevel() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.getBool(BloodGlucoseLevel);
  // }

  Future<void> saveOtherUnit(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(OtherUnits, value);
  }

  Future<bool?> getOtherUnit() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(OtherUnits);
  }

  Future<void> saveBodyTemperature(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(BodyTemperature, value);
  }

  Future<bool?> getBodyTemperature() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(BodyTemperature);
  }

  Future<void> saveAverage(String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(Average, value);
  }

  Future<String?> getAverage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(Average);
  }

  Future<void> saveHand(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(Hand, value);
  }

  Future<bool?> getHand() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(Hand);
  }

  void clearPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }

}