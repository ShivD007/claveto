// To parse this JSON data, do
//
//     final changePassword = changePasswordFromMap(jsonString);

import 'dart:convert';

ChangePassword changePasswordFromMap(String str) => ChangePassword.fromMap(json.decode(str));

String changePasswordToMap(ChangePassword data) => json.encode(data.toMap());

class ChangePassword {
  ChangePassword({
    this.message,
    this.token,
  });

  String message;
  String token;

  factory ChangePassword.fromMap(Map<String, dynamic> json) => ChangePassword(
    message: json["message"],
    token: json["token"],
  );

  Map<String, dynamic> toMap() => {
    "message": message,
    "token": token,
  };
}
