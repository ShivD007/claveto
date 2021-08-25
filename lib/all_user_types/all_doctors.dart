import 'package:claveto/model/home_screen_model.dart';
import 'package:claveto/rest/api_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../aboutdoctors.dart';

class AllDoctorsScreen extends StatefulWidget {
  final List<Doctor> allDoctors;

  const AllDoctorsScreen({Key key, this.allDoctors}) : super(key: key);

  @override
  _AllDoctorsScreenState createState() => _AllDoctorsScreenState();
}

class _AllDoctorsScreenState extends State<AllDoctorsScreen> {
  List<Doctor> doctors;

  @override
  void initState() {
    doctors = widget.allDoctors;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        title: Text('All Doctors'),
      ),
      body: ListView.builder(
        itemCount: doctors.length,
        itemBuilder: (_, index) {
          return horizontalDoctorCard(doctors[index], context);
        },
      ),
    );
  }
}

Widget horizontalDoctorCard(Doctor doctor, BuildContext context,
    {bool isSearch = false}) {
  var _size = MediaQuery.of(context).size;
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AboutDoctors(
                  doctorDetail: doctor,
                )),
      );
    },
    child: Container(
      margin: EdgeInsets.all(15),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color(0xff14B4A5).withOpacity(0.5),
                Color(0xff3883EF).withOpacity(0.5),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              isSearch
                  ? Container(
                      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      child: Text(
                        doctor.doctorDetailsNew.speciality ?? 'Doctor\'s ',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ))
                  : SizedBox(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Material(
                    elevation: 2,
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(99),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      backgroundImage: doctor.avatar != null
                          ? NetworkImage(
                              IMAGE_URL + AVTAR_DOCTOR + doctor.avatar)
                          : AssetImage(
                              "assets/appLogo.png",
                            ),
                    ),
                  ),
                  // Container(
                  //     width: 130,
                  //     child: ClipRRect(
                  //       child: doctor.avatar != null
                  //           ? Container(
                  //               decoration: BoxDecoration(color: Colors.white),
                  //               child: FadeInImage.assetNetwork(
                  //                 width: 60,
                  //                 height: 150,
                  //                 placeholder: "assets/appLogo.png",
                  //                 image:
                  //                     IMAGE_URL + AVTAR_DOCTOR + doctor.avatar,
                  //                 fit: BoxFit.cover,
                  //               ),
                  //             )
                  //           : Container(
                  //               decoration: BoxDecoration(color: Colors.white),
                  //               child: Image.asset(
                  //                 "assets/appLogo.png",
                  //                 height: 150,
                  //                 width: 60,
                  //               ),
                  //             ),
                  //     )),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 9, vertical: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // if (isSearch)
                        Row(
                          children: [
                            Text(
                              'Name: ',
                              style: TextStyle(
                                  fontSize: _size.width * .034,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.45,
                              child: Text(
                                '${doctor.doctorDetailsNew.firstName ?? ''}' +
                                    " " +
                                    '${doctor.doctorDetailsNew.middleName ?? ''}' +
                                    " " +
                                    '${doctor.doctorDetailsNew.lastName[0] ?? ''}.',
                                style: TextStyle(
                                  fontSize: _size.width * .034,
                                  color: Colors.white,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Gender: ',
                              style: TextStyle(
                                  fontSize: _size.width * .034,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${doctor.doctorDetailsNew.gender[0].toUpperCase() + doctor.doctorDetailsNew.gender.substring(1) ?? ''}',
                              style: TextStyle(
                                fontSize: _size.width * .034,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Address: ',
                              style: TextStyle(
                                  fontSize: _size.width * .034,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.42,
                              child: Text(
                                '${doctor.doctorDetailsNew.address ?? ''}',
                                maxLines: 4,
                                softWrap: true,
                                style: TextStyle(
                                  fontSize: _size.width * .034,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                        // if(doctor.dob!=null)Row(
                        //   children: [
                        //     Text(
                        //       'DOB: ',
                        //       style: TextStyle(
                        //           color: Colors.white,
                        //           fontWeight: FontWeight.bold),
                        //     ),
                        //
                        //     Text(
                        //       '${doctor.dob.toString().substring(0, 10)}',
                        //       style: TextStyle(
                        //         color: Colors.white,
                        //       ),
                        //     )
                        //   ],
                        // ),
                        // Row(
                        //   children: [
                        //     Text(
                        //       'PinCode: ',
                        //       style: TextStyle(
                        //           color: Colors.white,
                        //           fontWeight: FontWeight.bold),
                        //     ),
                        //     Text(
                        //       '${doctor.pincode}',
                        //       style: TextStyle(
                        //         color: Colors.white,
                        //       ),
                        //     )
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
