import 'dart:ui';

import 'package:claveto/book_appointment.dart';
import 'package:claveto/model/home_screen_model.dart';
import 'package:claveto/rest/api_services.dart';
import 'package:claveto/reviews/reviews.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutDoctors extends StatefulWidget {
  final Doctor doctorDetail;

  AboutDoctors({this.doctorDetail});

  @override
  _AboutDoctorsState createState() => _AboutDoctorsState();
}

class _AboutDoctorsState extends State<AboutDoctors> {
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: _size.width,
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
            child: SafeArea(
              child: Column(
                children: [
                  // SizedBox(
                  //   height: kToolbarHeight - 24,
                  // ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pop(context, false);
                        }),
                  ),
                  Material(
                    elevation: 2,
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(99),
                    child: CircleAvatar(
                      radius: _size.height * .1,
                      backgroundColor: Colors.white,
                      backgroundImage: widget.doctorDetail?.avatar != null
                          ? NetworkImage(IMAGE_URL +
                              AVTAR_DOCTOR +
                              widget.doctorDetail?.avatar)
                          : NetworkImage(''),
                    ),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: _size.width * .055)),
                          children: [
                            TextSpan(
                                text: widget.doctorDetail.doctorDetailsNew
                                            .middleName ==
                                        null
                                    ? ''
                                    : widget.doctorDetail.doctorDetailsNew
                                            .middleName +
                                        ' ',
                                children: [
                                  TextSpan(
                                    text: widget.doctorDetail.doctorDetailsNew
                                                .lastName ==
                                            null
                                        ? ' '
                                        : widget.doctorDetail.doctorDetailsNew
                                            .lastName,
                                  )
                                ])
                          ],
                          text: widget.doctorDetail.doctorDetailsNew
                                      .firstName ==
                                  null
                              ? ' '
                              : widget.doctorDetail.doctorDetailsNew.firstName +
                                  ' ',
                        )),
                  ),
                  if (widget.doctorDetail.doctorDetailsNew.speciality != null)
                    Text(
                      widget.doctorDetail.doctorDetailsNew.speciality,
                      style: TextStyle(
                          color: Colors.white, fontSize: _size.width * .050),
                    ),
                  SizedBox(
                    height: 4,
                  ),
                  if (widget.doctorDetail.doctorDetailsNew.address != null)
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          WidgetSpan(
                              child: Icon(
                            Icons.room,
                            color: Colors.white,
                            size: 16,
                          )),
                          TextSpan(text: " "),
                          TextSpan(
                            text: widget.doctorDetail.doctorDetailsNew.address,
                            style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: _size.width * .035)),
                          ),
                        ],
                      ),
                    ),
                  SizedBox(
                    height: 7,
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Material(
              elevation: 3,
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              child: Container(
                padding: EdgeInsets.all(15),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Gender: ",
                          style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                  color:
                                      Colors.lightBlueAccent.withOpacity(0.7),
                                  fontSize: _size.width * .050)),
                        ),
                        Container(
                          width: _size.width * .45,
                          child: Text(
                            widget.doctorDetail.doctorDetailsNew.gender[0]
                                    .toUpperCase() +
                                widget.doctorDetail.doctorDetailsNew.gender
                                    .substring(1),
                            style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: _size.width * .045)),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Address: ",
                          style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                  color:
                                      Colors.lightBlueAccent.withOpacity(0.7),
                                  fontSize: _size.width * .050)),
                        ),
                        Container(
                          width: _size.width * .45,
                          child: Text(
                            widget.doctorDetail.doctorDetailsNew.address,
                            maxLines: 2,
                            // overflow: TextOverflow.ell,
                            style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: _size.width * .045)),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "State: ",
                          style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                  color:
                                      Colors.lightBlueAccent.withOpacity(0.7),
                                  fontSize: _size.width * .050)),
                        ),
                        Container(
                          width: _size.width * .45,
                          child: Text(
                            widget.doctorDetail.doctorDetailsNew.state,
                            style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: _size.width * .045)),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "City: ",
                          style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                  color:
                                      Colors.lightBlueAccent.withOpacity(0.7),
                                  fontSize: _size.width * .050)),
                        ),
                        Container(
                          width: _size.width * .45,
                          child: Text(
                            widget.doctorDetail.doctorDetailsNew.city,
                            style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: _size.width * .045)),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Pin code: ",
                          style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                  color:
                                      Colors.lightBlueAccent.withOpacity(0.7),
                                  fontSize: _size.width * .050)),
                        ),
                        Container(
                          width: _size.width * .45,
                          child: Text(
                            widget.doctorDetail.doctorDetailsNew.pincode,
                            style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: _size.width * .045)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 22, vertical: 4),
              child: Text(
                "About",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
            alignment: Alignment.centerLeft,
          ),
          if (widget.doctorDetail.doctorDetailsNew.description != null)
            Align(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 22, vertical: 4),
                child: Text(widget.doctorDetail.doctorDetailsNew.description),
              ),
              alignment: Alignment.centerLeft,
            ),
          SizedBox(
            height: 35,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.4,
              margin: EdgeInsets.symmetric(horizontal: 0, vertical: 15),
              padding: EdgeInsets.symmetric(horizontal: 2, vertical: 5),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.topRight,
                    colors: [
                      Color(0xff14B4A5),
                      Color(0xff3883EF),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(590)),
              child: MaterialButton(
                  child: Text(
                    'Book Appointment',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                        textStyle:
                            TextStyle(color: Colors.white, fontSize: 13)),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BookAppointment(
                                doctorDetails: widget.doctorDetail,
                              )),
                    );
                  }),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.4,
            margin: EdgeInsets.symmetric(horizontal: 0, vertical: 15),
            padding: EdgeInsets.symmetric(horizontal: 2, vertical: 5),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
                  colors: [
                    Color(0xff14B4A5),
                    Color(0xff3883EF),
                  ],
                ),
                borderRadius: BorderRadius.circular(590)),
            child: MaterialButton(
              child: Text(
                'See Reviews',
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                    textStyle: TextStyle(color: Colors.white, fontSize: 13)),
              ),
              onPressed: () {
                Route route = MaterialPageRoute(
                    builder: (_) => ReviewsScreen(
                          id: widget.doctorDetail.id.toString(),
                        ));
                Navigator.push(context, route);
              },
            ),
          ),
        ],
      ),
    ));
  }
}
