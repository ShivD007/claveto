import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:claveto/chat/chat.dart';
import 'package:claveto/common/constant.dart';
import 'package:claveto/model/part.dart';
import 'package:claveto/wIdgets/imageview360.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:claveto/chatscreen.dart';
import 'package:claveto/chat/chatScreen.dart';
double safeAreaHeight;
int indexOfImageTapped;


class SelectPainPointPage extends StatefulWidget {
  SelectPainPointPage({Key key, @required this.part}) : super(key: key);

  final Part part;

  @override
  _SelectPainPointPageState createState() => _SelectPainPointPageState();
}

class _SelectPainPointPageState extends State<SelectPainPointPage> {
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
  double _safeAreaHeight;

  @override
  void initState() {
    //* To load images from assets after first frame build up.

    WidgetsBinding.instance.addPostFrameCallback(
        (_) => updateImageList(context: context, part: widget.part));
    super.initState();
  }

  GlobalKey _globalKey = new GlobalKey();
  ui.Image image1;

  Future<Uint8List> _capturePng() async {
    try {
      print('inside');
      RenderRepaintBoundary boundary =
          _globalKey.currentContext.findRenderObject();
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);

      ByteData byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      var pngBytes = byteData.buffer.asUint8List();
      var bs64 = base64Encode(pngBytes);
      print(pngBytes);
      print(bs64);
      rawPath = pngBytes;
      Route route = MaterialPageRoute(
          builder: (_) => Chat(
                peerId: cachedPeerId,
                userID: cachedUsedId,
            id: cachedId,
            patientName: cachedPatientName,
            uint8list: pngBytes,
              ));
      Navigator.push(context, route);

      setState(() {});
      return pngBytes;
    } catch (e) {
      print(e);
    }
  }

  var rawPath;

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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // rawPath==null?Text('No Image'):Image.memory(rawPath),
                //

                (imagePrecached)
                    ? RepaintBoundary(
                        key: _globalKey,
                        child: ImageView360(
                          key: UniqueKey(),
                          imageList: imageList,
                          // autoRotate: autoRotate,
                          autoRotate: false,
                          rotationCount: rotationCount,
                          rotationDirection: RotationDirection.clockwise,
                          frameChangeDuration: Duration(milliseconds: 30),
                          swipeSensitivity: swipeSensitivity,
                          allowSwipeToRotate: allowSwipeToRotate,
                          onImageIndexChanged: (currentImageIndex) {
                            print('On image changed $imagePrecached');
                            indexOfImageTapped = currentImageIndex;
                            print("currentImageIndex: $indexOfImageTapped");
                          },
                        ),
                      )
                    : Text("Pre-Caching images..."),
                !widget.part.heroTag.contains('fullBody')
                    ?
                          Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width*0.95,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Color(0xff14B4A5),
                                    Color(0xff3883EF),
                                  ],
                                ),
                              ),
                              child: InkWell(

                        onTap: () {
                              _capturePng();
                        },
                        child: Center(child: Text('Pick'))),

                            ),
                          )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void updateImageList({BuildContext context, Part part}) async {
    for (int i = 0; i < part.numOfImages; i++) {
      print('Index $i');
      imageList.add(
          AssetImage( '$i.png'));

      //* To precache images so that when required they are loaded faster.
      await precacheImage(
          AssetImage( '$i.png'),
          context);
    }
    setState(() {
      print('Prechached $imagePrecached');
      imagePrecached = true;
    });
  }
}
