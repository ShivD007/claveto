import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class MemberHistory extends StatefulWidget {
  @override
  _MemberHistoryState createState() => _MemberHistoryState();
}

class _MemberHistoryState extends State<MemberHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Medical History",style:GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.white,fontSize: 20)),),
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

      body:
      SingleChildScrollView(
        child: Column(children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20,vertical: 15),padding: EdgeInsets.all(15),
            width:MediaQuery.of(context).size.width ,
            decoration:BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.grey.withOpacity(0.3),width: 2),

            ),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Diagnosis, date",style:GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.lightBlueAccent.withOpacity(0.7),fontSize: 20)),),

              ],
            ),

          ),

          Container(
            width:MediaQuery.of(context).size.width ,
            margin: EdgeInsets.symmetric(horizontal: 20,vertical: 15),padding: EdgeInsets.symmetric(vertical: 5),
            decoration:BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.grey.withOpacity(0.3),width: 2),

            ) ,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [

              Container(margin: EdgeInsets.symmetric(horizontal: 25,vertical: 15),padding: EdgeInsets.all(1),

                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Diagnosis Title",style: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.lightBlueAccent.withOpacity(0.7),fontSize: 20)),),
                    Text("Coronavirus",style: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.black.withOpacity(0.7),fontSize: 15)),),
                  ],
                ),
              ),
              Container(margin: EdgeInsets.symmetric(horizontal: 25,vertical: 15),padding: EdgeInsets.all(1),

                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Date",style: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.lightBlueAccent.withOpacity(0.7),fontSize: 20)),),
                    Text("22/07/2020",style: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.black.withOpacity(0.7),fontSize: 15)),),
                  ],
                ),
              ),
              Container(margin: EdgeInsets.symmetric(horizontal: 25,vertical: 15),padding: EdgeInsets.all(1),

                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Doctor Name",style: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.lightBlueAccent.withOpacity(0.7),fontSize: 20)),),
                    Text("Dr.Who",style: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.black.withOpacity(0.7),fontSize: 15)),),
                  ],
                ),
              ),
              Container(margin: EdgeInsets.symmetric(horizontal: 25,vertical: 15),padding: EdgeInsets.all(1),

                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Prescription",style: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.lightBlueAccent.withOpacity(0.7),fontSize: 20)),),
                    Text("Paracetamol",style: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.black.withOpacity(0.7),fontSize: 15)),),
                  ],
                ),
              ),
              Container(margin: EdgeInsets.symmetric(horizontal: 25,vertical: 15),padding: EdgeInsets.all(1),

                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Lab Report",style: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.lightBlueAccent.withOpacity(0.7),fontSize: 20)),),
                    Text("Report 2020",style: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.black.withOpacity(0.7),fontSize: 15)),),
                  ],
                ),
              ),


            ],),
          ),

        ],),
      ),
    );
  }
}
