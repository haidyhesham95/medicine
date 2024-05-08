import 'package:shared_preferences/shared_preferences.dart';


class CacheHelper {
  static late SharedPreferences prefs;

  static init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Future<bool> saveId(String id) async {
    return await prefs.setString("id", id);
  }

  static String getId() {
    return prefs.getString("id") ?? '';
  }

  static Future<bool> saveName(String name) async {
    return await prefs.setString("name", name);
  }

  static String getName() {
    return prefs.getString("name") ?? "amr bakr";
  }

  static Future<bool> saveEmail(String email) async {
    return await prefs.setString("email", email);
  }

  static String getEmail() {
    return prefs.getString("email") ?? "amramer522@gmail.com";
  }

  static Future<bool> savePhone(String phone) async {
    return await prefs.setString("phone", phone);
  }

  static String getPhone() {
    return prefs.getString("phone") ?? "01027545022";
  }

  static Future<bool> saveLang(String lang) async {
    return await prefs.setString("lang", lang);
  }

  static String getLang() {
    return prefs.getString("lang") ?? "ar";
  }


  static Future<bool>  clear(){
    return prefs.clear();
  }
}