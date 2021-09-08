// To parse this JSON data, do
//
//     final getFamilyMember = getFamilyMemberFromMap(jsonString);

import 'dart:convert';

GetFamilyMember getFamilyMemberFromMap(String str) => GetFamilyMember.fromMap(json.decode(str));

String getFamilyMemberToMap(GetFamilyMember data) => json.encode(data.toMap());

class GetFamilyMember {
  GetFamilyMember({
    this.familyMembers,
  });

  List<FamilyMember> familyMembers;

  factory GetFamilyMember.fromMap(Map<String, dynamic> json) => GetFamilyMember(
    familyMembers: List<FamilyMember>.from(json["family_members"].map((x) => FamilyMember.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "family_members": List<dynamic>.from(familyMembers.map((x) => x.toMap())),
  };
}

class FamilyMember {
  FamilyMember({
    this.id,
    this.userDetailsId,
    this.firstName,
    this.middleName,
    this.lastName,
    this.image,
    this.dob,
    this.gender,
    this.relationship,
    this.createdAt,
    this.updatedAt,
    this.bloodGroup,
  });

  int id;
  int userDetailsId;
  String firstName;
  String middleName;
  String lastName;
  String image;
  DateTime dob;
  String gender;
  String relationship;
  DateTime createdAt;
  DateTime updatedAt;
  String bloodGroup;

  factory FamilyMember.fromMap(Map<String, dynamic> json) => FamilyMember(
    id: json["id"],
    userDetailsId: json["user_details_id"],
    firstName: json["first_name"],
    middleName: json["middle_name"],
    lastName: json["last_name"],
    image: json["image"],
    dob: DateTime.parse(json["dob"]),
    gender: json["gender"],
    relationship: json["relationship"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    bloodGroup: json["blood_group"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "user_details_id": userDetailsId,
    "first_name": firstName,
    "middle_name": middleName,
    "last_name": lastName,
    "image": image,
    "dob": "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
    "gender": gender,
    "relationship": relationship,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "blood_group": bloodGroup,
  };
}
