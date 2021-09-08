// To parse this JSON data, do
//
//     final registerFail = registerFailFromMap(jsonString);

import 'dart:convert';

RegisterFail registerFailFromMap(String str) => RegisterFail.fromMap(json.decode(str));

String registerFailToMap(RegisterFail data) => json.encode(data.toMap());

class RegisterFail {
  RegisterFail({
    this.status,
    this.message,
    this.data,
  });

  int status;
  String message;
  List<dynamic> data;

  factory RegisterFail.fromMap(Map<String, dynamic> json) => RegisterFail(
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
