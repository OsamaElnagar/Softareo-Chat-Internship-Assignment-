import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> putData(String key, bool value) async {
    return await sharedPreferences.setBool(key, value);
  }

  static dynamic getData(
    String key,
  ) {
    return sharedPreferences.get(key);
  }

  static Future<bool> saveLoginData(
      {required String key, dynamic value}) async {
    return await sharedPreferences.setString(key, value);
  }

  static Future<bool> removeData({required String key}) async {
    return await sharedPreferences.remove(key);
  }

  static Future<bool> clearData() async {
    return await sharedPreferences.clear();
  }
}
