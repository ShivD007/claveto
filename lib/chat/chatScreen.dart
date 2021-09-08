import 'dart:typed_data';
import 'package:claveto/appointments.dart';
import 'package:claveto/image360/full_body_page.dart';
import 'package:claveto/wIdgets/myMessageBox.dart';
import 'package:claveto/wIdgets/peerMessageBox.dart';
import 'package:path/path.dart';
import 'dart:io';

import 'package:claveto/common/colors.dart';
import 'package:claveto/config/config.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

List<Asset> images1 = <Asset>[];
List<Asset> imagesTemp = <Asset>[];
List<String> imageUrls = <String>[];

String cachedUsedId, cachedPeerId, cachedId, cachedPatientName;

class ChatScreen extends StatefulWidget {
  final String adminId, userID, id;
  final Uint8List uint8list;
  final String pateintName;
  final bool isCompleted;

  ChatScreen(
      {Key key,
      @required this.userID,
      @required this.adminId,
      this.uint8list,
      this.isCompleted,
      this.id,
      this.pateintName})
      : super(key: key);

  @override
  State createState() => new ChatScreenState(adminId: adminId, userID: userID);
}

class ChatScreenState extends State<ChatScreen> with WidgetsBindingObserver {
  ChatScreenState({Key key, @required this.adminId, @required this.userID});

  bool isUploading = false, isLoading;
  String adminId, userID, groupChatId, imageUrl;
  File pdfFile, videoFile;

  var listMessage;
  int currentPageIndex = 0;
  File imageFile;
  final TextEditingController textEditingController = TextEditingController();
  final ScrollController listScrollController = ScrollController();
  final FocusNode focusNode = FocusNode();
  PageController _pageController, p2;
  List<String> _timeOfUploading = <String>[];

  Uint8List imageOfBodyPart;

  @override
  void initState() {
    super.initState();
    focusNode.addListener(onFocusChange);
    WidgetsBinding.instance.addObserver(this);
    _pageController = PageController();
    p2 = PageController();
    groupChatId = '';
    isLoading = false;
    imageUrl = '';
    readLocal();
    imageOfBodyPart = widget.uint8list;
  } //initState()

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.detached:
        print('detached');
        break;
      case AppLifecycleState.resumed:
        //readLocal();
        print('resumed');
        break;
      case AppLifecycleState.inactive:
        print('inactive');
        break;
      case AppLifecycleState.paused:
        // ChatApp.firestore
        //     .collection(ChatApp.collectionUser)
        //     .doc(userID)
        //     .update({ChatApp.userChattingWith: null});
        print('paused');
        break;
    }
  }

  void onFocusChange() {
    if (focusNode.hasFocus) {}
  }

  readLocal() async {
    //id = ChatApp.sharedPreferences.getString("Uid") ?? "";
    if (int.parse(userID) >= int.parse(adminId)) {
      groupChatId = '$userID-$adminId';
    } else {
      groupChatId = '$adminId-$userID';
    }
    print('Group Chat ID $groupChatId');
    if (widget.userID != null) {
      cachedUsedId = widget.userID;
      cachedPeerId = widget.adminId;
      cachedId = widget.id;
      cachedPatientName = widget.pateintName;
    }
    if (ChatApp.sharedPreferences.getBool(
              '${widget.adminId}z',
            ) ==
            null ||
        ChatApp.sharedPreferences.getBool(
          '${widget.adminId}z',
        )) {
      Firestore.instance
          .collection(ChatApp.collectionMessage)
          .document(groupChatId)
          .set({
        'pateint_name': widget.pateintName,
        'doctor_id': widget.adminId,
        'last_message_time': DateTime(1900).millisecondsSinceEpoch.toString(),
      }).then((value) {
        print('Setting pateint name');
        ChatApp.sharedPreferences.setBool('${widget.adminId}z', false);
      });
    }
    if (ChatApp.sharedPreferences.getBool(
      '${widget.id}x',
    )) {
      onSendMessage('Welcome message by  doctor ask what to write', 0)
          .then((value) {
        print('Is this code working?');
        ChatApp.sharedPreferences.setBool('${widget.id}x', false);
      });
    }
    print('Is this code working?2');
    // ChatApp.firestore
    //     .collection(ChatApp.collectionUser)
    //     .doc(userID)
    //     .update({ChatApp.userChattingWith: adminId});
    // setState((){});
  }

  Future<void> onSendMessage(String content, int type,
      [String time, bool updating = true]) async {
    print('Dste $time');
    String dateTime = time ?? DateTime.now().millisecondsSinceEpoch.toString();
    // type: 0 = text, 1 = image, 2 = sticker
    if (content.trim() != '') {
      textEditingController.clear();

      var documentReference = Firestore.instance
          .collection(ChatApp.collectionMessage)
          .document(groupChatId)
          .collection(groupChatId)
          .document(dateTime);
      print(
          'IDPreference2 ${ChatApp.sharedPreferences.getBool('${widget.id}x')}');
      String idFrom = ChatApp.sharedPreferences.getBool(
            '${widget.id}x',
          )
              ? adminId
              : userID,
          idTo = ChatApp.sharedPreferences.getBool(
            '${widget.id}x',
          )
              ? userID
              : adminId;
      print('IF FROm : $idFrom IDTO: $idTo IDS');
      Firestore.instance.runTransaction((transaction) async {
        await transaction.set(
          documentReference,
          {
            UserMessage.idFrom: idFrom,
            // ChatApp.sharedPreferences
            //     .getBool('${widget.id}x',)?adminId:userID,
            UserMessage.idTo: idTo,
            // ChatApp.sharedPreferences
            //     .getBool('${widget.id}x',)?userID:adminId,
            UserMessage.timestamp: dateTime,
            UserMessage.content: content,
            UserMessage.type: type
          },
        );

        Firestore.instance
            .collection(ChatApp.collectionMessage)
            .document(groupChatId)
            .update({
          'last_message_time': dateTime,
        });
      }).catchError((e) {
        print("Eroor strart");
        print(e.toString());
      });

      //response(content);
      //pateint_name
      ChatApp.sharedPreferences.setBool('${widget.id}x', false);
      print(
          'IDPreference ${ChatApp.sharedPreferences.getBool('${widget.id}x')}');
      if (listScrollController.hasClients) {
        listScrollController.animateTo(0.0,
            duration: Duration(milliseconds: 300), curve: Curves.easeOut);
      }
      try {} catch (e) {
        print('Error ${e.toString()}');
      }
    } else {
      print(content);
      //Fluttertoast.showToast(msg: 'Nothing to send');
    }
  }

  Future<bool> onBackPress(BuildContext context) {
    print('Backing...');
    Route newRoute = MaterialPageRoute(builder: (_) => AppointmentsScreen());
    Navigator.pushReplacement(
      context,
      newRoute,
    );

    // ChatApp.firestore
    //     .collection(ChatApp.collectionUser)
    //     .document(userID)
    //     .updateData({ChatApp.userChattingWith: null});
    //     Navigator.pop(context);
    return Future.value(false);
  }

  Future<dynamic> postImage(Asset imageFile) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    StorageReference reference = FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask =
        reference.putData((await imageFile.getByteData()).buffer.asUint8List());
    StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
    print(storageTaskSnapshot.ref.getDownloadURL());
    return storageTaskSnapshot.ref.getDownloadURL();
  }

  Future<dynamic> uploadUint8ListImageOnFirebase(Uint8List imageFile) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    StorageReference reference = FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = reference.putData((imageFile));
    StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
    print(storageTaskSnapshot.ref.getDownloadURL());
    return storageTaskSnapshot.ref.getDownloadURL();
  }

  Future<dynamic> postFileAndGetDownloadUrl(File file) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    StorageReference reference = FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask =
        reference.putData((await file.readAsBytes()));
    StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
    print(storageTaskSnapshot.ref.getDownloadURL());
    return storageTaskSnapshot.ref.getDownloadURL();
  }

  sendFileMessage(int fileType, String fileTypeInString, File file) async {
    print('start');
    String time = DateTime.now().millisecondsSinceEpoch.toString();
    onSendMessage(fileTypeInString, fileType, time, false);
    String url = await postFileAndGetDownloadUrl(file);
    print(url);
    onSendMessage(url, fileType, time, true);
    setState(() {
      pdfFile = null;
      videoFile = null;
    });
  }

  uploadPartOfImage() async {
    String time = DateTime.now().millisecondsSinceEpoch.toString();

    onSendMessage('Image', 1, time, false);
    String downloadUrl = await uploadUint8ListImageOnFirebase(imageOfBodyPart);
    onSendMessage(downloadUrl, 1, time, true);
    setState(() {
      imageOfBodyPart = null;
    });
  }

  void uploadImages() async {
    images1.forEach((f) {
      String time = DateTime.now().millisecondsSinceEpoch.toString();
      onSendMessage('Image', 1, time, false);
      _timeOfUploading.add(time);
      if (_timeOfUploading.length == images1.length) {
        setState(() {
          //images = [];
          //imageUrls = [];
          imagesTemp = [];
          //_timeOfUploading=[];
          isUploading = false;
        });
      }
    });

    print('opploading......');

    images1.forEach((imageFile) {
      postImage(imageFile).then((downloadUrl) {
        onSendMessage(downloadUrl, 1, _timeOfUploading[imageUrls.length], true);
        imageUrls.add(downloadUrl.toString());
        if (imageUrls.length == images1.length) {
          setState(() {
            images1 = [];
            imageUrls = [];
            _timeOfUploading = [];
            isUploading = false;
          });
        }
      }).catchError((err) {
        print(err);
      });
    });
  }

  Future loadAssets() async {
    print('d');
    List<Asset> resultList = List<Asset>();

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 10,
        enableCamera: true,
        selectedAssets: images1,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Upload Image",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {}
    if (!mounted) return;
    setState(() {
      images1 = resultList;
      imagesTemp = resultList;
      // _error = error;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Container(
        color: background1,
        width: MediaQuery.of(context).size.height,
        child: Column(
          children: <Widget>[
            // List of messages
            buildListMessage(),

            (imagesTemp.length == 0)
                ? Container()
                : Container(
                    height: 100,
                    child: buildGridView(),
                  ),
            (imageOfBodyPart == null) ? Container() : buildBodyPartImage(),
            (pdfFile == null)
                ? Container()
                : Container(
                    height: 100,
                    child: Column(
                      children: <Widget>[
                        RaisedButton(
                          onPressed: () {
                            sendFileMessage(2, 'pdf', pdfFile);
                          },
                          child: Text('Send PDF'),
                        ),
                        Text('PDF ${basename(pdfFile.path)}'),
                      ],
                    ),
                  ),
            (videoFile == null)
                ? Container()
                : Container(
                    height: 100,
                    child: Column(
                      children: <Widget>[
                        RaisedButton(
                          onPressed: () {
                            sendFileMessage(3, 'video', videoFile);
                          },
                          child: Text('Send Video'),
                        ),
                        Text('Video ${basename(videoFile.path)}'),
                      ],
                    ),
                  ),
            !(imagesTemp.length != 0 || imageOfBodyPart != null)
                ? buildInput(context)
                : buildSendImage(),
          ],
        ),
      ),
      onWillPop: () => onBackPress(context),
    );
  }

  Widget buildBodyPartImage() {
    return Container(
      height: 100,
      width: 100,
      child: Image.memory(imageOfBodyPart),
    );
  }

  Widget buildGridView() {
    return GridView.count(
      scrollDirection: Axis.horizontal,
      crossAxisCount: 1,
      controller: p2,
      addAutomaticKeepAlives: true,
      children: List.generate(images1.length, (index) {
        Asset asset = images1[index];
        print(asset.getByteData(quality: 100));
        return Padding(
          padding: EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              _pageController.jumpToPage(index);
            },
            child: Container(
//              decoration: currentPageIndex == index
//                  ? BoxDecoration(
//                      color: Colors.black,
//                      border: Border.all(
//                        width: 2,
//                        color: Colors.red,
//                      ),
//                    )
//                  : null,
              child: AssetThumb(
                asset: asset,
                width: 300,
                height: 300,
                quality: 50,
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget buildItem(int index, DocumentSnapshot document) {
    print('snapshot ${document.data()['idFrom']}');
    if (document.data()[UserMessage.idFrom] == userID) {
      // Right (my message)
      return MyMessages(
        document: document,
        index: index,
        id: userID,
        listMessage: listMessage,
      );
    } else {
      // Left (peer message)
      return PeerMessageBox(
        document: document,
        index: index,
        id: userID,
        listMessage: listMessage,
      );
    }
  }

  Widget buildListMessage() {
    return Flexible(
      child: groupChatId == ''
          ? Center(
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(themeColor)))
          : StreamBuilder<QuerySnapshot>(
              stream: ChatApp.firestore
                  .collection(ChatApp.collectionMessage)
                  .doc(groupChatId)
                  .collection(groupChatId)
                  .orderBy(UserMessage.timestamp, descending: true)
                  .limit(1000)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                      child: Icon(
                    Icons.blur_circular,
                    color: Colors.red,
                  ));
                } else {
                  listMessage = snapshot.data.docs;
                  //listMessage = snapshot.data.documents;
                  return ListView.builder(
                    padding: EdgeInsets.all(10.0),
                    itemBuilder: (context, index) =>
                        buildItem(index, snapshot.data.documents[index]),
                    itemCount: snapshot.data.documents.length,
                    reverse: true,
                    controller: listScrollController,
                  );
                }
              },
            ),
    );
  }

  Widget buildLoading() {
    return Positioned(
      child: isLoading
          ? Container(
              child: Center(
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(themeColor)),
              ),
              color: Colors.white.withOpacity(0.8),
            )
          : Container(),
    );
  }

  Widget buildInput(BuildContext context) {
    return widget.isCompleted ?? true
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(child: Text('Cannot send message')),
          )
        : Container(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: new EdgeInsets.symmetric(horizontal: 1.0),
                      child: new IconButton(
                          icon: new Icon(
                            Icons.image,
                            color: Colors.blue,
                          ),
                          onPressed: () async {
                            if (await checkAndRequestCameraPermissions()) {
                              loadAssets();
                            }
                          }),
                    ),
                    Container(
                      margin: new EdgeInsets.symmetric(horizontal: 1.0),
                      child: new IconButton(
                          icon: new Icon(
                            Icons.attach_file,
                            color: Colors.blue,
                          ),
                          onPressed: () async {
                            pickPdf();
                          }),
                    ),
                    Container(
                      margin: new EdgeInsets.symmetric(horizontal: 1.0),
                      child: new IconButton(
                          icon: new Icon(
                            Icons.videocam,
                            color: Colors.blue,
                          ),
                          onPressed: () async {
                            pickVideo();
                          }),
                    ),
                  ],
                ),
                Container(
                  color: Colors.grey.withOpacity(0.2),
                  child: new Row(
                    children: <Widget>[
                      Flexible(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          margin:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          padding: EdgeInsets.all(10),
                          child: new TextField(
                            controller: textEditingController,
                            //onSubmitted: _handleSubmitted,
                            decoration: new InputDecoration.collapsed(
                                hintText: "Send a message"),
                          ),
                        ),
                      ),
                      // Container(
                      //   margin: new EdgeInsets.symmetric(horizontal: 1.0),
                      //   child: new FlatButton(
                      //       child: Text(''),
                      //       onPressed: () async {
                      //         Route route = MaterialPageRoute(
                      //             builder: (_) => FullBodyPage());
                      //         Navigator.push(context, route);
                      //       }),
                      // ),
                      Container(
                        margin: new EdgeInsets.symmetric(horizontal: 4.0),
                        child: new IconButton(
                          icon: new Icon(
                            Icons.send,
                            color: Colors.blue,
                          ),
                          onPressed: () {
                            onSendMessage(textEditingController.text, 0);
                            if (isLoading)
                              print("true");
                            else
                              print("false");
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }

  Widget buildSendImage() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: new Row(
        children: <Widget>[
          Flexible(child: Container()),
          Container(
            margin: new EdgeInsets.symmetric(horizontal: 4.0),
            child: new IconButton(
              icon: new Icon(
                Icons.cancel,
                color: Colors.red,
              ),
              onPressed: () {
                images1 = [];
                imageOfBodyPart = null;
                setState(() {});
              },
            ),
          ),
          Container(
            margin: new EdgeInsets.symmetric(horizontal: 4.0),
            child: isUploading
                ? Text('')
                : IconButton(
                    icon: Icon(
                      Icons.send,
                      color: Colors.red,
                    ),
                    onPressed: isUploading
                        ? null
                        : () {
                            if (imageOfBodyPart == null) {
                              print('Senfing 1');
                              uploadImages();
                              //onSendMessage(textEditingController.text, 0);
                              if (isLoading)
                                print("true");
                              else
                                print("false");
                            } else {
                              print('Senfing 2');
                              uploadPartOfImage();
                            }
                          },
                  ),
          )
        ],
      ),
    );
  }

  Future<bool> checkAndRequestCameraPermissions() async {
    PermissionStatus permission =
        await PermissionHandler().checkPermissionStatus(PermissionGroup.camera);
    if (permission != PermissionStatus.granted) {
      Map<PermissionGroup, PermissionStatus> permissions =
          await PermissionHandler()
              .requestPermissions([PermissionGroup.camera]);
      return permissions[PermissionGroup.camera] == PermissionStatus.granted;
    } else {
      return true;
    }
  }

  void pickPdf() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      allowedExtensions: ['pdf'],
      type: FileType.custom,
    );

    if (result != null) {
      File file = File(result.files.single.path);
      pdfFile = file;
      setState(() {});
    }
  }

  void pickVideo() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.video,
    );

    if (result != null) {
      File file = File(result.files.single.path);
      videoFile = file;
      setState(() {});
    }
  }
}
