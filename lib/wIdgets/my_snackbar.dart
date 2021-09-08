import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


showSnackBar({String message}){
  Get.rawSnackbar(
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.white,
      backgroundGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xff3883EF),
          Color(0xff14B4A5),
        ],
      ),
      messageText: Text(
          message,
          style: GoogleFonts.montserrat(
              textStyle: TextStyle(
                  color: Colors.black
                      .withOpacity(0.5),
                  fontSize: 17))),
      padding: EdgeInsets.all(20),
      borderRadius: 10,
      margin: EdgeInsets.all(15));
}