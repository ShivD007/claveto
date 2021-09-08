// import 'package:claveto/clinics/doctors_in_clinics.dart';

// import 'package:claveto/model/home_screen_model.dart';
// import 'package:claveto/rest/api_services.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';



// class AllClinicsScreen extends StatefulWidget {
//   final List<Clinic> allClinics;
//   final List<Doctor> allDoctors;

//   const AllClinicsScreen({Key key, this.allClinics, this.allDoctors})
//       : super(key: key);

//   @override
//   _AllClinicsScreenState createState() => _AllClinicsScreenState();
// }

// class _AllClinicsScreenState extends State<AllClinicsScreen> {
//   List<Clinic> allClinics;

//   @override
//   void initState() {
//     allClinics = widget.allClinics;
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         flexibleSpace: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               colors: [

//                 Color(0xff14B4A5),
//                 Color(0xff3883EF),
//               ],
//             ),
//           ),
//         ),
//         title: Text('All Clinics'),
//       ),
//       body: ListView.builder(
//         itemCount: allClinics.length,
//         itemBuilder: (_, index) {
//           return horizontalClinicCard(
//               allClinics[index], context, widget.allDoctors);
//         },
//       ),
//     );
//   }
// }

// Widget horizontalClinicCard(
//     Clinic clinic, BuildContext context, List<Doctor> allDoctors,
//     {bool isSearch = false}) {
//   // todo zeyan change the ui and use values from doctor model

//   return InkWell(
//     onTap: () {
//       Navigator.push(
//           context,
//           MaterialPageRoute(
//               builder: (context) => DoctorsInClinics(
//                     clinicId: clinic.clinicDetailsNew.id,
//                     allDoctors: allDoctors,
//                   )));
//     },
//     child: Container(
//       margin: EdgeInsets.all(15),
//       child: Material(
//         elevation: 5,
//         borderRadius: BorderRadius.circular(15),
//         child: Container(
//           padding: EdgeInsets.all(15),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(15),
//             gradient: LinearGradient(
//               begin: Alignment.centerLeft,
//               end: Alignment.centerRight,
//               colors: [
//                 Color(0xff14B4A5).withOpacity(0.5),
//                 Color(0xff3883EF).withOpacity(0.5),
//               ],
//             ),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               isSearch
//                   ? Container(
//                       margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
//                       child: Text(
//                         'Clinic\'s ',
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 20),
//                       ))
//                   : Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 10),
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             'Clinic Name: ',
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 20),
//                           ),
//                           Expanded(
//                             child: Text(
//                               '${clinic.clinicDetailsNew.legalName ?? ''}',
//                               style: TextStyle(
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 20),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                       width: 130,
//                       child: ClipRRect(
//                           borderRadius: BorderRadius.circular(15),
//                           child: Container(
//                             color: Colors.white,
//                             child: clinic.avatar != null
//                                 ? Container(
//                                     decoration:
//                                         BoxDecoration(color: Colors.white),
//                                     child: FadeInImage.assetNetwork(
//                                       width: 60,
//                                       height: 150,
//                                       placeholder: "assets/appLogo.png",
//                                       image: IMAGE_URL +
//                                           AVTAR_CLINIC +
//                                           clinic.avatar,
//                                       fit: BoxFit.cover,
//                                     ),
//                                   )
//                                 : Container(
//                                     decoration:
//                                         BoxDecoration(color: Colors.white),
//                                     child: Image.asset(
//                                       "assets/appLogo.png",
//                                       height: 150,
//                                       width: 60,
//                                     ),
//                                   ),
//                           ))),
//                   Flexible(
//                     child: Container(
//                       margin: EdgeInsets.symmetric(horizontal: 9, vertical: 0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           if (isSearch)
//                             Row(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'Hospital Name: ',
//                                   style: TextStyle(
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                                 Expanded(
//                                     child: Text(
//                                   '${clinic.clinicDetailsNew.legalName ?? ''}',
//                                   style: TextStyle(color: Colors.white),
//                                 )),
//                               ],
//                             ),
//                           Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'Address: ',
//                                 overflow: TextOverflow.ellipsis,
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                               Expanded(
//                                   child: Text(
//                                 '${clinic.clinicDetailsNew.address}',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                 ),
//                               ))
//                             ],
//                           ),
//                           Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'City: ',
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                               Expanded(
//                                   child: Text(
//                                 '${clinic.clinicDetailsNew.city??''}',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                 ),
//                               ))
//                             ],
//                           ),
//                           Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'State: ',
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                               Text(
//                                 '${clinic.clinicDetailsNew.state??''}',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                 ),
//                               )
//                             ],
//                           ),
//                           Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'PinCode: ',
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                               Text(
//                                 '${clinic.clinicDetailsNew.pincode}',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                 ),
//                               )
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     ),
//   );
// }
