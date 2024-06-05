import 'package:shared_preferences/shared_preferences.dart';

class PrefsData {
  Future<void> setData(String key, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future<void> setBoolData(String key, bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  Future<String> getData(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String value = prefs.getString(key) ?? "null";
    return value;
  }
  Future<bool> getBoolData(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? false;
  }
}