// import 'package:flutter/material.dart';
//
// class SearchCard extends StatelessWidget {
//   final String FirstName;
//   final String Address;
//   final String Gender;
//   final String PinCode;
//
//   const SearchCard({Key key, this.Name,this.Address,this.Gender,this.PinCode}) : super(key: key);
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Container(
//         padding: EdgeInsets.all(15),margin: EdgeInsets.all(15),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(15),
//           gradient: LinearGradient(
//             begin: Alignment.centerLeft,
//             end: Alignment.centerRight,
//             colors: [
//               Color(0xff14B4A5).withOpacity(0.6),
//               Color(0xff3883EF).withOpacity(0.6),
//             ],
//           ),
//         ),
//         child:  Row(crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(width: 130,
//                 child: ClipRRect(
//                     borderRadius: BorderRadius.circular(15),
//                     child: Image.network('https://doctoryouneed.org/wp-content/uploads/2020/05/dr-new-demo-image-64.png'))),
//             Container(margin: EdgeInsets.symmetric(horizontal: 9,vertical: 15),
//               child: Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Row(
//                     children: [
//                       Text('Name: ',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
//                       Text('$Name'+" "+'${doctor.middleName}'+" "+'${doctor.lastName}',style: TextStyle(color: Colors.white),),
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
//       ),
//     );
//   }
// }
