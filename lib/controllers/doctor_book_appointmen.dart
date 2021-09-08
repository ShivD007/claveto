import 'dart:convert';
import 'dart:io';

import 'package:claveto/models/appointement/doctor_appointement_detail.dart';
import 'package:claveto/rest/api_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class BookDoctorAppointementController extends GetxController {
  @override
  void onInit() {
    // called immediately after the widget is allocated memory
    //fetchDoctorAppointementDetails(3.toString());
    super.onInit();
  }

  @override
  void onReady() {
    // called after the widget is rendered on screen

    super.onReady();
  }

  @override
  void onClose() {
    // called just before the Controller is deleted from memory

    super.onClose();
  }

  void fetchData() {}

  Future<String> fetchDoctorAppointementDetails(
      String doctorID) async {
    try {
      final response = await http.get(
        BASE_URL + getDoctorAppointment(doctorID.toString()),
        headers: requestHeaders,
      );

      print('Response ${response.body}');

      if (response.statusCode == 200) {
        DoctorBookAppointmentResponse doctorBookAppointmentResponse =
            DoctorBookAppointmentResponse.fromJson(jsonDecode(response.body));
        print('Fetched ${doctorBookAppointmentResponse.toJson()}');

        return response.body;//doctorBookAppointmentResponse;
      } else {
        print('Error while getting data');
        Get.rawSnackbar(
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.white,
            messageText: Text("Error while getting data",
                style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                        color: Colors.black.withOpacity(0.5), fontSize: 17))),
            padding: EdgeInsets.all(20),
            borderRadius: 10,
            margin: EdgeInsets.all(15));
        throw Exception('Error while getting data');
      }
    } on SocketException catch (e) {
      Get.rawSnackbar(
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          messageText: Text("Check Internet Connection",
              style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                      color: Colors.black.withOpacity(0.5), fontSize: 17))),
          padding: EdgeInsets.all(20),
          borderRadius: 10,
          margin: EdgeInsets.all(15));
    } catch (e) {
      Get.rawSnackbar(
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          messageText: Text("${e.toString()}",
              style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                      color: Colors.black.withOpacity(0.5), fontSize: 17))),
          padding: EdgeInsets.all(20),
          borderRadius: 10,
          margin: EdgeInsets.all(15));
      throw Exception('${e.toString()}');
    }
  }

  Map<String, String> requestHeaders = {
    // 'Content-Type' : 'application/json',
    'Authorization': 'Bearer $token',
  };
}
