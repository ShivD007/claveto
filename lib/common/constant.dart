import 'package:claveto/common/pref.dart';
import 'package:flutter/material.dart';

const int selectTeamDropDownPosition = 0;

getPrefValue(String key) {
  return Pref.getString(key, "");
}

setList(String key, List<String> list) {
  Pref.setStringList(key, list);
}

getList(String key) {
  return Pref.getStringList(key);
}

//setDateList(String key,List<DateTime> dateList){
//  Pref.setStringList(key, dateList);
//}

getDateList(String key) {
  return Pref.getStringList(key);
}

String getToken(String key) {
  return "Bearer " + Pref.getString(key, "");
}

setPrefValue(key, value) {
  Pref.setString(key, value);
}

clearAllPrefs() {
  Pref.clear();
}

String checkBlank(String s) {
  String data;
  s != null
      ? s != ""
          ? data = s
          : data = ""
      : data = "";
  return data;
}

// Fateh Singh

class Constants {
  static const imagesFolder = 'assets/';

  static const numOfImagesHead = 16;

  static const numOfImagesTorso = 16;

  static const numOfImagesLeftArm = 9;

  static const numOfImagesRightArm = 9;

  static const numOfImagesLegs = 16;

  static const numOfImagesFullBody = 16;

  static const imagesFolderHead = 'head/';

  static const imagesFolderTorso = 'torso/';

  static const imagesFolderLeftArm = 'left_arm/';

  static const imagesFolderRightArm = 'right_arm/';

  static const imagesFolderLegs = 'legs/';

  static const imagesFolderFullBody = 'full_body/';
}
