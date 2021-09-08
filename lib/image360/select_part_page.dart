
import 'package:claveto/image360/select_pain_point_page.dart';
import 'package:claveto/model/part.dart';
import 'package:claveto/wIdgets/imageview360.dart';
import 'package:flutter/material.dart';

double safeAreaHeight;
int indexOfImageTapped;

class SelectPartPage extends StatefulWidget {
  @override
  _SelectPartPageState createState() => _SelectPartPageState();
}

class _SelectPartPageState extends State<SelectPartPage> {
  List<AssetImage> imageList = List<AssetImage>();
  bool autoRotate = true;
  int rotationCount = 2;
  int swipeSensitivity = 2;
  bool allowSwipeToRotate = true;
  RotationDirection rotationDirection = RotationDirection.anticlockwise;
  Duration frameChangeDuration = Duration(milliseconds: 50);
  bool imagePrecached = false;

  double _mediaHeight;
  double _mediaWidth;

  // @override
  // void initState() {
  //   //* To load images from assets after first frame build up.
  //   WidgetsBinding.instance
  //       .addPostFrameCallback((_) => updateImageList(context));
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    _mediaHeight = MediaQuery.of(context).size.height;
    _mediaWidth = MediaQuery.of(context).size.width;
    safeAreaHeight = MediaQuery.of(context).padding.top;
    print('_safeAreaHeight: $safeAreaHeight');

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              // color: Colors.green[100],
              height: _mediaHeight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SelectPainPointPage(
                          part: fullBody,
                        ),
                      ),
                    ),
                    child: Container(
                      // color: Colors.red[100],
                      child: Image.asset(
                        'assets/head.jpg',
                        height: _mediaHeight * 0.1,
                        width: _mediaWidth * 0.15,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SelectPainPointPage(
                          part: head,
                        ),
                      ),
                    ),
                    child: Container(
                      // color: Colors.red[100],
                      child: Image.asset(
                        'assets/head.jpg',
                        height: _mediaHeight * 0.1,
                        width: _mediaWidth * 0.15,
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   height: _mediaHeight * 0.02,
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SelectPainPointPage(
                              part: leftArm,
                            ),
                          ),
                        ),
                        child: Container(
                          // color: Colors.red[100],
                          child: Image.asset(
                            'assets/right_arm.png',
                            height: _mediaHeight * 0.2,
                            width: _mediaWidth * 0.15,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      // SizedBox(
                      //   width: _mediaWidth * 0.04,
                      // ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SelectPainPointPage(
                              part: torso,
                            ),
                          ),
                        ),
                        child: Container(
                          // color: Colors.red[100],
                          child: Image.asset(
                            'assets/torso.png',
                            height: _mediaHeight * 0.2,
                            width: _mediaWidth * 0.3,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      // SizedBox(
                      //   width: _mediaWidth * 0.04,
                      // ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SelectPainPointPage(
                              part: rightArm,
                            ),
                          ),
                        ),
                        child: Container(
                          // color: Colors.red[100],
                          child: Image.asset(
                            'assets/left_arm.jpg',
                            height: _mediaHeight * 0.2,
                            width: _mediaWidth * 0.15,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // SizedBox(
                  //   height: _mediaHeight * 0.02,
                  // ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SelectPainPointPage(
                          part: legs,
                        ),
                      ),
                    ),
                    child: Container(
                      // color: Colors.red[100],
                      child: Image.asset(
                        'assets/legs.jpg',
                        height: _mediaHeight * 0.2,
                        width: _mediaWidth * 0.5,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // void updateImageList(BuildContext context) async {
  //   for (int i = 0; i <= 8; i++) {
  //     imageList.add(AssetImage('assets/right_arm/$i.png'));
  //  +   //* To precache images so that when required they are loaded faster.
  //     await precacheImage(AssetImage('assets/right_arm/$i.png'), context);
  //   }
  //   setState(() {
  //     imagePrecached = true;
  //   });
  // }
}
