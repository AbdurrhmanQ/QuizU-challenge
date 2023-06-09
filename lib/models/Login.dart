import 'dart:convert';

Login LoginFromJson(String str) => Login.fromJson(json.decode(str));

String LoginToJson(Login data) => json.encode(data.toJson());

class Login {
  Login(
    this.success,
    this.userStatus,
    this.message,
    this.token,
  );

  bool success;
  String userStatus;
  String message;
  String token;

  Login.fromJson(Map<String, dynamic> json)
      : success = json["success"],
        userStatus = json["user_status"],
        message = json["message"],
        token = json["token"];

  Map<String, dynamic> toJson() => {
        "success": success,
        "user_status": userStatus,
        "message": message,
        "token": token,
      };
}
