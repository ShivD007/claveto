import 'package:claveto/chatscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import 'appointments.dart';

class DoctorsList extends StatefulWidget {
  @override
  _DoctorsListState createState() => _DoctorsListState();
}

class _DoctorsListState extends State<DoctorsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Container(height: 40,
          margin: EdgeInsets.fromLTRB(0,5,45,5),padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(.5),
              borderRadius: BorderRadius.circular(590)),
          child: TextFormField(

            decoration: new InputDecoration(
              suffixIcon: Icon(Icons.search,color: Colors.white.withOpacity(.7),),
              labelText: "   Doctor, Clinic, Category",
              labelStyle:GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.black.withOpacity(0.5),fontSize: 15)),
              border: InputBorder.none,
              //fillColor: Colors.green
            ),
          ),
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
        child: Container(
          child: Column(children: [
            ExpansionTile(
              leading: CircleAvatar(
              backgroundImage: NetworkImage('https://static.dribbble.com/users/68544/screenshots/3397089/doctor_strange.png',),radius: 30,
            ),
              title: Text("Dr.Strange"),
              subtitle: Text("M.B.B.S, M.D"),
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChatScreen()),
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width*0.4,
                    padding: EdgeInsets.all(10),
                    margin:EdgeInsets.fromLTRB(0,5,0,0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [

                          Color(0xff14B4A5),
                          Color(0xff3883EF),
                        ],
                      ),
                    ),
                    child:Text("Consult Now",textAlign: TextAlign.center,style: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.white,fontSize: 15)),),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AppointmentsScreen()),
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width*0.4,
                    padding: EdgeInsets.all(10),
                    margin:EdgeInsets.fromLTRB(0,5,0,15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [

                          Color(0xff14B4A5),
                          Color(0xff3883EF),
                        ],
                      ),
                    ),
                    child:Text("Book Appointment",textAlign: TextAlign.center,style: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.white,fontSize: 15)),),
                  ),
                )
              ],
            ),
            ExpansionTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage('https://static.dribbble.com/users/68544/screenshots/3397089/doctor_strange.png',),radius: 30,
              ),
              title: Text("Dr.Strange"),
              subtitle: Text("M.B.B.S, M.D"),
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width*0.4,
                  padding: EdgeInsets.all(10),
                  margin:EdgeInsets.fromLTRB(0,5,0,0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [

                        Color(0xff14B4A5),
                        Color(0xff3883EF),
                      ],
                    ),
                  ),
                  child:Text("Consult Now",textAlign: TextAlign.center,style: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.white,fontSize: 15)),),
                ),
                Container(
                  width: MediaQuery.of(context).size.width*0.4,
                  padding: EdgeInsets.all(10),
                  margin:EdgeInsets.fromLTRB(0,5,0,15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [

                        Color(0xff14B4A5),
                        Color(0xff3883EF),
                      ],
                    ),
                  ),
                  child:Text("Book Appointment",textAlign: TextAlign.center,style: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.white,fontSize: 15)),),
                )
              ],
            ),
            ExpansionTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage('https://static.dribbble.com/users/68544/screenshots/3397089/doctor_strange.png',),radius: 30,
              ),
              title: Text("Dr.Strange"),
              subtitle: Text("M.B.B.S, M.D"),
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width*0.4,
                  padding: EdgeInsets.all(10),
                  margin:EdgeInsets.fromLTRB(0,5,0,0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [

                        Color(0xff14B4A5),
                        Color(0xff3883EF),
                      ],
                    ),
                  ),
                  child:Text("Consult Now",textAlign: TextAlign.center,style: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.white,fontSize: 15)),),
                ),
                Container(
                  width: MediaQuery.of(context).size.width*0.4,
                  padding: EdgeInsets.all(10),
                  margin:EdgeInsets.fromLTRB(0,5,0,15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [

                        Color(0xff14B4A5),
                        Color(0xff3883EF),
                      ],
                    ),
                  ),
                  child:Text("Book Appointment",textAlign: TextAlign.center,style: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.white,fontSize: 15)),),
                )
              ],
            ),
            ExpansionTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage('https://static.dribbble.com/users/68544/screenshots/3397089/doctor_strange.png',),radius: 30,
              ),
              title: Text("Dr.Strange"),
              subtitle: Text("M.B.B.S, M.D"),
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width*0.4,
                  padding: EdgeInsets.all(10),
                  margin:EdgeInsets.fromLTRB(0,5,0,0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [

                        Color(0xff14B4A5),
                        Color(0xff3883EF),
                      ],
                    ),
                  ),
                  child:Text("Consult Now",textAlign: TextAlign.center,style: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.white,fontSize: 15)),),
                ),
                Container(
                  width: MediaQuery.of(context).size.width*0.4,
                  padding: EdgeInsets.all(10),
                  margin:EdgeInsets.fromLTRB(0,5,0,15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [

                        Color(0xff14B4A5),
                        Color(0xff3883EF),
                      ],
                    ),
                  ),
                  child:Text("Book Appointment",textAlign: TextAlign.center,style: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.white,fontSize: 15)),),
                )
              ],
            ),
            ExpansionTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage('https://static.dribbble.com/users/68544/screenshots/3397089/doctor_strange.png',),radius: 30,
              ),
              title: Text("Dr.Strange"),
              subtitle: Text("M.B.B.S, M.D"),
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width*0.4,
                  padding: EdgeInsets.all(10),
                  margin:EdgeInsets.fromLTRB(0,5,0,0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [

                        Color(0xff14B4A5),
                        Color(0xff3883EF),
                      ],
                    ),
                  ),
                  child:Text("Consult Now",textAlign: TextAlign.center,style: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.white,fontSize: 15)),),
                ),
                Container(
                  width: MediaQuery.of(context).size.width*0.4,
                  padding: EdgeInsets.all(10),
                  margin:EdgeInsets.fromLTRB(0,5,0,15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [

                        Color(0xff14B4A5),
                        Color(0xff3883EF),
                      ],
                    ),
                  ),
                  child:Text("Book Appointment",textAlign: TextAlign.center,style: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.white,fontSize: 15)),),
                )
              ],
            ),
            ExpansionTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage('https://static.dribbble.com/users/68544/screenshots/3397089/doctor_strange.png',),radius: 30,
              ),
              title: Text("Dr.Strange"),
              subtitle: Text("M.B.B.S, M.D"),
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width*0.4,
                  padding: EdgeInsets.all(10),
                  margin:EdgeInsets.fromLTRB(0,5,0,0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [

                        Color(0xff14B4A5),
                        Color(0xff3883EF),
                      ],
                    ),
                  ),
                  child:Text("Consult Now",textAlign: TextAlign.center,style: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.white,fontSize: 15)),),
                ),
                Container(
                  width: MediaQuery.of(context).size.width*0.4,
                  padding: EdgeInsets.all(10),
                  margin:EdgeInsets.fromLTRB(0,5,0,15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [

                        Color(0xff14B4A5),
                        Color(0xff3883EF),
                      ],
                    ),
                  ),
                  child:Text("Book Appointment",textAlign: TextAlign.center,style: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.white,fontSize: 15)),),
                )
              ],
            ),
            ExpansionTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage('https://static.dribbble.com/users/68544/screenshots/3397089/doctor_strange.png',),radius: 30,
              ),
              title: Text("Dr.Strange"),
              subtitle: Text("M.B.B.S, M.D"),
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width*0.4,
                  padding: EdgeInsets.all(10),
                  margin:EdgeInsets.fromLTRB(0,5,0,0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [

                        Color(0xff14B4A5),
                        Color(0xff3883EF),
                      ],
                    ),
                  ),
                  child:Text("Consult Now",textAlign: TextAlign.center,style: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.white,fontSize: 15)),),
                ),
                Container(
                  width: MediaQuery.of(context).size.width*0.4,
                  padding: EdgeInsets.all(10),
                  margin:EdgeInsets.fromLTRB(0,5,0,15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [

                        Color(0xff14B4A5),
                        Color(0xff3883EF),
                      ],
                    ),
                  ),
                  child:Text("Book Appointment",textAlign: TextAlign.center,style: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.white,fontSize: 15)),),
                )
              ],
            ),




          ],)
        ),
      ),
    );
  }
}
