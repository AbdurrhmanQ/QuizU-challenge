import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  //storing the user/token in the device
  static Future<void> setToken(token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }

  static Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    return await token.toString();
  }

  static Future<void> setMobile(mobile) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('mobile', mobile);
  }

  static Future<String> getmobile() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var mobile = prefs.getString('mobile');
    return await mobile.toString();
  }
}
