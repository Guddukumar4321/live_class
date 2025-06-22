import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static Future<void> saveUser(String uid, String email, bool isLogin) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('uid', uid);
    await prefs.setString('email', email);
    await prefs.setBool('is_logged_in', isLogin);
  }

  static Future<String?> getUid() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('uid');
  }

  static Future setUserData(String key, bool? isBool, var value) async {
    final prefs = await SharedPreferences.getInstance();
    if(isBool??false){
      return prefs.setBool(key, value);
    }else{
      return prefs.setString(key, value);

    }
  }

  static Future getUserData(String key, bool? isBool) async {
    final prefs = await SharedPreferences.getInstance();
    if(isBool??false){
      var data = prefs.getBool(key);
      return data??false;
    }else{
      var data = prefs.getString(key);
      return data??"User";

    }
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
