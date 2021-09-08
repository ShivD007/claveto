// To parse this JSON data, do
//
//     final registerSuccess = registerSuccessFromMap(jsonString);

import 'dart:convert';

RegisterSuccess registerSuccessFromMap(String str) => RegisterSuccess.fromMap(json.decode(str));

String registerSuccessToMap(RegisterSuccess data) => json.encode(data.toMap());

class RegisterSuccess {
  RegisterSuccess({
    this.user,
    this.details,
    this.accessToken,
  });

  User user;
  Details details;
  String accessToken;

  factory RegisterSuccess.fromMap(Map<String, dynamic> json) => RegisterSuccess(
    user: User.fromMap(json["user"]),
    details: Details.fromMap(json["details"]),
    accessToken: json["access_token"],
  );

  Map<String, dynamic> toMap() => {
    "user": user.toMap(),
    "details": details.toMap(),
    "access_token": accessToken,
  };
}

class Details {
  Details({
    this.userId,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  int userId;
  DateTime updatedAt;
  DateTime createdAt;
  int id;

  factory Details.fromMap(Map<String, dynamic> json) => Details(
    userId: json["user_id"],
    updatedAt: DateTime.parse(json["updated_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    id: json["id"],
  );

  Map<String, dynamic> toMap() => {
    "user_id": userId,
    "updated_at": updatedAt.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "id": id,
  };
}

class User {
  User({
    this.name,
    this.email,
    this.phone,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  String name;
  String email;
  String phone;
  DateTime updatedAt;
  DateTime createdAt;
  int id;

  factory User.fromMap(Map<String, dynamic> json) => User(
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    updatedAt: DateTime.parse(json["updated_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    id: json["id"],
  );

  Map<String, dynamic> toMap() => {
    "name": name,
    "email": email,
    "phone": phone,
    "updated_at": updatedAt.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "id": id,
  };
}
