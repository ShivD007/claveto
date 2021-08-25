// To parse this JSON data, do
//
//     final forgotPasswordModel = forgotPasswordModelFromMap(jsonString);

import 'dart:convert';

ForgotPasswordModel forgotPasswordModelFromMap(String str) => ForgotPasswordModel.fromMap(json.decode(str));

String forgotPasswordModelToMap(ForgotPasswordModel data) => json.encode(data.toMap());

class ForgotPasswordModel {
  ForgotPasswordModel({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  List<dynamic> data;

  factory ForgotPasswordModel.fromMap(Map<String, dynamic> json) => ForgotPasswordModel(
    status: json["status"],
    message: json["message"],
    data: List<dynamic>.from(json["data"].map((x) => x)),
  );

  Map<String, dynamic> toMap() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x)),
  };
}
