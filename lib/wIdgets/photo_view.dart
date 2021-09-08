import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'dart:io' as io;
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class ViewZoomPhoto extends StatefulWidget {
  final String url;

  const ViewZoomPhoto({Key key, this.url}) : super(key: key);

  @override
  _ViewZoomPhotoState createState() => _ViewZoomPhotoState();
}

class _ViewZoomPhotoState extends State<ViewZoomPhoto> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.download_rounded),
            onPressed: (){
              // todo change it to report name
               downloadFile(widget.url, DateTime.now().toString(), 'jpg');
            },
          )
        ],
      ),
      body: Container(
          child: PhotoView(
            imageProvider: NetworkImage(widget.url),
          )
      ),
    );
  }
  String progressString = '0%';
  var progressValue = 0.0;

Future<void> downloadFile(
    String url, String fileName, String extension) async {
  var dio = new Dio();
  PermissionStatus status = await PermissionHandler().checkPermissionStatus(PermissionGroup.storage);
  if (status.value!=2) {
    await PermissionHandler().requestPermissions([PermissionGroup.storage]);
  }

  var dir = await getExternalStorageDirectory();
  //final dir = await getTemporaryDirectory();
  var knockDir =
  await new Directory('/storage/emulated/0/Clavato/Reports').create(recursive: true);
  print("Hello checking the file in Externaal Sorage");
  io.File('${knockDir.path}/$fileName.$extension').exists().then((a) async {
    print(a);
    if (a) {
      print("Opening file");
      showDialog(context: context,builder: (_){return AlertDialog(
        title: Text('File is already downloaded'),
        // actions: <Widget>[
        //   RaisedButton(child: Text('Open'), onPressed: () {
        //     // TODO write your function to open file
        //     Navigator.pop(context);
        //   })
        // ],
      );});
      return;
    } else {
      print("Downloading file");
      openDialog();
      await dio.download(url, '${knockDir.path}/$fileName.$extension',
          onReceiveProgress: (rec, total) {
            if (mounted) {
              setState(() {
                progressValue = (rec / total);
                progressString = ((rec / total) * 100).toStringAsFixed(0) + "%";
                myDialogState.setState(() {
                  myDialogState.progressData = progressString;
                  myDialogState.progressValue = progressValue;
                });
              });
            }
          });
      if (mounted) {
        setState(() {
          print('${knockDir.path}');
          // TODO write your function to open file
        });
      }
      print("Download completed");
    }
  });
}

openDialog() {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return MyDialog();
    },
  );
}
}


_MyDialogState myDialogState;

class MyDialog extends StatefulWidget {
  @override
  _MyDialogState createState() {
    myDialogState = _MyDialogState();
    return myDialogState;
  }
}

class _MyDialogState extends State<MyDialog> {
  String progressData = '0%';
  var progressValue=0.0;
  @override
  Widget build(BuildContext context) {
    print(progressValue);
    return AlertDialog(
      content: LinearProgressIndicator(
        value: progressValue,
        backgroundColor: Colors.red,
      ),
      title: Text(progressData),
      actions: <Widget>[
        progressValue==1.0?ElevatedButton(child: Text('File Downloaded'), onPressed: () {
          
          Navigator.pop(context);
        }):Container()
      ],
    );
  }
}
