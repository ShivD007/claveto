import 'package:claveto/common/constant.dart';
import 'package:claveto/config/config.dart';
import 'package:claveto/home.dart';
import 'package:claveto/models/my_appointments/my_appointments.dart';
import 'package:claveto/wIdgets/my_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:claveto/rest/api_services.dart';

import 'chat/chat.dart';
import 'common/keys.dart';
import 'package:claveto/book_appointment.dart';
import 'model/home_screen_model.dart';
import 'payment_success/payment_success.dart';
import 'write_review.dart';

class AppointmentsScreen extends StatefulWidget {
  @override
  _AppointmentsScreenState createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        navigateTOHomeScreen(context);
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Appointments",
            style: GoogleFonts.montserrat(
                textStyle: TextStyle(color: Colors.white, fontSize: 20)),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xff14B4A5),
                  Color(0xff3883EF),
                ],
              ),
            ),
          ),
        ),
        body: Container(
          child: FutureBuilder<MyAppointmentsModel>(
              future: getMyAppointments(),
              builder: (context, snapshot) {
                print('Called snapshot ${snapshot}');
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error while fetching blogs'),
                  );
                } else {
                  List<Appointments> myAppointments =
                      snapshot.data.appointments.toList().reversed.toList();
                  return myAppointments.length == 0
                      ? Center(
                          child: Text('No Appointments'),
                        )
                      : ListView.builder(
                          itemCount: snapshot.data.appointments.length,
                          itemBuilder: (BuildContext ctxt, int index) {
                            Appointments model = myAppointments[index];
                            Doctor doctor;
                            try {
                              doctor = cachedAllDoctors
                                  .where((element) =>
                                      element.id.toString() == model.docLabId)
                                  .toList()[0];
                            } catch (e) {
                              print('error in appointment ${e}');
                            }

                            return new Container(
                              margin: EdgeInsets.all(15),
                              child: InkWell(
                                onTap: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(builder: (context) => DetailedBlog(
                                  //     model: model,
                                  //   )),
                                  // );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Color(0xff14B4A5),
                                        Color(0xff3883EF),
                                      ],
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            alignment: Alignment.centerLeft,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            child: Text(
                                                'Name: ' + model.patientName ??
                                                    0,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15))),
                                        if (doctor != null)
                                          Container(
                                              alignment: Alignment.centerLeft,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10, vertical: 5),
                                              child: Text(
                                                  'Doctor Name: ' +
                                                      doctor.doctorDetailsNew
                                                          .firstName +
                                                      ' ' +
                                                      (doctor.doctorDetailsNew
                                                              .middleName ??
                                                          '') +
                                                      ' ' +
                                                      doctor.doctorDetailsNew
                                                          .lastName[0] +'.',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15))),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                                alignment: Alignment.centerLeft,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 5),
                                                child: Text(
                                                    'Status: ' + model.status ??
                                                        0,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 15))),
                                            Container(
                                                alignment: Alignment.centerLeft,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 5),
                                                child: Text(
                                                    'Type: ' +
                                                            model
                                                                .appointmentType ??
                                                        0,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 15))),
                                          ],
                                        ),
                                        Container(
                                            alignment: Alignment.centerLeft,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.6,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            child: Text(
                                                '${changeFormat(model.dateOfAppointment).toString()} ${model.timeOfAppointment.substring(0, 5).toString()}',
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold))),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 10,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              if (model.status
                                                  .contains('completed'))
                                                ElevatedButton(
                                                  style: ButtonStyle(
                                                      elevation:
                                                          MaterialStateProperty
                                                              .all(10),
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all(Colors.grey
                                                                  .shade400)),
                                                  child: Text('Review'),
                                                  onPressed: () {
                                                    Route route =
                                                        MaterialPageRoute(
                                                            builder: (_) =>
                                                                WriteReviewScreen(
                                                                  id: model.id
                                                                      .toString(),
                                                                ));
                                                    Navigator.push(
                                                        context, route);
                                                  },
                                                ),
                                              model.appointmentType
                                                      .contains('online')
                                                  ? InkWell(
                                                      onTap: () {
                                                        int year = int.parse(model
                                                            .dateOfAppointment
                                                            .substring(0, 4));
                                                        int month = int.parse(
                                                            model
                                                                .dateOfAppointment
                                                                .substring(
                                                                    5, 7));
                                                        int date = int.parse(model
                                                            .dateOfAppointment
                                                            .substring(8, 10));
                                                        int hour = int.parse(model
                                                            .timeOfAppointment
                                                            .substring(0, 2));
                                                        int minutes = int.parse(
                                                            model
                                                                .timeOfAppointment
                                                                .substring(
                                                                    3, 5));

                                                        DateTime dateTime =
                                                            DateTime(
                                                                    year,
                                                                    month,
                                                                    date,
                                                                    hour,
                                                                    minutes,
                                                                    0,
                                                                    0,
                                                                    0)
                                                                .subtract(
                                                                    Duration(
                                                                        minutes:
                                                                            5));

                                                        // if (dateTime.isBefore(
                                                        //     DateTime.now())
                                                        // )
                                                        print('Hy Fateh');
                                                        if (1 == 1) {
                                                          //ChatApp.sharedPreferences.clear();
                                                          if (ChatApp
                                                                  .sharedPreferences
                                                                  .getBool(
                                                                      '${model.id}x') ==
                                                              null) {
                                                            ChatApp
                                                                .sharedPreferences
                                                                .setBool(
                                                                    '${model.id}x',
                                                                    true);
                                                          } else {
                                                            ChatApp
                                                                .sharedPreferences
                                                                .setBool(
                                                                    '${model.id}x',
                                                                    false);
                                                          }

                                                          Route route =
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (_) =>
                                                                          Chat(
                                                                            userID:
                                                                                model.userId.toString(),
                                                                            // patientName: model
                                                                            //     .patientName,
                                                                            patientName:
                                                                                getPrefValue(Keys.NAME),
                                                                            id: model.id.toString(),
                                                                            peerId:
                                                                                model.docLabId.toString(),
                                                                          ));
                                                          Navigator.push(
                                                              context, route);
                                                        } else {
                                                          showSnackBar(
                                                              message:
                                                                  'You cannot open now');
                                                        }
                                                      },
                                                      child: Align(
                                                        alignment:
                                                            Alignment.topRight,
                                                        child: Container(
                                                          child:
                                                              ElevatedButton.icon(
                                                            label: Text(
                                                              'Chat',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            icon: Icon(
                                                              Icons.chat,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            onPressed: () {
                                                              int year = int
                                                                  .parse(model
                                                                      .dateOfAppointment
                                                                      .substring(
                                                                          0,
                                                                          4));
                                                              int month = int
                                                                  .parse(model
                                                                      .dateOfAppointment
                                                                      .substring(
                                                                          5,
                                                                          7));
                                                              int date = int
                                                                  .parse(model
                                                                      .dateOfAppointment
                                                                      .substring(
                                                                          8,
                                                                          10));
                                                              int hour = int
                                                                  .parse(model
                                                                      .timeOfAppointment
                                                                      .substring(
                                                                          0,
                                                                          2));
                                                              int minutes = int
                                                                  .parse(model
                                                                      .timeOfAppointment
                                                                      .substring(
                                                                          3,
                                                                          5));

                                                              DateTime dateTime = DateTime(
                                                                      year,
                                                                      month,
                                                                      date,
                                                                      hour,
                                                                      minutes,
                                                                      0,
                                                                      0,
                                                                      0)
                                                                  .subtract(
                                                                      Duration(
                                                                          minutes:
                                                                              5));

                                                              if (dateTime.isBefore(
                                                                  DateTime
                                                                      .now())) {
                                                                //ChatApp.sharedPreferences.clear();
                                                                if (ChatApp
                                                                        .sharedPreferences
                                                                        .getBool(
                                                                            '${model.id}x') ==
                                                                    null) {
                                                                  ChatApp
                                                                      .sharedPreferences
                                                                      .setBool(
                                                                          '${model.id}x',
                                                                          true);
                                                                } else {
                                                                  ChatApp
                                                                      .sharedPreferences
                                                                      .setBool(
                                                                          '${model.id}x',
                                                                          false);
                                                                }

                                                                Route route =
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (_) {
                                                                  return Chat(
                                                                    userID: model
                                                                        .userId
                                                                        .toString(),
                                                                    phone: model
                                                                        .phoneNumber,
                                                                    isCompleted: model
                                                                        .status
                                                                        .contains(
                                                                            'completed'),
                                                                    // patientName: model
                                                                    //     .patientName,
                                                                    doctorName: doctor !=
                                                                            null
                                                                        ? " Dr. ${doctor.doctorDetailsNew.firstName} ${doctor.doctorDetailsNew.lastName[0]}."
                                                                        : "Doctor",
                                                                    patientName:
                                                                        getPrefValue(
                                                                            Keys.NAME),
                                                                    id: model.id
                                                                        .toString(),
                                                                    peerId: model
                                                                        .docLabId
                                                                        .toString(),
                                                                  );
                                                                });
                                                                Navigator.push(
                                                                    context,
                                                                    route);
                                                              } else {
                                                                showSnackBar(
                                                                    message:
                                                                        'You cannot open now');
                                                              }
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  : Container(),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          });
                }
              }),
        ),
      ),
    );
  }
}
