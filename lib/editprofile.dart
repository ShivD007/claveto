import 'dart:convert';

import 'package:claveto/common/constant.dart';
import 'package:claveto/common/keys.dart';
import 'package:claveto/home.dart';
import 'package:claveto/model/edit_profile_model.dart';
import 'package:claveto/rest/api_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  DateTime selectedDate; //= DateTime.now();
  final oldPassController = TextEditingController();
  final newPassController = TextEditingController();

  var nameController = TextEditingController();
  var nameFirstController = TextEditingController();
  var nameMiddleController = TextEditingController();
  var nameLastController = TextEditingController();

  var dobController = TextEditingController();
  var genderController = TextEditingController();
  var mobileController = TextEditingController();
  var emailController = TextEditingController();
  var addressController = TextEditingController();
  var addressCityController = TextEditingController();
  var addressStateController = TextEditingController();
  var addressPincodeController = TextEditingController();
  var bloodgroupController = TextEditingController();
  String pickedGenders;
  String pickedBloodGroup;
  String pickedGender;

  var image;

  validateInputs(o, n) {
    if (GetUtils.isNullOrBlank(o)) {
      Get.rawSnackbar(
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          messageText: Text("Old Password Can't be empty",
              style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                      color: Colors.black.withOpacity(0.5), fontSize: 17))),
          padding: EdgeInsets.all(20),
          borderRadius: 10,
          margin: EdgeInsets.all(15));
    } else if (GetUtils.isNullOrBlank(n)) {
      Get.rawSnackbar(
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          messageText: Text("NewPassword Can't be empty",
              style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                      color: Colors.black.withOpacity(0.5), fontSize: 17))),
          padding: EdgeInsets.all(20),
          borderRadius: 10,
          margin: EdgeInsets.all(15));
    } else {
      changePasswordAPI(o, n).then((value) {});
    }
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController = TextEditingController(text: getPrefValue(Keys.NAME));
    dobController = TextEditingController(text: getPrefValue(Keys.DOB));
    nameFirstController =
        TextEditingController(text: getPrefValue(Keys.FIRST_NAME));
    nameMiddleController =
        TextEditingController(text: getPrefValue(Keys.MIDDLE_NAME) ?? '');
    nameLastController =
        TextEditingController(text: getPrefValue(Keys.LAST_NAME));
    pickedGender = getPrefValue(Keys.GENDER).toString() == null
        ? "Male"
        : getPrefValue(Keys.GENDER).toString();

    genderController = TextEditingController(text: getPrefValue(Keys.GENDER));
    mobileController = TextEditingController(text: getPrefValue(Keys.PHONE));
    emailController = TextEditingController(text: getPrefValue(Keys.EMAIL));
    addressController = TextEditingController(text: getPrefValue(Keys.ADDRESS));
    addressCityController =
        TextEditingController(text: getPrefValue(Keys.CITY));
    addressStateController =
        TextEditingController(text: getPrefValue(Keys.STATE));
    addressPincodeController =
        TextEditingController(text: getPrefValue(Keys.PINCODE));
    pickedBloodGroup = getPrefValue(Keys.BLOOD_GROUP) ?? 'A positive';
    bloodgroupController =
        TextEditingController(text: getPrefValue(Keys.BLOOD_GROUP));
  }

//date picker method
  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Refer step 1
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      print('Picked Date ${picked}');
      selectedDate = picked;
      dobController = TextEditingController(text: selectedDate.toString());
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    print('Date ${dobController.text}');

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Edit Profile",
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      unFocus(context);
                      bottomSheet(context);
                    },
                    child: Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xff14B4A5),
                                Color(0xff3883EF),
                              ],
                            ),
                          ),
                          child: Container(
                            height: 180,
                            width: 180,
                            child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100.0)),
                                child: image == null
                                    ? getPrefValue(Keys.PROFILE_PIC) != null
                                        ? FadeInImage.assetNetwork(
                                            placeholder: "assets/appLogo.png",
                                            image:
                                                getPrefValue(Keys.PROFILE_PIC),
                                            fit: BoxFit.fill,
                                          )
                                        : Image.asset('assets/appLogo.png')
                                    : ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(100.0)),
                                        child: Image.file(
                                          image,
                                          fit: BoxFit.cover,
                                          height: 200,
                                          width: 200,
                                        ),
                                      )),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(55)),
                          margin: EdgeInsets.only(top: 150, left: 120),
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.black.withOpacity(0.6),
                            size: 50,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                        padding: EdgeInsets.all(1),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Full Name",
                              style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      color: Colors.lightBlueAccent
                                          .withOpacity(0.7),
                                      fontSize: 20)),
                            ),
                            TextFormField(
                              controller: nameController,
                              decoration: new InputDecoration(
                                labelStyle: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                        color: Colors.black.withOpacity(0.5),
                                        fontSize: 15)),

                                fillColor: Colors.white,
                                filled: true,
                                //fillColor: Colors.green
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                        padding: EdgeInsets.all(1),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "First Name",
                              style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      color: Colors.lightBlueAccent
                                          .withOpacity(0.7),
                                      fontSize: 20)),
                            ),
                            TextFormField(
                              controller: nameFirstController,
                              decoration: new InputDecoration(
                                labelStyle: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                        color: Colors.black.withOpacity(0.5),
                                        fontSize: 15)),

                                fillColor: Colors.white,
                                filled: true,
                                //fillColor: Colors.green
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                        padding: EdgeInsets.all(1),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Middle Name",
                              style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      color: Colors.lightBlueAccent
                                          .withOpacity(0.7),
                                      fontSize: 20)),
                            ),
                            TextFormField(
                              controller: nameMiddleController,
                              decoration: new InputDecoration(
                                labelStyle: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                        color: Colors.black.withOpacity(0.5),
                                        fontSize: 15)),

                                fillColor: Colors.white,
                                filled: true,
                                //fillColor: Colors.green
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                        padding: EdgeInsets.all(1),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Last Name",
                              style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      color: Colors.lightBlueAccent
                                          .withOpacity(0.7),
                                      fontSize: 20)),
                            ),
                            TextFormField(
                              controller: nameLastController,
                              decoration: new InputDecoration(
                                labelStyle: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                        color: Colors.black.withOpacity(0.5),
                                        fontSize: 15)),

                                fillColor: Colors.white,
                                filled: true,
                                //fillColor: Colors.green
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                        padding: EdgeInsets.all(1),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "DOB",
                              style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      color: Colors.lightBlueAccent
                                          .withOpacity(0.7),
                                      fontSize: 20)),
                            ),
                            //Text('Dob ${dobController.text}')
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(dobController.text == null ||
                                        dobController.text.contains('null')
                                    ? 'Select DOB'
                                    : dobController.text.substring(0, 10)),
//                                 Container(
//                                   width: 200,
//                                   child: TextFormField(
//                                     controller: dobController,
//                                     decoration: new InputDecoration(
// //                            labelText: "22/02/2020",
// //                            labelStyle: GoogleFonts.montserrat(
// //                                textStyle: TextStyle(
// //                                    color: Colors.black.withOpacity(0.5),
// //                                    fontSize: 15)),
//
//                                       fillColor: Colors.white,
//                                       filled: true,
//                                       //fillColor: Colors.green
//                                     ),
//                                   ),
//                                 ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.lightBlueAccent,
                                      borderRadius: BorderRadius.circular(99)),
                                  child: FlatButton(
                                    onPressed: () {
                                      unFocus(context);
                                      _selectDate(context);
                                    },
                                    // Refer step 3
                                    child: Icon(
                                      Icons.calendar_today_outlined,
                                      color: Colors.white,
                                    ),
                                    color: Colors.transparent,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                        padding: EdgeInsets.all(1),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Gender",
                              style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      color: Colors.lightBlueAccent
                                          .withOpacity(0.7),
                                      fontSize: 20)),
                            ),

                            Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    hint: Text("Select Gender"),
                                    value: pickedGender,
                                    items: <String>['Male', 'Female', 'Other']
                                        .map((String _genValue) {
                                      return DropdownMenuItem<String>(
                                        value: _genValue,
                                        child: Text(_genValue),
                                      );
                                    }).toList(),
                                    onChanged: (_genValue) {
                                      setState(() {
                                        pickedGender = _genValue;
                                      });
                                      print('Selected Gender $_genValue');
                                    },
                                    isExpanded: true,
                                    icon: Container(
                                      padding: EdgeInsets.all(5),
                                      child: Container(
                                          margin: EdgeInsets.all(0),
                                          height: 20,
                                          width: 20,
                                          child: Image.asset(
                                            "assets/senddown.png",
                                          )),
                                    ),
                                  ),
                                )),
//                             TextFormField(
//                               controller: genderController,
//                               decoration: new InputDecoration(
// //                            labelText: "Male",
// //                            labelStyle: GoogleFonts.montserrat(
// //                                textStyle: TextStyle(
// //                                    color: Colors.black.withOpacity(0.5),
// //                                    fontSize: 15)),
//
//                                 fillColor: Colors.white,
//                                 filled: true,
//                                 //fillColor: Colors.green
//                               ),
//                             ),
                          ],
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                        padding: EdgeInsets.all(1),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Mobile",
                              style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      color: Colors.lightBlueAccent
                                          .withOpacity(0.7),
                                      fontSize: 20)),
                            ),
                            TextFormField(
                              maxLines: 10,
                              minLines: 1,
                              controller: mobileController,
                              decoration: new InputDecoration(
//                            labelText: "+919978554",
//                            labelStyle: GoogleFonts.montserrat(
//                                textStyle: TextStyle(
//                                    color: Colors.black.withOpacity(0.5),
//                                    fontSize: 15)),

                                fillColor: Colors.white,
                                filled: true,
                                //fillColor: Colors.green
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                        padding: EdgeInsets.all(1),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Email",
                              style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      color: Colors.lightBlueAccent
                                          .withOpacity(0.7),
                                      fontSize: 20)),
                            ),
                            TextFormField(
                              controller: emailController,
                              decoration: new InputDecoration(
//                            labelText: "Enter Email",
//                            labelStyle: GoogleFonts.montserrat(
//                                textStyle: TextStyle(
//                                    color: Colors.black.withOpacity(0.5),
//                                    fontSize: 15)),

                                fillColor: Colors.white,
                                filled: true,
                                //fillColor: Colors.green
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          unFocus(context);
                          pickCurrentLocation();
                        },
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            margin: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Color(0xff14B4A5),
                                  Color(0xff3883EF),
                                ],
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.location_on_outlined,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  'Fetch Location',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 25),
                                ),
                              ],
                            )),
                      ),
                      // RaisedButton(onPressed: (){
                      //   unFocus(context);
                      //   pickCurrentLocation();
                      // }),

                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                        padding: EdgeInsets.all(1),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Address",
                              style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      color: Colors.lightBlueAccent
                                          .withOpacity(0.7),
                                      fontSize: 20)),
                            ),
                            TextFormField(
                              controller: addressController,
                              decoration: new InputDecoration(
//                            labelText: "Enter Address",
//                            labelStyle: GoogleFonts.montserrat(
//                                textStyle: TextStyle(
//                                    color: Colors.black.withOpacity(0.5),
//                                    fontSize: 15)),

                                fillColor: Colors.white,
                                filled: true,
                                //fillColor: Colors.green
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                        padding: EdgeInsets.all(1),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "City",
                              style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      color: Colors.lightBlueAccent
                                          .withOpacity(0.7),
                                      fontSize: 20)),
                            ),
                            TextFormField(
                              controller: addressCityController,
                              decoration: new InputDecoration(
//                            labelText: "Enter Address",
//                            labelStyle: GoogleFonts.montserrat(
//                                textStyle: TextStyle(
//                                    color: Colors.black.withOpacity(0.5),
//                                    fontSize: 15)),

                                fillColor: Colors.white,
                                filled: true,
                                //fillColor: Colors.green
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                        padding: EdgeInsets.all(1),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "State",
                              style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      color: Colors.lightBlueAccent
                                          .withOpacity(0.7),
                                      fontSize: 20)),
                            ),
                            TextFormField(
                              controller: addressStateController,
                              decoration: new InputDecoration(
//                            labelText: "Enter Address",
//                            labelStyle: GoogleFonts.montserrat(
//                                textStyle: TextStyle(
//                                    color: Colors.black.withOpacity(0.5),
//                                    fontSize: 15)),

                                fillColor: Colors.white,
                                filled: true,
                                //fillColor: Colors.green
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                        padding: EdgeInsets.all(1),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Pincode",
                              style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      color: Colors.lightBlueAccent
                                          .withOpacity(0.7),
                                      fontSize: 20)),
                            ),
                            TextFormField(
                              controller: addressPincodeController,
                              decoration: new InputDecoration(
//                            labelText: "Enter Address",
//                            labelStyle: GoogleFonts.montserrat(
//                                textStyle: TextStyle(
//                                    color: Colors.black.withOpacity(0.5),
//                                    fontSize: 15)),

                                fillColor: Colors.white,
                                filled: true,
                                //fillColor: Colors.green
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                        padding: EdgeInsets.all(1),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Blood Group",
                              style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      color: Colors.lightBlueAccent
                                          .withOpacity(0.7),
                                      fontSize: 20)),
                            ),
                            Text(' Blood Value ${bloodgroupController.text}'),
                            Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    hint: Text(
                                        'Select Blood Group ${bloodgroupController.text.length}'),
                                    onTap: () => unFocus(context),
                                    value: pickedBloodGroup,
                                    items: <String>[
                                      'O positive',
                                      'O negative',
                                      'A positive',
                                      'A negative',
                                      'B positive',
                                      'B negative',
                                      'AB positive',
                                      'AB negative',
                                    ].map((String _bloodvalue) {
                                      return DropdownMenuItem<String>(
                                        value: _bloodvalue,
                                        child: Text(_bloodvalue),
                                      );
                                    }).toList(),
                                    onChanged: (_bloodvalue) {
                                      unFocus(context);
                                      setState(() {
                                        pickedBloodGroup = _bloodvalue;
                                        bloodgroupController =
                                            TextEditingController(
                                                text: _bloodvalue);
                                      });
                                      print('Selected Gender $_bloodvalue');
                                    },
                                    isExpanded: true,
                                    icon: Container(
                                      padding: EdgeInsets.all(5),
                                      child: Container(
                                          margin: EdgeInsets.all(0),
                                          height: 20,
                                          width: 20,
                                          child: Image.asset(
                                            "assets/senddown.png",
                                          )),
                                    ),
                                  ),
                                )),

//                             TextFormField(
//                               controller: bloodgroupController,
//                               decoration: new InputDecoration(
// //                            labelText: "Select your blood group",
// //                            labelStyle: GoogleFonts.montserrat(
// //                                textStyle: TextStyle(
// //                                    color: Colors.black.withOpacity(0.5),
// //                                    fontSize: 15)),
//
//                                 fillColor: Colors.white,
//                                 filled: true,
//                                 //fillColor: Colors.green
//                               ),
//                             ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.55,
              margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
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
                    'Save',
                    style: GoogleFonts.montserrat(
                        textStyle:
                            TextStyle(color: Colors.white, fontSize: 15)),
                  ),
                  onPressed: () {
                    editProfileAPI();
                  }),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.55,
              margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
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
                  child: Center(
                    child: Text(
                      'Change password',
                      style: GoogleFonts.montserrat(
                          textStyle:
                              TextStyle(color: Colors.white, fontSize: 15)),
                    ),
                  ),
                  onPressed: () {
                    Get.dialog(Container(
                      child: AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Text('Change Password'),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Container(
                                      child: Icon(Icons.close),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.symmetric(vertical: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 10),
                                      padding: EdgeInsets.all(1),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Old Password",
                                            style: GoogleFonts.montserrat(
                                                textStyle: TextStyle(
                                                    color: Colors
                                                        .lightBlueAccent
                                                        .withOpacity(0.7),
                                                    fontSize: 20)),
                                          ),
                                          TextFormField(
                                            controller: oldPassController,
                                            obscureText: true,
                                            decoration: new InputDecoration(
                                              labelText:
                                                  "Enter Your Old Password",

                                              labelStyle:
                                                  GoogleFonts.montserrat(
                                                      textStyle: TextStyle(
                                                          color: Colors.black
                                                              .withOpacity(0.5),
                                                          fontSize: 15)),

                                              fillColor: Colors.white,
                                              filled: true,
                                              //fillColor: Colors.green
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 15),
                                      padding: EdgeInsets.all(1),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "New Password",
                                            style: GoogleFonts.montserrat(
                                                textStyle: TextStyle(
                                                    color: Colors
                                                        .lightBlueAccent
                                                        .withOpacity(0.7),
                                                    fontSize: 20)),
                                          ),
                                          TextFormField(
                                            controller: newPassController,
                                            obscureText: true,
                                            decoration: new InputDecoration(
                                              labelText:
                                                  "Enter Your New Password",
                                              labelStyle:
                                                  GoogleFonts.montserrat(
                                                      textStyle: TextStyle(
                                                          color: Colors.black
                                                              .withOpacity(0.5),
                                                          fontSize: 15)),

                                              fillColor: Colors.white,
                                              filled: true,
                                              //fillColor: Colors.green
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.55,
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 10),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 5),
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.topRight,
                                            colors: [
                                              Color(0xff14B4A5),
                                              Color(0xff3883EF),
                                            ],
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(590)),
                                      child: MaterialButton(
                                          child: Text(
                                            'Save',
                                            style: GoogleFonts.montserrat(
                                                textStyle: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15)),
                                          ),
                                          onPressed: () {
                                            validateInputs(
                                                oldPassController.text,
                                                newPassController.text);
                                          }),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )),
                    ));
//                Navigator.push(
//                  context,
//                  MaterialPageRoute(builder: (context) => Signup()),
//                );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> changePasswordAPI(oldpass, newpass) async {
    //showDialog(context: context, builder: (context) => Loading());
    await changePassword(oldpass, newpass).then((onValue) {
      print(onValue.message);
      if (onValue.message.toString().contains("Succesfull")) {
        Get.rawSnackbar(
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.white,
            messageText: Text(onValue.message,
                style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                        color: Colors.black.withOpacity(0.5), fontSize: 17))),
            padding: EdgeInsets.all(20),
            borderRadius: 10,
            margin: EdgeInsets.all(15));
        setPrefValue(Keys.TOKEN, onValue.token);
        oldPassController.clear();
        newPassController.clear();
        Future.delayed(Duration(milliseconds: 1800), () {
          Get.back();
          Get.back();
        });
      } else {
        Get.rawSnackbar(
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.white,
            messageText: Text(onValue.message,
                style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                        color: Colors.black.withOpacity(0.5), fontSize: 17))),
            padding: EdgeInsets.all(20),
            borderRadius: 10,
            margin: EdgeInsets.all(15));

        // Navigator.push(context, MaterialPageRoute(builder: (context) => Home()),);
      }
    });
    setState(() {});
  }

  Future<void> editProfileAPI() async {
    //showDialog(context: context, builder: (context) => Loading());
    String dob = dobController.text != null
        ? dobController.text
        : getPrefValue(Keys.DOB);
    String gender =
        pickedGender != null ? pickedGender : getPrefValue(Keys.GENDER);
    String address = addressController.text != null
        ? addressController.text
        : getPrefValue(Keys.DOB);
    String bloodGroup = bloodgroupController.text != null
        ? bloodgroupController.text
        : getPrefValue(Keys.DOB);
    String name = nameController.text != null
        ? nameController.text
        : getPrefValue(Keys.DOB);
    String email = emailController.text != null
        ? emailController.text
        : getPrefValue(Keys.DOB);
    String phone = mobileController.text != null
        ? mobileController.text
        : getPrefValue(Keys.PHONE);
    String fn = nameFirstController.text != null
        ? nameFirstController.text
        : getPrefValue(Keys.FIRST_NAME);
    String mn = nameMiddleController.text != null
        ? nameMiddleController.text
        : getPrefValue(Keys.MIDDLE_NAME);
    String ln = nameLastController.text != null
        ? nameLastController.text
        : getPrefValue(Keys.LAST_NAME);
    String state = addressStateController.text != null
        ? addressStateController.text
        : getPrefValue(Keys.STATE);
    String city = addressCityController.text != null
        ? addressCityController.text
        : getPrefValue(Keys.CITY);
    String pincode = addressPincodeController.text != null
        ? addressPincodeController.text
        : getPrefValue(Keys.PINCODE);

    if (dob == null ||
        gender == null ||
        address == null ||
        bloodGroup == null ||
        name == null ||
        email == null ||
        phone == null ||
        fn == null ||
        ln == null ||
        state == null ||
        city == null ||
        pincode == null ||
        dob == '' ||
        gender == '' ||
        address == '' ||
        bloodGroup == '' ||
        name == '' ||
        email == '' ||
        phone == '' ||
        fn == '' ||
        ln == '' ||
        state == '' ||
        city == '' ||
        pincode == '') {
      Get.rawSnackbar(
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          messageText: Text("All fields are mandatory",
              style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                      color: Colors.black.withOpacity(0.5), fontSize: 17))),
          padding: EdgeInsets.all(20),
          borderRadius: 10,
          margin: EdgeInsets.all(15));
    } else {
      if (image == null) {
        print('Update without image');
        await editProfile(dob, gender, address, bloodGroup, name, email, phone,
                fn, mn ?? '', ln, state, city, pincode)
            .then((onValue) {
          if (onValue.message.toString().contains("Profile Updated")) {
            Get.rawSnackbar(
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.white,
                messageText: Text(onValue.message,
                    style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            color: Colors.black.withOpacity(0.5),
                            fontSize: 17))),
                padding: EdgeInsets.all(20),
                borderRadius: 10,
                margin: EdgeInsets.all(15));
            setPrefMethod(onValue);
            Future.delayed(Duration(milliseconds: 1800), () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Home()),
              );
            });
          } else {
            print("else");
            Get.rawSnackbar(
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.white,
                messageText: Text("Register Failed",
                    style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            color: Colors.black.withOpacity(0.5),
                            fontSize: 17))),
                padding: EdgeInsets.all(20),
                borderRadius: 10,
                margin: EdgeInsets.all(15));
          }
        });
        setState(() {});
      } else {
        print('Update with image');
        await editProfileWithProfilePic(image, dob, gender, address, bloodGroup,
            name, email, phone, fn, mn, ln, state, city, pincode, (onValue) {
          if (jsonDecode(onValue)['message'].toString().contains("Updated")) {
            Get.rawSnackbar(
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.white,
                messageText: Text(jsonDecode(onValue)['message'],
                    style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            color: Colors.black.withOpacity(0.5),
                            fontSize: 17))),
                padding: EdgeInsets.all(20),
                borderRadius: 10,
                margin: EdgeInsets.all(15));
            EditProfileModel model =
                EditProfileModel.fromMap(jsonDecode(onValue));
            setPrefMethod(model);
            Future.delayed(Duration(milliseconds: 1800), () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Home()),
              );
            });
          } else {
            print("else");
            Get.rawSnackbar(
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.white,
                messageText: Text("Register Failed",
                    style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            color: Colors.black.withOpacity(0.5),
                            fontSize: 17))),
                padding: EdgeInsets.all(20),
                borderRadius: 10,
                margin: EdgeInsets.all(15));
          }
        });
        setState(() {});
      }
    }
  }

  bottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                ListTile(
                    leading: Icon(Icons.camera),
                    title: Text('Camera'),
                    onTap: () {
                      captureImage(ImageSource.camera);
                      Navigator.pop(context);
                    }),
                Center(
                  child: ListTile(
                    leading: Icon(Icons.image),
                    title: Text('Gallery'),
                    onTap: () {
                      captureImage(ImageSource.gallery);
                      Navigator.pop(context);
                    },
                  ),
                ),
                ListTile(
                  title: Center(child: Text('Cancel')),
                  onTap: () => Navigator.pop(context),
                ),
              ],
            ),
          );
        });
  }

  Future<void> captureImage(ImageSource imageSource) async {
    try {
      final imageFile =
          await ImagePicker.pickImage(source: imageSource, imageQuality: 50);
      image = imageFile;
      print('new image' + image.toString());
      setState(() {});
    } catch (e) {
      print("exception : " + e.toString());
    }
  }

  void setPrefMethod(EditProfileModel sign) {
    setPrefValue(Keys.DOB, sign.userDetails.dob.toString());
    setPrefValue(Keys.GENDER, sign.userDetails.gender);
    setPrefValue(Keys.ADDRESS, sign.userDetails.address);
    setPrefValue(Keys.BLOOD_GROUP, sign.userDetails.bloodGroup);
    setPrefValue(Keys.PINCODE, sign.userDetails.pincode);
    setPrefValue(Keys.NAME, sign.user.name);
    setPrefValue(Keys.EMAIL, sign.user.email);
    setPrefValue(Keys.PHONE, sign.user.phone);
    print('Edit profile ${sign.user.avatar}');

    setPrefValue(Keys.FIRST_NAME, sign.userDetails.firstName);
    setPrefValue(Keys.LAST_NAME, sign.userDetails.lastName);
    setPrefValue(Keys.MIDDLE_NAME, sign.userDetails.middleName);

    setPrefValue(Keys.STATE,
        sign.userDetails.state != null ? sign.userDetails.state : "");
    setPrefValue(
        Keys.CITY, sign.userDetails.city != null ? sign.userDetails.city : "");
    setPrefValue(Keys.PINCODE,
        sign.userDetails.pincode != null ? sign.userDetails.pincode : "");

    if (sign.user.avatar != null)
      setPrefValue(
          Keys.PROFILE_PIC, IMAGE_URL + "avatar_user/" + sign.user.avatar);
  }

  void pickCurrentLocation() {
    fetchCurrentLocation();
  }

  fetchCurrentLocation() async {
    scaffoldKey.currentState
        .showSnackBar(SnackBar(content: Text('Loading...')));
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      // List<Placemark> placeMarks =
      // await placemarkFromCoordinates(position.latitude, position.longitude);
      // Placemark currentPlaceMark = placeMarks[0];
      // print('Place ${currentPlaceMark.toJson()}');
      // print('Place ${currentPlaceMark.toString()}');

      final coordinates =
          new Coordinates(position.latitude, position.longitude);
      var addresses =
          await Geocoder.local.findAddressesFromCoordinates(coordinates);
      var first = addresses.first;
      print(
          " Place 1 ${first.featureName} : ${first.addressLine} ${first.toMap()}  ");
      addressController = TextEditingController(text: first.addressLine);
      addressCityController = TextEditingController(text: first.locality);
      addressStateController = TextEditingController(text: first.adminArea);
      addressPincodeController = TextEditingController(text: first.postalCode);
      scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Done')));
      setState(() {});
    } catch (e) {
      scaffoldKey.currentState
          .showSnackBar(SnackBar(content: Text('Unknown Error occured')));
    }
  }

  void unFocus(BuildContext context) {
    FocusScope.of(context).unfocus();
  }
}
