import 'dart:convert';

import 'package:claveto/blog/detailed_blog.dart';
import 'package:claveto/common/keys.dart';
import 'package:claveto/home.dart';

import 'package:claveto/rest/api_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'common/constant.dart';
import 'common/loading.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var genderController = TextEditingController();
  var dobController = TextEditingController();
  var stateController = TextEditingController();
  var cityController = TextEditingController();
  var pincodeController = TextEditingController();

  String gender;
  List<String> genderList = ["Male", "Female"];
  DateTime selectedDate;

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900, 1),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  validateInputs(
    name,
    email,
    password,
    phone,
    /* gender, dob, state, city, pincode*/
  ) {
    if (GetUtils.isNullOrBlank(name)) {
      Get.rawSnackbar(
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          messageText: Text("Name Can't be empty",
              style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                      color: Colors.black.withOpacity(0.5), fontSize: 17))),
          padding: EdgeInsets.all(20),
          borderRadius: 10,
          margin: EdgeInsets.all(15));
    } else if (GetUtils.isNullOrBlank(email)) {
      Get.rawSnackbar(
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          messageText: Text("Email Can't be empty",
              style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                      color: Colors.black.withOpacity(0.5), fontSize: 17))),
          padding: EdgeInsets.all(20),
          borderRadius: 10,
          margin: EdgeInsets.all(15));
    } else if (GetUtils.isNullOrBlank(password)) {
      Get.rawSnackbar(
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          messageText: Text("Password Can't be empty",
              style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                      color: Colors.black.withOpacity(0.5), fontSize: 17))),
          padding: EdgeInsets.all(20),
          borderRadius: 10,
          margin: EdgeInsets.all(15));
    } else if (GetUtils.isNullOrBlank(phone)) {
      Get.rawSnackbar(
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          messageText: Text("PhoneNumber Can't be empty",
              style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                      color: Colors.black.withOpacity(0.5), fontSize: 17))),
          padding: EdgeInsets.all(20),
          borderRadius: 10,
          margin: EdgeInsets.all(15));
    }
   
    else {
      registerAPI();
    }
  }

  bool agree = false;
  var data;

  @override
  void initState() {
    getTermsandConditions().then((value) {
      setState(() {
        data = value;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipPath(
              clipper: ZigZagClipper(),
              child: Container(
                height: 190.0,
                width: double.infinity,
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
                child: Center(
                    child: Text(
                  "SignUp",
                  style: TextStyle(color: Colors.white, fontSize: 35),
                )),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
                    padding:
                        EdgeInsets.only(top: 4, bottom: 2, left: 10, right: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(590)),
                    child: TextFormField(
                      controller: nameController,
                      decoration: new InputDecoration(
                        icon: Icon(Icons.perm_identity),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 0.0),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.white, width: 0.0),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        contentPadding: new EdgeInsets.fromLTRB(10, 5, 10, 30),
                        labelText: " Full Name",
                        labelStyle: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                                fontSize: 20)),
                        fillColor: Colors.white,
                        //  filled: true,
                        //fillColor: Colors.green
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
                    padding:
                        EdgeInsets.only(top: 4, bottom: 2, left: 10, right: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(590)),
                    child: TextFormField(
                      controller: emailController,
                      decoration: new InputDecoration(
                        icon: Icon(Icons.email_outlined),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 0.0),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.white, width: 0.0),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        contentPadding: new EdgeInsets.fromLTRB(10, 5, 10, 30),
                        labelText: " Email",
                        alignLabelWithHint: true,
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
                    padding:
                        EdgeInsets.only(top: 4, bottom: 2, left: 10, right: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(590)),
                    child: TextFormField(
                      obscureText: true,
                      controller: passwordController,
                      decoration: new InputDecoration(
                        icon: Icon(Icons.lock_outline),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 0.0),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.white, width: 0.0),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        contentPadding: new EdgeInsets.fromLTRB(10, 5, 10, 30),
                        labelText: "Password",
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
                    padding: EdgeInsets.only(top: 4, bottom: 2, left: 5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(590)),
                    child: TextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.number,
                      decoration: new InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 0.0),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.white, width: 0.0),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        contentPadding: new EdgeInsets.fromLTRB(20, 5, 10, 30),
                        prefixIcon: Container(
                          padding: EdgeInsets.all(15),
                          margin: EdgeInsets.only(left: 0),
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
                              child: Text(
                            '+91',
                            style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                    color: Colors.white, fontSize: 20)),
                          )),
                        ),
                        hintText: " Phone Number",
                        hintStyle: GoogleFonts.montserrat(
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
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                  child: Row(
                    children: [
                      Material(
                        child: Checkbox(
                          value: agree,
                          onChanged: (value) {
                            setState(() {
                              agree = value;
                            });
                          },
                        ),
                      ),
                      Flexible(
                        child: RichText(
                            maxLines: 2,
                            text: TextSpan(
                                text: "I have read and accept ",
                                style: TextStyle(color: Colors.black),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: "terms and conditions.",
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailedBlog(
                                                      model: data,
                                                    )),
                                          );
                                        })
                                ])),
                        // child: Text(
                        //   'I have read and accept terms and conditions.',
                        //   overflow: TextOverflow.ellipsis,
                        //   maxLines: 2,
                        // ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  margin: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  decoration: BoxDecoration(
//                    boxShadow: [
//                      BoxShadow(
//                        color: Colors.black,
//                        offset: Offset(5.0, 5.0), //(x,y)
//                        blurRadius: 55.0,
//                      ),
//                    ],
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
                        'Register',
                        style: GoogleFonts.montserrat(
                            textStyle:
                                TextStyle(color: Colors.white, fontSize: 20)),
                      ),
                      onPressed: () {
                        agree
                            ? validateInputs(
                                nameController.text,
                                emailController.text,
                                phoneController.text,
                                passwordController.text,
                                // gender,//genderController.text,
                                // selectedDate,
                                // stateController.text,
                                // cityController.text,
                                // pincodeController.text
                              )
                            : Get.rawSnackbar(
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.white,
                                messageText: Text(
                                    "Please accept Term and Conditions",
                                    style: GoogleFonts.montserrat(
                                        textStyle: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            fontSize: 17))),
                                padding: EdgeInsets.all(20),
                                borderRadius: 10,
                                margin: EdgeInsets.all(15));
//                  Navigator.push(
//                    context,
//                    MaterialPageRoute(builder: (context) => Signup()),
//                  );
                      }),
                ),
              ],
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<void> registerAPI() async {
    showDialog(context: context, builder: (context) => Loading());

    await register(
      nameController.text,
      emailController.text,
      phoneController.text,
      passwordController.text,
      // gender,
      // selectedDate.toString(),
      // stateController.text,
      // cityController.text,
      // pincodeController.text
    ).then((onValue) {
      if (onValue.toString().contains("message")) {
        Navigator.pop(context);
        Map<String, dynamic> temp = json.decode(onValue);
        Get.rawSnackbar(
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.white,
            messageText: Text(temp["message"],
                style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                        color: Colors.black.withOpacity(0.5), fontSize: 17))),
            padding: EdgeInsets.all(20),
            borderRadius: 10,
            margin: EdgeInsets.all(15));
      } else {
        print("else");
        Navigator.pop(context);
        Map<String, dynamic> temp = json.decode(onValue);
        Get.rawSnackbar(
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.white,
            messageText: Text("Register SuccessFull",
                style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                        color: Colors.black.withOpacity(0.5), fontSize: 17))),
            padding: EdgeInsets.all(20),
            borderRadius: 10,
            margin: EdgeInsets.all(15));
        print(temp["access_token"]);
        setPrefValue(Keys.TOKEN, temp["access_token"]);
        setPrefValue(Keys.NAME, nameController.text);
        setPrefValue(Keys.DOB, selectedDate.toString());
        // setPrefValue(Keys.GENDER,gender);
        setPrefValue(Keys.PHONE, phoneController.text);
        setPrefValue(Keys.EMAIL, emailController.text);

        //setPrefValue(Keys.ADDRESS,stateController.text+" "+ cityController.text);
        //setPrefValue(Keys.BLOOD_GROUP,blo));

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      }
    });
    setState(() {});
  }
}

class ZigZagClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(
        size.width / 2, size.height - 50, size.width, size.height);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
