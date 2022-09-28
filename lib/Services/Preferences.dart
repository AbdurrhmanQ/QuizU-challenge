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

  static Future<void> deleteToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
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

  static Future<void> saveScore(score) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var scores;
    scores = prefs.getStringList('scores');
    if (scores == null) {
      List<String> scoreList = [];
      scoreList.add("Date: " +
          DateTime.now().toString().substring(0, 16) +
          '  Score: ' +
          score);
      prefs.setStringList('scores', scoreList);
    } else {
      scores.add("Date: " +
          DateTime.now().toString().substring(0, 16) +
          '  Score: ' +
          score);
      prefs.setStringList('scores', scores);
    }
  }

  static Future<List<String>?> getScores() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? scores = prefs.getStringList('scores');
    return scores;
  }
}
