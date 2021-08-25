import 'package:claveto/model/home_screen_model.dart';
import 'package:claveto/rest/api_services.dart';
import 'package:claveto/reviews/reviews.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../book_appointment.dart';
import '../signup.dart';

class LabScreen extends StatefulWidget {
  final Lab lab;

  const LabScreen({Key key, this.lab}) : super(key: key);
  @override
  _LabScreenState createState() => _LabScreenState();
}

class _LabScreenState extends State<LabScreen> {
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
                    RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: GoogleFonts.montserrat(
                              textStyle:
                                  TextStyle(color: Colors.white, fontSize: 30)),
                          children: [
                            TextSpan(text: widget.lab.labDetailsNew.legalName)
                          ],
                          text: widget.lab.labDetailsNew.firstName == null
                              ? ' '
                              : widget.lab.labDetailsNew.firstName + ' ',
                        )),
                    Material(
                      elevation: 2,
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(99),
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(
                            IMAGE_URL + AVTAR_LAB + widget.lab.avatar),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                    color: Colors.white, fontSize: 30)),
                            children: [
                              TextSpan(
                                  text: widget.lab.labDetailsNew.middleName ==
                                          null
                                      ? 'Dr '
                                      : widget.lab.labDetailsNew.middleName +
                                          ' ',
                                  children: [
                                    TextSpan(
                                      text: widget.lab.labDetailsNew.lastName ==
                                              null
                                          ? ' '
                                          : widget.lab.labDetailsNew.lastName,
                                    )
                                  ])
                            ],
                            text: widget.lab.labDetailsNew.firstName == null
                                ? ' '
                                : widget.lab.labDetailsNew.firstName + ' ',
                          )),
                    ),
                    SizedBox(
                      height: 20,
                    )
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Address: ",
                            style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                    color:
                                        Colors.lightBlueAccent.withOpacity(0.7),
                                    fontSize: 20)),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * .5,
                            child: Text(
                              widget.lab.labDetailsNew.address,
                              style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      color: Colors.black, fontSize: 15)),
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
                                    fontSize: 20)),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * .5,
                            child: Text(
                              widget.lab.labDetailsNew.state ?? '',
                              style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      color: Colors.black, fontSize: 15)),
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
                                    fontSize: 20)),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * .5,
                            child: Text(
                              widget.lab.labDetailsNew.city ?? '',
                              style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      color: Colors.black, fontSize: 15)),
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
                                    fontSize: 20)),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * .5,
                            child: Text(
                              widget.lab.labDetailsNew.pincode,
                              style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      color: Colors.black, fontSize: 15)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Container(
            //   margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            //   padding: EdgeInsets.all(15),
            //   width: MediaQuery.of(context).size.width,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(15),
            //     border:
            //         Border.all(color: Colors.grey.withOpacity(0.3), width: 2),
            //   ),
            //   child: Row(
            //     children: [
            //       Icon(
            //         Icons.security,
            //         color: Colors.lightBlueAccent.withOpacity(0.5),
            //         size: 80,
            //       ),
            //       Flexible(
            //         child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             Text(
            //               "Smartech 360 diagnostic center",
            //               overflow: TextOverflow.ellipsis,
            //               style: GoogleFonts.montserrat(
            //                   textStyle:
            //                       TextStyle(color: Colors.black, fontSize: 15)),
            //             ),
            //             Text(
            //               widget.doctorDetail.,
            //               overflow: TextOverflow.ellipsis,
            //               style: GoogleFonts.montserrat(
            //                   textStyle: TextStyle(
            //                       color: Colors.black.withOpacity(0.7),
            //                       fontSize: 14)),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
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
                      style: GoogleFonts.montserrat(
                          textStyle:
                              TextStyle(color: Colors.white, fontSize: 13)),
                    ),
                    onPressed: () {
                      Route route = MaterialPageRoute(
                          builder: (_) => ReviewsScreen(
                                id: widget.lab.id.toString(),
                              ));
                      Navigator.push(context, route);
                    },
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
                                    lab: widget.lab,
                                    isLab: true,
                                  )),
                        );
                      }),
                ),
              ],
            ),

            // Container(
            //   margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            //   padding: EdgeInsets.all(15),
            //   width: MediaQuery.of(context).size.width,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(15),
            //     border:
            //         Border.all(color: Colors.grey.withOpacity(0.3), width: 2),
            //   ),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Container(
            //           margin: EdgeInsets.symmetric(vertical: 10),
            //           child: Text(
            //             "Reviews & Ratings",
            //             style: GoogleFonts.montserrat(
            //                 textStyle: TextStyle(
            //                     color: Colors.lightBlueAccent.withOpacity(0.7),
            //                     fontSize: 25)),
            //           )),
            //       Row(
            //         children: [
            //           Text(
            //             "4.7 ",
            //             style: GoogleFonts.montserrat(
            //                 textStyle: TextStyle(
            //                     color: Colors.lightBlueAccent.withOpacity(0.7),
            //                     fontSize: 25)),
            //           ),
            //           Icon(
            //             Icons.star,
            //             color: Colors.lightBlueAccent.withOpacity(0.7),
            //           ),
            //           Icon(
            //             Icons.star,
            //             color: Colors.lightBlueAccent.withOpacity(0.7),
            //           ),
            //           Icon(
            //             Icons.star,
            //             color: Colors.lightBlueAccent.withOpacity(0.7),
            //           ),
            //           Icon(
            //             Icons.star,
            //             color: Colors.lightBlueAccent.withOpacity(0.7),
            //           ),
            //           Icon(
            //             Icons.star_half,
            //             color: Colors.lightBlueAccent.withOpacity(0.7),
            //           )
            //         ],
            //       ),
            //       Text(
            //         "Samesh",
            //         style: GoogleFonts.montserrat(
            //             textStyle: TextStyle(
            //                 color: Colors.lightBlueAccent.withOpacity(0.7),
            //                 fontSize: 20)),
            //       ),
            //       Text(
            //         "Dental scpecialist dr raman have 5 years of experience indental relaed issues. He is able to solve all kind of dental problems.",
            //         style: GoogleFonts.montserrat(
            //             textStyle:
            //                 TextStyle(color: Colors.black, fontSize: 13)),
            //       ),
            //     ],
            //   ),
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
//                 Container(
//                   width: MediaQuery.of(context).size.width * 0.45,
//                   margin: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
//                   padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
//                   decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         begin: Alignment.topLeft,
//                         end: Alignment.topRight,
//                         colors: [
//                           Color(0xff14B4A5),
//                           Color(0xff3883EF),
//                         ],
//                       ),
//                       borderRadius: BorderRadius.circular(590)),
//                   child: MaterialButton(
//                       child: Text(
//                         'Consult Now',
//                         style: GoogleFonts.montserrat(
//                             textStyle:
//                                 TextStyle(color: Colors.white, fontSize: 15)),
//                       ),
//                       onPressed: () {
// //                Navigator.push(
// //                  context,
// //                  MaterialPageRoute(builder: (context) => Signup()),
// //                );
//                       }),
//                 ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
