

import 'dart:async';
import 'dart:math';

import 'package:claveto/image360/select_pain_point_page.dart';
import 'package:flutter/material.dart';

// Enum for rotation direction
enum RotationDirection { clockwise, anticlockwise }

class ImageView360 extends StatefulWidget {
  final List<AssetImage> imageList;
  final bool autoRotate, allowSwipeToRotate;
  final int rotationCount, swipeSensitivity;
  final Duration frameChangeDuration;
  final RotationDirection rotationDirection;
  final Function(int currentImageIndex) onImageIndexChanged;

  ImageView360({
    @required Key key,
    @required this.imageList,
    this.autoRotate = false,
    this.allowSwipeToRotate = true,
    this.rotationCount = 1,
    this.swipeSensitivity = 1,
    this.rotationDirection = RotationDirection.clockwise,
    this.frameChangeDuration = const Duration(milliseconds: 80),
    this.onImageIndexChanged,
  }) : super(key: key);

  @override
  _ImageView360State createState() => _ImageView360State();
}

class _ImageView360State extends State<ImageView360> {
  int rotationIndex, senstivity;
  int rotationCompleted = 0;
  double localPosition = 0.0;
  Function(int currentImageIndex) onImageIndexChanged;
  double _xCoordinateOfTap = 0;
  double _yCoordinateOfTap = 0;
  // int _indexOfImageTapped;
  double _mediaHeight;
  double _mediaWidth;
  bool _isDotSet;

  @override
  void initState() {
    _isDotSet = false;
    senstivity = widget.swipeSensitivity;
    // To bound the sensitivity range from 1-5
    if (senstivity < 1) {
      senstivity = 1;
    } else if (senstivity > 5) {
      senstivity = 5;
    }
    onImageIndexChanged = widget.onImageIndexChanged ?? (currentImageIndex) {};
    rotationIndex = widget.rotationDirection == RotationDirection.anticlockwise
        ? 0
        : (widget.imageList.length - 1);

    if (widget.autoRotate) {
      // To start the image rotation
      rotateImage();
    }
    super.initState();
  }

  _onTapDown(TapDownDetails details) {
    var x = details.globalPosition.dx;
    var y = details.globalPosition.dy;

    // or user the local position method to get the offset
    // print(details.localPosition);
    _xCoordinateOfTap = x;
    _yCoordinateOfTap = y;
    _isDotSet = true;
    // print("tap down " + x.toString() + ", " + y.toString());

    // print('_safeAreaHeight: $_safeAreaHeight');
  }

  _onTapUp(TapUpDetails details) {
    var x = details.globalPosition.dx;
    var y = details.globalPosition.dy;
    // or user the local position method to get the offset
    // print(details.localPosition);
    // print("tap up " + x.toString() + ", " + y.toString());
    print('Index of tapped image: $indexOfImageTapped');
    print('Screen height: $_mediaHeight | Screen width: $_mediaWidth');
    print(
        'X coordinate of tap: $_xCoordinateOfTap | Y coordinate of tap: $_yCoordinateOfTap ');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    _mediaHeight = MediaQuery.of(context).size.height;
    _mediaWidth = MediaQuery.of(context).size.width;
    // safeAreaHeight = MediaQuery.of(context).padding.top;

    return Column(
      children: <Widget>[
        Stack(
          children: [
            GestureDetector(
              // onTap: () => print(
              //     'Screen height: $_mediaHeight | Screen width: $_mediaWidth'),
              onTapDown: (TapDownDetails details) => _onTapDown(details),
              onTapUp: (TapUpDetails details) => _onTapUp(details),
              onHorizontalDragUpdate: (details) {
                if (_isDotSet) {
                  // If the user rotates the image, then remove the dot.
                  _xCoordinateOfTap = 0;
                  _yCoordinateOfTap = 0;
                  _isDotSet = false;
                }
                // Swipe check, if allowed then only will image move
                if (widget.allowSwipeToRotate) {
                  if (details.delta.dx > 0) {
                    handleRightSwipe(details);
                  } else if (details.delta.dx < 0) {
                    handleLeftSwipe(details);
                  }
                }
              },
              child: Image(
                image: widget.imageList[rotationIndex],
              ),
            ),
            Positioned(
              top: _yCoordinateOfTap - safeAreaHeight,
              left: _xCoordinateOfTap,
              child: Container(
                // margin: const EdgeInsets.symmetric(horizontal: 3),
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 10.0),
              child: Container(
                height: _mediaHeight * 0.1,
                width: _mediaWidth * 0.35,
                margin:  EdgeInsets.only(bottom: 30),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white.withOpacity(0.5)
                ),
                child: Center(
                  child: Text(
                    'Select the area of discomfort',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
        // SizedBox(
        //   height: 20.0,
        // ),
        // Text(
        //   'Use this touchpad to rotate the image',
        //   style: TextStyle(
        //     fontSize: 16.0,
        //   ),
        // ),
        // SizedBox(
        //   height: _mediaHeight * 0.02,
        // ),
        // Icon(
        //   Icons.arrow_downward,
        //   size: 40.0,
        // ),
        // SizedBox(
        //   height: _mediaHeight * 0.02,
        // ),
        // GestureDetector(
        //   // onHorizontalDragEnd: (details) {
        //   //   localPosition = 0.0;
        //   // },
        //   onHorizontalDragUpdate: (details) {
        //     if (_isDotSet) {
        //       // If the user rotates the image, then remove the dot.
        //       _xCoordinateOfTap = 0;
        //       _yCoordinateOfTap = 0;
        //       _isDotSet = false;
        //     }
        //     // Swipe check, if allowed then only will image move
        //     if (widget.allowSwipeToRotate) {
        //       if (details.delta.dx > 0) {
        //         handleRightSwipe(details);
        //       } else if (details.delta.dx < 0) {
        //         handleLeftSwipe(details);
        //       }
        //     }
        //   },
        //   // child: Image(image: widget.imageList[rotationIndex]),
        //   child: Container(
        //     height: _mediaHeight * 0.08,
        //     width: _mediaWidth * 0.8,
        //     color: Colors.green[100],
        //   ),
        // ),
        // SizedBox(
        //   height: _mediaHeight * 0.02,
        // ),
      ],
    );
  }

  void rotateImage() async {
    // Check for rotationCount

    if (rotationCompleted < widget.rotationCount) {
      // Frame change duration logic
      await Future.delayed(widget.frameChangeDuration);

      if (mounted) {
        setState(() {
          if (widget.rotationDirection == RotationDirection.anticlockwise) {
            // Logic to bring the frame to initial position on cycle complete in positive direction
            if (rotationIndex < widget.imageList.length - 1) {
              rotationIndex--;
            } else {
              rotationCompleted++;
              rotationIndex = 0;
            }
          } else {
            // Logic to bring the frame to initial position on cycle complete in negative direction
            if (rotationIndex > 0) {
              rotationIndex++;
            } else {
              rotationCompleted++;
              rotationIndex = widget.imageList.length - 1;
            }
          }
        });

        onImageIndexChanged(rotationIndex);
      }

      //Recursive call
      rotateImage();
    }
  }

  void handleRightSwipe(DragUpdateDetails details) {
    int originalindex = rotationIndex;
    if ((localPosition +
            (pow(4, (6 - senstivity)) / (widget.imageList.length))) <=
        details.localPosition.dx) {
      rotationIndex = rotationIndex + 1;
      localPosition = details.localPosition.dx;
    }
    // Check to ignore rebuild of widget is index is same
    if (originalindex != rotationIndex) {
      setState(() {
        if (rotationIndex < widget.imageList.length - 1) {
          rotationIndex = rotationIndex;
        } else {
          rotationIndex = 0;
        }
      });
      onImageIndexChanged(rotationIndex);
    }
  }

  void handleLeftSwipe(DragUpdateDetails details) {
    double distancedifference = (details.localPosition.dx - localPosition);
    int originalindex = rotationIndex;
    if (distancedifference < 0) {
      distancedifference = (-distancedifference);
    }
    if (distancedifference >=
        (pow(4, (6 - senstivity)) / (widget.imageList.length))) {
      rotationIndex = rotationIndex - 1;
      localPosition = details.localPosition.dx;
    }
    // Check to ignore rebuild of widget is index is same
    if (originalindex != rotationIndex) {
      setState(() {
        if (rotationIndex > 0) {
          rotationIndex = rotationIndex;
        } else {
          rotationIndex = widget.imageList.length - 1;
        }
      });
      onImageIndexChanged(rotationIndex);
    }
  }
}
