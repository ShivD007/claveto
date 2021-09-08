import 'dart:math';

import 'package:claveto/categories/categories_in_clinic.dart';

import 'package:claveto/model/home_screen_model.dart';
import 'package:claveto/rest/api_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class AllSymptomsScreen extends StatefulWidget {
  final List<Symptom> allSymptoms;
  final List<Doctor> allDoctors;

  const AllSymptomsScreen({Key key, this.allSymptoms, this.allDoctors})
      : super(key: key);

  @override
  _AllSymptomsScreenState createState() => _AllSymptomsScreenState();
}

class _AllSymptomsScreenState extends State<AllSymptomsScreen> {
  List<Symptom> allSymptoms;

  @override
  void initState() {
    allSymptoms = widget.allSymptoms;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    final itemHeight = (_size.height - kToolbarHeight - 24) / 3;
    final itemWidth = _size.width / 2;

    return Scaffold(
        appBar: AppBar(
          title: Text('All Symptoms'),
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
        body: GridView.builder(
            itemCount: allSymptoms.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:
                    MediaQuery.of(context).orientation == Orientation.landscape
                        ? 4
                        : 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: (itemWidth / itemHeight)),
            itemBuilder: (context, index) {
              return Container(
                child: InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (ontext) => CategoriesInClinics(
                                categoryId: 11,
                                allDoctors: widget.allDoctors,
                                speciality: allSymptoms[index].name,
                              ))),
                  child: Card(
                      elevation: 2,
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          allSymptoms[index].icon != null
                              ? Flexible(
                                  flex: 3,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      color: Colors
                                          .primaries[Random()
                                              .nextInt(Colors.primaries.length)]
                                          .shade200,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: FadeInImage.assetNetwork(
                                        width: itemHeight,
                                        // height: itemHeight * .7,
                                        placeholder: "assets/appLogo.png",
                                        image: 
                                            allSymptoms[index].icon,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                )
                              : Image.asset("assets/appLogo.png"),
                          Flexible(
                            flex: 1,
                            child: Container(
                              alignment: Alignment.center,
                              // height: itemHeight * .15,
                              // padding: EdgeInsets.all(5),
                              child: Text(allSymptoms[index].name,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.montserrat(
                                      textStyle: TextStyle(
                                          fontSize: itemWidth * .06,
                                          fontWeight: FontWeight.w500))),
                            ),
                          ),
                          // Container(padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                          //     decoration: BoxDecoration(
                          //         borderRadius: BorderRadius.circular(10),
                          //         color: Colors.lightBlueAccent.withOpacity(0.9)
                          //     ),
                          //
                          //     child: Text('Consult Now',style: TextStyle(color: Colors.white,fontSize: 10),)),
                          // Container(
                          //   child: Text('Consult Now',
                          //       style: GoogleFonts.montserrat(
                          //           textStyle: TextStyle(fontSize: 15),
                          //           color: Colors.blue)),
                          // )
                        ],
                      )),
                ),
              );
            })

        // ListView.builder(
        //   itemCount: allSymptoms.length,
        //   itemBuilder: (_, index) {
        //     return Container(

        //       width: MediaQuery
        //           .of(context)
        //           .size
        //           .width * 0.41,
        //       height: MediaQuery
        //           .of(context)
        //           .size
        //           .height * 0.41,
        //       child: Card(
        //           elevation: 2,
        //           child: Column(
        //             mainAxisAlignment: MainAxisAlignment
        //               .start,
        //             children: [
        //               allSymptoms[index].icon != null
        //                   ? Container(width: MediaQuery
        //                   .of(context)
        //                   .size
        //                   .width,
        //                 decoration: BoxDecoration(
        //                   color: Colors.grey.withOpacity(0.3),
        //                   borderRadius: BorderRadius.circular(5),),
        //                 child: ClipRRect(
        //                   borderRadius: BorderRadius.circular(5),
        //                   child: FadeInImage.assetNetwork(
        //                     width: 60,
        //                     height: MediaQuery
        //                         .of(context)
        //                         .size
        //                         .height * 0.3,
        //                     placeholder: "assets/appLogo.png",
        //                     image: IMAGE_URL +
        //                         "icons/" +
        //                         allSymptoms[index].icon,
        //                     fit: BoxFit.cover,
        //                   ),
        //                 ),
        //               )
        //                   : Image.asset("assets/appLogo.png"),
        //               Container(
        //                 padding: EdgeInsets.all(5),
        //                 child: Text(allSymptoms[index].name,
        //                     style: GoogleFonts.montserrat(
        //                         textStyle:
        //                         TextStyle(fontSize: 15))),
        //               ),
        //               // Container(padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
        //               //     decoration: BoxDecoration(
        //               //         borderRadius: BorderRadius.circular(10),
        //               //         color: Colors.lightBlueAccent.withOpacity(0.9)
        //               //     ),
        //               //
        //               //     child: Text('Consult Now',style: TextStyle(color: Colors.white,fontSize: 10),)),
        //               // Container(
        //               //   child: Text('Consult Now',
        //               //       style: GoogleFonts.montserrat(
        //               //           textStyle: TextStyle(fontSize: 15),
        //               //           color: Colors.blue)),
        //               // )
        //             ],
        //           )),
        //     );
        //   },
        // ),
        );
  }
}
