import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}


class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Chat",style:GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.white,fontSize: 20)),),
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
      Stack(
        children: [

          SingleChildScrollView(
            child: Column(
              children: [


                Column(
                  children: [
                    Container(alignment: Alignment.centerLeft,

                      margin: EdgeInsets.fromLTRB(10, 30, 30, 30),
                      child:Card(elevation: 15,color: Colors.transparent,
                          child: Container(padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              child: Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",style:GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.black.withOpacity(0.7),fontSize:15)),))),
                    ),
                    Container(alignment: Alignment.centerRight,


                      margin: EdgeInsets.fromLTRB(30, 30, 10, 30),
                      child:Card(elevation: 15,color: Colors.transparent,
                          child: Container(padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              child: Text("But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, and expound the actual teachings of the great explorer of the truth, the master-builder of human happiness. No one rejects, dislikes, or avoids pleasure itself, because it is pleasure, but because those who do not know how to pursue pleasure rationally encounter consequences that are extremely painful. Nor again is there anyone who loves or pursues or desires to obtain pain of itself, because it is pain, but because occasionally circumstances occur in which toil and pain can procure him some great pleasure. To take a trivial example, which of us ever undertakes laborious physical exercise, except to obtain some advantage from it? But who has any right to find fault with a man who chooses to enjoy a pleasure that has no annoying consequences, or one who avoids a pain that produces no resultant pleasure?",style:GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.black.withOpacity(0.7),fontSize: 15)),))),
                    ),
                  ],
                ),


              ],
            ),
          ),
          Container(

            margin: EdgeInsets.only(top:643,left: 10,right: 10,bottom: 10),

            child: Row(
              children: <Widget>[
                Material(
                  child: new Container(
                    margin: new EdgeInsets.symmetric(horizontal: 1.0),
                    child: new IconButton(
                      icon: new Icon(Icons.attach_file),

                    ),
                  ),
                  color: Colors.transparent,
                ),

                // Text input
                Flexible(
                  child: Container(
                    child: TextField(
                      style: TextStyle( fontSize: 15.0),

                      decoration: InputDecoration.collapsed(
                        hintText: 'Type a message',
                        hintStyle: TextStyle(),
                      ),
                    ),
                  ),
                ),

                // Send Message Button
                Material(
                  child: new Container(
                    margin: new EdgeInsets.symmetric(horizontal: 8.0),
                    child: new IconButton(
                      icon: new Image.asset('assets/chatsend.png'),
                      onPressed: () => {},

                    ),
                  ),
                  color: Colors.transparent,
                ),
              ],
            ),
            width: double.infinity,
            height: 55.0,

            decoration: new BoxDecoration(
                border: Border.all(color: Colors.blueAccent),
                borderRadius: BorderRadius.circular(35),
                color: Colors.white),
          ),
        ],
      ),
    );
  }
}
