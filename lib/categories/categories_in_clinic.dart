import 'package:claveto/all_user_types/all_doctors.dart';
import 'package:claveto/model/home_screen_model.dart';
import 'package:flutter/material.dart';

import '../aboutdoctors.dart';

class CategoriesInClinics extends StatefulWidget {
  final int categoryId;
  final speciality;
  final List<Doctor> allDoctors;
  const CategoriesInClinics(
      {Key key, this.categoryId, this.allDoctors, this.speciality})
      : super(key: key);
  @override
  _CategoriesInClinicsState createState() => _CategoriesInClinicsState();
}

class _CategoriesInClinicsState extends State<CategoriesInClinics> {
  //Todo change UI zeyan
  List<Doctor> doctorsInClinics = [], allDoctors;
  int categoryId;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    doctorsInClinics = [];
    allDoctors = widget.allDoctors;
    categoryId = widget.categoryId;
    print('Category Id: $categoryId');

    sortDoctors();
  }

  void sortDoctors() {
    for (var doctor in allDoctors) {
      print(
          'Doctor Category Id ${doctor.doctorDetailsNew.catagoryId}  matching with $categoryId');
      if (doctor.doctorDetailsNew.catagoryId == categoryId) {
        doctorsInClinics.add(doctor);
      }
      print('Length of list is ${doctorsInClinics.length}');
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
          title: Text(widget.speciality.toString()),
        ),
        body: doctorsInClinics.isEmpty
            ? Center(
                child: Text('No doctor'),
              )
            : ListView.builder(
                padding: EdgeInsets.only(top: 10),
                itemCount: doctorsInClinics.length,
                itemBuilder: (_, index) {
                  print('Index $index');
                  Doctor doctor = doctorsInClinics[index];
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
                      child: horizontalDoctorCard(doctor, context)
                      // Expanded(
                      //   child: Container(
                      //     padding: EdgeInsets.all(15),margin: EdgeInsets.all(15),
                      //     decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(15),
                      //       gradient: LinearGradient(
                      //         begin: Alignment.centerLeft,
                      //         end: Alignment.centerRight,
                      //         colors: [
                      //           Color(0xff14B4A5).withOpacity(0.5),
                      //           Color(0xff3883EF).withOpacity(0.5),
                      //         ],
                      //       ),
                      //     ),
                      //     child:  Column(crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
                      //         Container(
                      //             margin: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                      //             child: Text('Doctor\'s ',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),)),
                      //         Row(crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: [
                      //             Container(width: 130,
                      //                 child: ClipRRect(
                      //                     borderRadius: BorderRadius.circular(15),
                      //                     child: Image.network('https://doctoryouneed.org/wp-content/uploads/2020/05/dr-new-demo-image-64.png'))),
                      //             Container(margin: EdgeInsets.symmetric(horizontal: 9,vertical: 0),
                      //               child: Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //                 children: [
                      //                   Row(
                      //                     children: [
                      //                       Text('Name: ',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                      //                       Text('${doctor.firstName}'+" "+'${doctor.middleName}'+" "+'${doctor.lastName}',style: TextStyle(color: Colors.white),),
                      //                     ],
                      //                   ),
                      //                   Row(
                      //                     children: [
                      //                       Text('Gender: ',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                      //                       Text('${doctor.gender}',style: TextStyle(color: Colors.white,),)
                      //                     ],
                      //                   ),
                      //                   Row(
                      //                     children: [
                      //                       Text('Address: ',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                      //                       Text('${doctor.address}',style: TextStyle(color: Colors.white,),)
                      //                     ],
                      //                   ),
                      //                   Row(
                      //                     children: [
                      //                       Text('DOB: ',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                      //                       Text('${doctor.dob}',style: TextStyle(color: Colors.white,),)
                      //                     ],
                      //                   ),
                      //                   Row(
                      //                     children: [
                      //                       Text('PinCode: ',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                      //                       Text('${doctor.pincode}',style: TextStyle(color: Colors.white,),)
                      //                     ],
                      //                   ),
                      //
                      //                 ],
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      );
                },
              ),
      ),
    );
  }
}
