import 'dart:convert';
import 'package:quizme/Services/Preferences.dart';
import 'package:quizme/main.dart';
import 'package:quizme/models/Leaderboard.dart';

import 'package:http/http.dart' as http;
import 'package:quizme/models/Login.dart';
import 'package:quizme/models/Profile.dart';
import 'package:quizme/models/Question.dart';

//TODO: Throw exception when respons is not 200
class RemoteAPI {
  //Cheks if user did login or not
  Future<bool> checkToken() async {
    print('THis is chekToken ' + token);
    token = await Preferences.getToken();
    http.Response res = await http.get(
        Uri.parse(
          'https://quizu.okoul.com/Token',
        ),
        headers: {
          'Authorization': 'Bearer $token',
        });

    var body = jsonDecode(res.body);
    bool? success = body['success'];
    var message = body['message'];

    if (res.statusCode == 200 || success!) {
      print(message);

      return true;
    } else {
      print(message);

      return false;
    }
  }

//Login and request a token from server
  Future login(String mobile, String otp) async {
    http.Response res = await http.post(
      Uri.parse('https://quizu.okoul.com/Login'),
      body: {"OTP": otp, "mobile": mobile},
    );

    if (res.statusCode == 201) {
      var body = jsonDecode(res.body);
      var obj = Login.fromJson(body);
      token = obj.token;

      Preferences.setToken(token);
    }
  }

  Future userName(String name) async {
    http.Response res =
        await http.post(Uri.parse('https://quizu.okoul.com/Name'), headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/x-www-form-urlencoded'
    }, body: {
      'name': name
    });

    if (res.statusCode == 201) {}
  }

  Future<Profile> fetchProfile() async {
    http.Response res = await http.get(
      Uri.parse('https://quizu.okoul.com/UserInfo'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      Profile profile = Profile.fromJson(body);
      return profile;
    } else {
      throw Exception('Failed to load Profile!');
    }
  }

  Future<List<Leaderboard>> fetchLeaderboard() async {
    http.Response res = await http.get(
      Uri.parse('https://quizu.okoul.com/TopScores'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      List<Leaderboard> top10 = [];
      for (var element in body) {
        top10.add(Leaderboard.fromJson(element));
      }
      return top10;
    }

    return null!;
  }

  Future<List<Question>> fetchQuestions() async {
    http.Response res = await http.get(
      Uri.parse('https://quizu.okoul.com/Questions'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      List<Question> questions = [];

      for (var element in body) {
        questions.add(Question.fromJson(element));
      }
      return questions;
    }

    return null!;
  }

  Future postScore(int score) async {
    http.Response res = await http.post(
      Uri.parse('https://quizu.okoul.com/Score'),
      headers: {
        'Authorization': 'Bearer $token',
      },
      body: {'score': score.toString()},
    );

    var body = jsonDecode(res.body);
    bool success = body['success'];
    var message = body['message'];

    if (success) {
      print(message);
    } else
      print(message);
  }
}
