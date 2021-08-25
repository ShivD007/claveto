import 'dart:convert';
import 'dart:io';

import 'package:claveto/rest/api_services.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'common/loading.dart';

class AddMember extends StatefulWidget {
  @override
  _AddMemberState createState() => _AddMemberState();
}

class _AddMemberState extends State<AddMember> {
  List<String> genderList = ["Male", "Female"];
  List<String> bloodGroupList = [
    'O positive',
    'O negative',
    'A positive',
    'A negative',
    'B positive',
    'B negative',
    'AB positive',
    'AB negative',
  ];
  List<String> relationList = [
    "Mother",
    "Father",
    "Brother",
    "Sister",
    "Spouse",
    "Son",
    "Daughter",
    "Grand-Father",
    "Grand-Mother"
  ];

  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var middleNameController = TextEditingController();

  String gender, bloodGroup, relation;

  DateTime selectedDate;

  File image;

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1850, 1),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Add Member",
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
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: InkWell(
                onTap: () {
                  bottomSheet(context);
                },
                child: CircleAvatar(
                    radius: MediaQuery.of(context).size.width * .15,
                    backgroundColor: Colors.black12,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: MediaQuery.of(context).size.width / 2,
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.black.withOpacity(0.6),
                          size: 30,
                        ),
                      ),
                      backgroundImage: image != null
                          ? FileImage(
                              image,
                            )
                          : AssetImage(
                              "assets/appLogo.png",
                              // height: 140,
                            ),
                    ),
                    backgroundImage: AssetImage("assets/appLogo.png")),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              padding: EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border:
                    Border.all(color: Colors.grey.withOpacity(0.3), width: 2),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                    padding: EdgeInsets.all(1),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Color(0xff14B4A5),
                            Color(0xff3883EF),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(590)),
                    child: Container(
                      padding: EdgeInsets.only(top: 4, bottom: 2, left: 5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(590)),
                      child: TextFormField(
                        controller: firstNameController,
                        decoration: new InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 0.0),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.white, width: 0.0),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          contentPadding:
                              new EdgeInsets.fromLTRB(10, 5, 10, 30),
                          labelText: " First Name",
                          labelStyle: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize: 20)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50)),
                          fillColor: Colors.white,
                          filled: true,
                          //fillColor: Colors.green
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                    padding: EdgeInsets.all(1),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Color(0xff14B4A5),
                            Color(0xff3883EF),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(590)),
                    child: Container(
                      padding: EdgeInsets.only(top: 4, bottom: 2, left: 5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(590)),
                      child: TextFormField(
                        controller: middleNameController,
                        decoration: new InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 0.0),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.white, width: 0.0),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          contentPadding:
                              new EdgeInsets.fromLTRB(10, 5, 10, 30),
                          labelText: " Middle Name",
                          labelStyle: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize: 20)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50)),
                          fillColor: Colors.white,
                          filled: true,
                          //fillColor: Colors.green
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                    padding: EdgeInsets.all(1),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Color(0xff14B4A5),
                            Color(0xff3883EF),
                          ],
                        ),
                        
                        borderRadius: BorderRadius.circular(590)),
                    child: Container(
                      padding: EdgeInsets.only(top: 4, bottom: 2, left: 5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(590)),
                      child: TextFormField(
                        controller: lastNameController,
                        decoration: new InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 0.0),
                            borderRadius: BorderRadius.circular(35.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.white, width: 0.0),
                            borderRadius: BorderRadius.circular(35.0),
                          ),
                          contentPadding:
                              new EdgeInsets.fromLTRB(10, 5, 10, 30),
                          labelText: " Last Name",
                          labelStyle: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                  color: Colors.black.withOpacity(0.5),
                                  fontSize: 20)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50)),
                          fillColor: Colors.white,
                          filled: true,
                          //fillColor: Colors.green
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                    padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Color(0xff14B4A5),
                            Color(0xff3883EF),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(590)),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.all(new Radius.circular(35.0)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: GestureDetector(
                          onTap: () => _selectDate(context),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                    selectedDate != null
                                        ? DateFormat("yyyy-MM-dd")
                                            .format(selectedDate)
                                        : "Birth Date",
                                    // : DateFormat("yyyy-MM-dd").format(selectedDate),
                                    style: GoogleFonts.montserrat(
                                        textStyle: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            fontSize: 20))),
                              ),
                              Container(
                                padding: EdgeInsets.all(15),
                                margin: EdgeInsets.only(right: 0),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.topRight,
                                    colors: [
                                      Color(0xff14B4A5),
                                      Color(0xff3883EF),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 3),
                                    child: FaIcon(
                                      FontAwesomeIcons.calendarAlt,
                                      color: Colors.white,
                                      size: 20,
                                    )),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                    padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Color(0xff14B4A5),
                            Color(0xff3883EF),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(590)),
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35.0),
                        // border: Border.all(color: Colors.yellow, width: 0.80),
                        color: Colors.white,
                      ),
                      child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              items: relationList.map((item) {
                                return new DropdownMenuItem(
                                  child: Text(item,
                                      style: GoogleFonts.montserrat(
                                          textStyle: TextStyle(
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              fontSize: 20))),
                                  value: item,
                                  //value: item.id.toString(),
                                );
                              }).toList(),
                              onChanged: (String value) {
                                setState(() {
                                  relation = value;
                                });
                              },
                              hint: Text("Relation",
                                  style: GoogleFonts.montserrat(
                                      textStyle: TextStyle(
                                          color: Colors.black.withOpacity(0.5),
                                          fontSize: 20))),
                              value: relation,
                              isExpanded: true,
                              icon: Container(
                                padding: EdgeInsets.fromLTRB(5, 5, 0, 5),
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
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                    padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Color(0xff14B4A5),
                            Color(0xff3883EF),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(590)),
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35.0),
                        border: Border.all(width: 0.01),
                        color: Colors.white,
                      ),
                      child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              items: genderList.map((item) {
                                return new DropdownMenuItem(
                                  child: Text(item,
                                      style: GoogleFonts.montserrat(
                                          textStyle: TextStyle(
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              fontSize: 20))),
                                  value: item,
                                  //value: item.id.toString(),
                                );
                              }).toList(),
                              onChanged: (String value) {
                                setState(() {
                                  gender = value;
                                });
                              },
                              hint: Text("Gender",
                                  style: GoogleFonts.montserrat(
                                      textStyle: TextStyle(
                                          color: Colors.black.withOpacity(0.5),
                                          fontSize: 20))),
                              value: gender,
                              isExpanded: true,
                              icon: Container(
                                padding: EdgeInsets.fromLTRB(5, 5, 0, 5),
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
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                    padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Color(0xff14B4A5),
                            Color(0xff3883EF),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(590)),
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35.0),
                        // border: Border.all(color: Colors.yellow, width: 0.80),
                        color: Colors.white,
                      ),
                      child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              items: bloodGroupList.map((item) {
                                return new DropdownMenuItem(
                                  child: Text(item,
                                      style: GoogleFonts.montserrat(
                                          textStyle: TextStyle(
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              fontSize: 20))),
                                  value: item,
                                  //value: item.id.toString(),
                                );
                              }).toList(),
                              onChanged: (String value) {
                                setState(() {
                                  bloodGroup = value;
                                });
                              },
                              hint: Text("Blood Group",
                                  style: GoogleFonts.montserrat(
                                      textStyle: TextStyle(
                                          color: Colors.black.withOpacity(0.5),
                                          fontSize: 20))),
                              value: bloodGroup,
                              isExpanded: true,
                              icon: Container(
                                padding: EdgeInsets.fromLTRB(5, 5, 0, 5),
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
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.85,
              margin: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
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
                            TextStyle(color: Colors.white, fontSize: 20)),
                  ),
                  onPressed: () {
                    addFamilyMmeberAPI();
                  }),
            ),
          ],
        ),
      ),
    );
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

  Future<void> addFamilyMmeberAPI() async {
    showDialog(context: context, builder: (context) => Loading());

    await addFamilyMemberWithProfilePic(
        image,
        firstNameController.text,
        lastNameController.text,
        middleNameController.text,
        DateFormat("yyyy-MM-dd").format(selectedDate).toString(),
        gender,
        bloodGroup,
        relation, (onValue) {
      print(onValue);
      var data = json.decode(onValue);
      print(data);
      if (data["message"].toString().contains("Added")) {
        Navigator.pop(context);
        setState(() {});
      } else {
        Get.rawSnackbar(
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.white,
            messageText: Text(
                data["message"].toString() != null
                    ? data["message"].toString()
                    : "Add Failed",
                style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                        color: Colors.black.withOpacity(0.5), fontSize: 17))),
            padding: EdgeInsets.all(20),
            borderRadius: 10,
            margin: EdgeInsets.all(15));
      }
    });
    Navigator.pop(context, true);
  }
}
