import 'package:claveto/model/part.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'select_pain_point_page.dart';

class FullBodyPage extends StatefulWidget {
  @override
  _FullBodyPageState createState() => _FullBodyPageState();
}

class _FullBodyPageState extends State<FullBodyPage> {
  double screenHeight,screenWidth;
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Stack(
        children: [
          SelectPainPointPage(
            part: fullBody,
          ),

          Positioned(
            left: 10,
            top: screenHeight*.50,
            child: Container(margin:  EdgeInsets.only(bottom: 30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white.withOpacity(0.5)
              ),
              child: FlatButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SelectPainPointPage(
                        part: rightArm,
                      ),
                    ),
                  );
                },
                child: Text('Right Arm'),
              ),
            ),
          ),
          Positioned(
            right: 10,
            top: screenHeight*.50,
            child: Container(
              margin:  EdgeInsets.only(bottom: 30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white.withOpacity(0.5)
              ),
              child: FlatButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SelectPainPointPage(
                        part: leftArm,
                      ),
                    ),
                  );
                },
                child: Text('Left Arm'),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding:  EdgeInsets.only(top: 30),
              child: Container(margin:  EdgeInsets.only(bottom: 30),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white.withOpacity(0.5)
                ),
                child: FlatButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SelectPainPointPage(
                          part: head,
                        ),
                      ),
                    );
                  },
                  child: Text('Head'),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              
              margin:  EdgeInsets.only(bottom: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white.withOpacity(0.5)
              ),
              child: FlatButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SelectPainPointPage(
                        part: legs,
                      ),
                    ),
                  );
                },
                child: Text('Legs'),
              ),
            ),
          ),
          Center(
            child: Container(
              margin:  EdgeInsets.only(bottom: 30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white.withOpacity(0.5)
              ),
              child: FlatButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SelectPainPointPage(
                        part: torso,
                      ),
                    ),
                  );
                },
                child: Text('Torso'),
              ),
            ),
          )


        ],
      ),
    );
  }
}
