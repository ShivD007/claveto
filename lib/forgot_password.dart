import 'package:claveto/model/forgot_password_model.dart';
import 'package:claveto/rest/api_services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  var emailController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
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
        title: Text('Forgot Password',
            style: GoogleFonts.montserrat(
                textStyle: TextStyle(color: Colors.white, fontSize: 15))),
      ),
      body: Container(
        child: Container(
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
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.5),
                      borderRadius: BorderRadius.circular(590)),
                  child: TextFormField(
                    controller: emailController,
                    decoration: new InputDecoration(
                      icon: Icon(Icons.email_outlined),
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
                SizedBox(
                  height: 25,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  margin: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
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
                            'Send',
                            style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                    color: Colors.white, fontSize: 20)),
                          ),

                        ],
                      ),
                      onPressed: () {
                        forgotPasswordAPI(emailController.text);
                      }),
                ),
              ],
            ),
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<void> forgotPasswordAPI(email) async {
    //showDialog(context: context, builder: (context) => Loading());
    await forgotPassword(email).then((onValue) {
      if (onValue.toString().contains("message")) {
        print("Invalid Credentials");
        errorMessage(context, "Invalid Credentials");
      } else {
        print("success");
        ForgotPasswordModel forgotPasswordModel = onValue;
        errorMessage(context, forgotPasswordModel.message);
        // Navigator.push(context, MaterialPageRoute(builder: (context) => Home()),);
      }
    });
    setState(() {});
  }

  void errorMessage(BuildContext context, String message) {
    final scaffold = _scaffoldKey.currentState;
    scaffold.showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        content: Text(message),
      ),
    );
  }
}
