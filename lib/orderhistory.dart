import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderHistory extends StatefulWidget {
  @override
  _OrderHistoryState createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("My Orders",style:GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.white,fontSize: 20)),),
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
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Container(margin: EdgeInsets.symmetric(horizontal: 20,vertical: 5),padding: EdgeInsets.all(5),
            child: Text("Current Order",textAlign: TextAlign.left,
                style: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.lightBlueAccent.withOpacity(0.7),fontSize: 20))),),
          Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20,vertical: 15),padding: EdgeInsets.all(15),
                width:MediaQuery.of(context).size.width ,

                decoration:BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey.withOpacity(0.3),width: 2),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(margin: EdgeInsets.all(10),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage('https://www.w3schools.com/howto/img_avatar.png',),radius: 50,
                          ),
                        ),
                        Column(
                          children: [
                            Container(margin: EdgeInsets.symmetric(horizontal: 5,vertical: 0),
                                child: Text('Dr.Jason Derulo',style: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.lightBlueAccent.withOpacity(0.7),fontSize: 20)))),
                            Container(margin: EdgeInsets.symmetric(horizontal: 5,vertical: 1),
                                child: Text('BMS, MD',style: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.black,fontSize: 15)))),

                            Container(margin: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                                child: Text('Smart Tech',style: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.black,fontSize: 15)))),
                            Container(margin: EdgeInsets.symmetric(horizontal: 5,vertical: 0),
                                child: Text('BMS, MD',style: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.black,fontSize: 12)))),
                          ],
                        ),


                      ],),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(margin: EdgeInsets.all(5),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.calendar_today,color:Colors.lightBlueAccent.withOpacity(0.5) ,),
                              Text("   Appointments, date",style:GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.black.withOpacity(0.7),fontSize: 12)),),
                            ],),),
                        Container(margin: EdgeInsets.all(5),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.access_time,color:Colors.lightBlueAccent.withOpacity(0.5) ,),
                              Text("  11:30 A.M",style:GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.black.withOpacity(0.7),fontSize: 12)),),
                            ],),)
                      ],
                    ),

                  ],
                ),
              ),
            ],
          ),



            Container(margin: EdgeInsets.symmetric(horizontal: 20,vertical: 5),padding: EdgeInsets.all(5),
              child: Text("Order History",textAlign: TextAlign.left,
                  style: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.lightBlueAccent.withOpacity(0.7),fontSize: 20))),),
            Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20,vertical: 15),padding: EdgeInsets.all(15),
                  width:MediaQuery.of(context).size.width ,

                  decoration:BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey.withOpacity(0.3),width: 2),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(margin: EdgeInsets.all(10),
                            child: CircleAvatar(
                              backgroundImage: NetworkImage('https://www.w3schools.com/howto/img_avatar.png',),radius: 50,
                            ),
                          ),
                          Column(
                            children: [
                              Container(margin: EdgeInsets.symmetric(horizontal: 5,vertical: 0),
                                  child: Text('Dr.Jason Derulo',style: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.lightBlueAccent.withOpacity(0.7),fontSize: 20)))),
                              Container(margin: EdgeInsets.symmetric(horizontal: 5,vertical: 1),
                                  child: Text('BMS, MD',style: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.black,fontSize: 15)))),

                              Container(margin: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                                  child: Text('Smart Tech',style: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.black,fontSize: 15)))),
                              Container(margin: EdgeInsets.symmetric(horizontal: 5,vertical: 0),
                                  child: Text('BMS, MD',style: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.black,fontSize: 12)))),
                            ],
                          ),


                        ],),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(margin: EdgeInsets.all(5),
                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(Icons.calendar_today,color:Colors.lightBlueAccent.withOpacity(0.5) ,),
                                Text("   Appointments, date",style:GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.black.withOpacity(0.7),fontSize: 12)),),
                              ],),),
                          Container(margin: EdgeInsets.all(5),
                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(Icons.access_time,color:Colors.lightBlueAccent.withOpacity(0.5) ,),
                                Text("  11:30 A.M",style:GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.black.withOpacity(0.7),fontSize: 12)),),
                              ],),)
                        ],
                      ),

                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20,vertical: 15),padding: EdgeInsets.all(15),
                  width:MediaQuery.of(context).size.width ,

                  decoration:BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey.withOpacity(0.3),width: 2),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(margin: EdgeInsets.all(10),
                            child: CircleAvatar(
                              backgroundImage: NetworkImage('https://www.w3schools.com/howto/img_avatar.png',),radius: 50,
                            ),
                          ),
                          Column(
                            children: [
                              Container(margin: EdgeInsets.symmetric(horizontal: 5,vertical: 0),
                                  child: Text('Dr.Jason Derulo',style: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.lightBlueAccent.withOpacity(0.7),fontSize: 20)))),
                              Container(margin: EdgeInsets.symmetric(horizontal: 5,vertical: 1),
                                  child: Text('BMS, MD',style: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.black,fontSize: 15)))),

                              Container(margin: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                                  child: Text('Smart Tech',style: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.black,fontSize: 15)))),
                              Container(margin: EdgeInsets.symmetric(horizontal: 5,vertical: 0),
                                  child: Text('BMS, MD',style: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.black,fontSize: 12)))),
                            ],
                          ),


                        ],),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(margin: EdgeInsets.all(5),
                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(Icons.calendar_today,color:Colors.lightBlueAccent.withOpacity(0.5) ,),
                                Text("   Appointments, date",style:GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.black.withOpacity(0.7),fontSize: 12)),),
                              ],),),
                          Container(margin: EdgeInsets.all(5),
                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(Icons.access_time,color:Colors.lightBlueAccent.withOpacity(0.5) ,),
                                Text("  11:30 A.M",style:GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.black.withOpacity(0.7),fontSize: 12)),),
                              ],),)
                        ],
                      ),

                    ],
                  ),
                ),
              ],
            ),


        ],),
      ),
    );
  }
}
