import 'package:claveto/home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppointmentSuccessScreen extends StatelessWidget {
  // ToDo Zeyan customize it as per need.
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        navigateTOHomeScreen(context);
        return Future.value(true);
      },
      child: Scaffold(
        body: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle,size: 195,color: Colors.green,),
            Center(
              child: Text(
                  'Payment Success',style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                      color: Colors.black
                          .withOpacity(0.7),
                      fontSize: 25))),
            ),
            SizedBox(height: 25,),
            Container( decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
                  colors: [
                    Color(0xff14B4A5),
                    Color(0xff3883EF),
                  ],
                ),
                borderRadius: BorderRadius.circular(590)),
              child: FlatButton(
                child: Text('Move to home screen',style: TextStyle(color: Colors.white),),
                onPressed: () => navigateTOHomeScreen(context),
              ),
            )
          ],
        ),
      ),
    );
  }


}
navigateTOHomeScreen(BuildContext context) {
  Route newRoute = MaterialPageRoute(builder: (_) => Home());
  Route oldRoute =
  MaterialPageRoute(builder: (_) => AppointmentSuccessScreen());
  Navigator.pushAndRemoveUntil(context, newRoute, (_) => false);
  //Navigator.replace(context,oldRoute: ,newRoute: newRoute);
}
