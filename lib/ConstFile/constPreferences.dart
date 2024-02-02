import 'package:shared_preferences/shared_preferences.dart';

class ConstPreferences {

  var NAME = "NAME";

  Future<void> saveUnitName(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(NAME, value);
  }
  Future<String?> getUnitName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(NAME);
  }

  void removePreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove('');
  }
}