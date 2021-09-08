// To parse this JSON data, do
//
//     final signInModel = signInModelFromMap(jsonString);

import 'dart:convert';

SignInModel signInModelFromMap(String str) => SignInModel.fromMap(json.decode(str));

String signInModelToMap(SignInModel data) => json.encode(data.toMap());

class SignInModel {
  SignInModel({
    this.user,
    this.details,
    this.accessToken,
  });

  User user;
  Details details;
  String accessToken;

  factory SignInModel.fromMap(Map<String, dynamic> json) => SignInModel(
    user: User.fromMap(json["user"]),
    details: json["details"] != null ? Details.fromMap(json["details"]): null,
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
    this.id,
    this.userId,
    this.firstName,
    this.middleName,
    this.lastName,
    this.dob,
    this.gender,
    this.address,
    this.state,
    this.city,
    this.pincode,
    this.createdAt,
    this.updatedAt,
    this.bloodGroup,
  });

  int id;
  int userId;
  String firstName;
  String middleName;
  String lastName;
  DateTime dob;
  String gender;
  String address;
  String state;
  String city;
  String pincode;
  dynamic createdAt;
  DateTime updatedAt;
  String bloodGroup;

  factory Details.fromMap(Map<String, dynamic> json) => Details(
    id: json["id"],
    userId: json["user_id"],
    firstName: json["first_name"],
    middleName: json["middle_name"],
    lastName: json["last_name"],

    dob: json["dob"]==null?null:DateTime.parse(json["dob"]),
    gender: json["gender"],
    address: json["address"],
    state: json["state"],
    city: json["city"],
    pincode: json["pincode"],
    createdAt: json["created_at"],
    updatedAt: DateTime.parse(json["updated_at"]),
    bloodGroup: json["blood_group"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "user_id": userId,
    "first_name": firstName,
    "middle_name": middleName,
    "last_name": lastName,
    "dob": "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
    "gender": gender,
    "address": address,
    "state": state,
    "city": city,
    "pincode": pincode,
    "created_at": createdAt,
    "updated_at": updatedAt.toIso8601String(),
    "blood_group": bloodGroup,
  };
}

class User {
  User({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.emailVerifiedAt,
    this.avatar,
    this.isAdmin,
    this.userType,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String name;
  String email;
  String phone;
  dynamic emailVerifiedAt;
  String avatar;
  int isAdmin;
  String userType;
  int isActive;
  dynamic createdAt;
  DateTime updatedAt;

  factory User.fromMap(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    emailVerifiedAt: json["email_verified_at"],
    avatar: json["avatar"],
    isAdmin: json["is_admin"],
    userType: json["user_type"],
    isActive: json["is_active"],
    createdAt: json["created_at"],
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "email_verified_at": emailVerifiedAt,
    "avatar": avatar,
    "is_admin": isAdmin,
    "user_type": userType,
    "is_active": isActive,
    "created_at": createdAt,
    "updated_at": updatedAt.toIso8601String(),
  };
}
