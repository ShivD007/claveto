import 'package:claveto/common/constant.dart';
import 'package:claveto/common/loading.dart';
import 'package:claveto/common/pref.dart';
import 'package:claveto/forgot_password.dart';
import 'package:claveto/rest/api_services.dart';
import 'package:claveto/signup.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'common/keys.dart';
import 'config/config.dart';
import 'home.dart';

import 'model/signIn_model.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'notification_example.dart';

Future<void> main() async {
  // needed if you intend to initialize in the `main` function
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  ChatApp.sharedPreferences = await SharedPreferences.getInstance();

  ChatApp.firestore = FirebaseFirestore.instance;

  await configureLocalTimeZone();

  final NotificationAppLaunchDetails notificationAppLaunchDetails =
      await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('app_icon');

  /// Note: permissions aren't requested here just to demonstrate that can be
  /// done later
  final IOSInitializationSettings initializationSettingsIOS =
      IOSInitializationSettings(
          requestAlertPermission: false,
          requestBadgePermission: false,
          requestSoundPermission: false,
          onDidReceiveLocalNotification:
              (int id, String title, String body, String payload) async {
            didReceiveLocalNotificationSubject.add(ReceivedNotification(
                id: id, title: title, body: body, payload: payload));
          });
  const MacOSInitializationSettings initializationSettingsMacOS =
      MacOSInitializationSettings(
          requestAlertPermission: false,
          requestBadgePermission: false,
          requestSoundPermission: false);
  final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      //iOS: initializa3tionSettingsIOS,
      macOS: initializationSettingsMacOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
    selectNotificationSubject.add(payload);
  });
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Claveto',
    theme: ThemeData(
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    home: SafeArea(child: SplashScreen(notificationAppLaunchDetails)),
  )
   
      );
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final emailController = TextEditingController();
  final passController = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Pref.init();
  }

  validateInputs(e, p) {
    if (GetUtils.isNullOrBlank(e)) {
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
    } else if (GetUtils.isNullOrBlank(p)) {
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
    } else {
      loginAPI(emailController.text, passController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: Container(
        alignment: Alignment.center,
        height: _size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Color(0xff14B4A5),
              Color(0xff3883EF),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    margin: EdgeInsets.only(top: 30.0, bottom: 20),
                    // padding: EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/splash_screen/new_splash.png',
                      height: _size.width * .15,
                      width: _size.width * .8,
                      fit: BoxFit.contain,
                    )),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.5),
                      borderRadius: BorderRadius.circular(590)),
                  child: TextFormField(
                    controller: emailController,
                    decoration: new InputDecoration(
                      icon: Icon(
                        Icons.email_outlined,
                      ),
                      labelText: " Email",
                      labelStyle: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 20)),
                      border: InputBorder.none,
                      //fillColor: Colors.green
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.5),
                      borderRadius: BorderRadius.circular(590)),
                  child: TextFormField(
                    obscureText: true,
                    controller: passController,
                    decoration: new InputDecoration(
                      icon: Icon(Icons.lock_outline_rounded),
                      labelText: " Password",
                      labelStyle: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                              fontSize: 20)),
                      border: InputBorder.none,
                      //fillColor: Colors.green
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .05),


                Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  margin: EdgeInsets.symmetric(horizontal: 2, vertical: 10),
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(5.0, 5.0), //(x,y)
                          blurRadius: 55.0,
                        ),
                      ],
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
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Signin',
                            style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                    color: Colors.white, fontSize: 20)),
                          ),
                          Container(
                              margin: EdgeInsets.all(10),
                              height: 15,
                              width: 15,
                              child: Image.asset(
                                "assets/send.png",
                                color: Colors.white,
                              )),
                        ],
                      ),
                      onPressed: () {
                        validateInputs(
                            emailController.text, passController.text);
                      }),
                ),

                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ForgotPassword()),
                    );
                  },
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                      child: Text(
                        'Forgot Password',
                        style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                color: Colors.white.withOpacity(0.5),
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: MediaQuery.of(context).size.height * .15),

                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don\'t have an account ? ",
                        style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                color: Colors.white.withOpacity(0.5),
                                fontSize: 18,
                                fontWeight: FontWeight.normal)),
                      ),
                      InkWell(
                        child: Text(
                          'Register here',
                          style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.white.withOpacity(0.7),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Signup()),
                          );
                        },
                      ),
                    ],
                  ),
                )

                
              ],
            ),
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<void> loginAPI(email, password) async {
    showDialog(context: context, builder: (context) => Loading());
    await login(email, password).then((onValue) {
      if (onValue.toString().contains("message")) {
        Navigator.pop(context);
        Get.rawSnackbar(
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.white,
            messageText: Text("Invalid Credentials",
                style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                        color: Colors.black.withOpacity(0.5), fontSize: 17))),
            padding: EdgeInsets.all(20),
            borderRadius: 10,
            margin: EdgeInsets.all(15));
      } else {
        print("success");
        Navigator.pop(context);
        print(onValue.toString());
        SignInModel model = onValue;
        if (model.user.userType.toString().toLowerCase() == 'user') {
          setState(() {
            print('User Type ${model.user.userType}');
            setPrefValues(onValue);
            print(getPrefValue(Keys.TOKEN));
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Home()),
            );
          });
        } else {
          Get.rawSnackbar(
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.white,
              messageText: Text("Invalid Credentials",
                  style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          color: Colors.black.withOpacity(0.5), fontSize: 17))),
              padding: EdgeInsets.all(20),
              borderRadius: 10,
              margin: EdgeInsets.all(15));
        }
      }
    });
    setState(() {});
  }

  void setPrefValues(onValue) {
    SignInModel sign = onValue;
    print(sign.user.id);
    setPrefValue(Keys.TOKEN, sign.accessToken);
    setPrefValue(Keys.ID, sign.user.id.toString());
    setPrefValue(Keys.FIRST_NAME, sign.details.firstName);
    setPrefValue(Keys.LAST_NAME, sign.details.lastName);
    setPrefValue(Keys.MIDDLE_NAME, sign.details.middleName);
    setPrefValue(Keys.NAME, sign.user.name);
    setPrefValue(Keys.EMAIL, sign.user.email);
    setPrefValue(Keys.PHONE, sign.user.phone);
    setPrefValue(
        Keys.DOB,
        sign.details.dob.toString() != null
            ? sign.details.dob.toString()
            : null);
    setPrefValue(
        Keys.GENDER, sign.details.gender != null ? sign.details.gender : "");
    setPrefValue(
        Keys.ADDRESS, sign.details.address != null ? sign.details.address : "");
    setPrefValue(
        Keys.STATE, sign.details.state != null ? sign.details.state : "");
    setPrefValue(Keys.CITY, sign.details.city != null ? sign.details.city : "");
    setPrefValue(
        Keys.PINCODE, sign.details.pincode != null ? sign.details.pincode : "");
    setPrefValue(Keys.BLOOD_GROUP,
        sign.details.bloodGroup != null ? sign.details.bloodGroup : "");
    print('Value ${sign.user.avatar}');
    //print('Image Url ${IMAGE_URL+"avatar_user/"+sign.user.avatar}');
    setPrefValue(
        Keys.PROFILE_PIC,
        sign.user.avatar == null
            ? null
            : IMAGE_URL + "avatar_user/" + sign.user.avatar);
  }
}

//----------------------Notification code from here--------------------------------
