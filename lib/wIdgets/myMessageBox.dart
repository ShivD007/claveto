
import 'package:claveto/common/colors.dart';
import 'package:claveto/config/config.dart';
import 'package:claveto/wIdgets/pdf_viewer.dart';
import 'package:claveto/wIdgets/video_player_viewer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyMessages extends StatelessWidget {
  final int index;
  final DocumentSnapshot document;
  final String id;
  final List<QueryDocumentSnapshot> listMessage;

  const MyMessages(
      {Key key, this.index, this.document, this.listMessage, this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                  document.data()[UserMessage.type] == 0
                      // Text
                      ? Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "${document.data()[UserMessage.content]} ",
                                style: TextStyle(color: primaryColor),
                              ),
                              Row(
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                      DateFormat('dd MMM kk:mm').format(
                                          DateTime.fromMillisecondsSinceEpoch(
                                              int.parse(document.data()[
                                                  UserMessage.timestamp]))),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.0,
                                          fontStyle: FontStyle.italic),
                                    ),
                                    margin: EdgeInsets.only(top: 3.0),
                                  ),
                                  Flexible(
                                    child: Container(),
                                  ),
                                ],
                              )
                            ],
                          ),
                          padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                          width: 200.0,
                          decoration: BoxDecoration(
                              color: Color(0xff3883EF)
                                  .withOpacity(0.3),
                              borderRadius: BorderRadius.circular(8.0)),
                          margin: EdgeInsets.only(
                              bottom: isLastMessageRight(index) ? 20.0 : 10.0,
                              right: 10.0),
                        )
                      : document.data()[UserMessage.type] == 1
                          // Image
                          ? Container(
                              child: Column(
                                children: <Widget>[
                                  Material(
                                    child: document
                                                .data()[UserMessage.content] ==
                                            'Image'
                                        ? Column(
                                            children: <Widget>[
                                              Image.asset(
                                                'assets/images/loading.png',
                                                height: 250,
                                                width: 300,
                                              ),
                                              Container(
                                                  height: 20,
                                                  width: 280,
                                                  child: DateShow(
                                                    document: document.data()[
                                                        UserMessage.timestamp],
                                                  ))
                                            ],
                                          )
                                        : Column(
                                            children: <Widget>[
                                              FadeInImage(
                                                placeholder: AssetImage(
                                                    'assets/images/loading.png'),
                                                image: NetworkImage(
                                                    document.data()[
                                                        UserMessage.content]),
                                                height: 250,
                                                width: 300,
                                              ),
                                              Container(
                                                  height: 20,
                                                  width: 280,
                                                  child: DateShow(
                                                    document: document.data()[
                                                        UserMessage.timestamp],
                                                  ))
                                            ],
                                          ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.0)),
                                  ),
                                ],
                              ),
                              margin: EdgeInsets.only(
                                  bottom:
                                      isLastMessageRight(index) ? 20.0 : 10.0,
                                  right: 10.0),
                            )
                          // PDF FILE
                          : document.data()[UserMessage.type] == 2
                              ? Container(
                                  height: 100,
                                  child: InkWell(
                                    onTap: () {
                                      if (document
                                              .data()[UserMessage.content]
                                              .toString()
                                              .toLowerCase() ==
                                          "pdf") {
                                      } else {
                                        Route route = MaterialPageRoute(
                                            builder: (_) => PdfViewer(
                                                  url: document.data()[
                                                      UserMessage.content],
                                                ));
                                        Navigator.push(context, route);
                                      }
                                    },
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        (document
                                                    .data()[UserMessage.content]
                                                    .toString()
                                                    .toLowerCase() ==
                                                "pdf")
                                            ? Container(
                                                height: 20,
                                                width: 20,
                                                child:
                                                    CircularProgressIndicator(),
                                              )
                                            : Icon(Icons.picture_as_pdf),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Text('PDF'),
                                      ],
                                    ),
                                  ),
                                  margin: EdgeInsets.only(
                                      bottom: isLastMessageRight(index)
                                          ? 20.0
                                          : 10.0,
                                      right: 10.0),
                                )
                              : document.data()[UserMessage.type] == 3
                                  ? Container(
                                      height: 100,
                                      child: InkWell(
                                        onTap: () {
                                          if (document
                                                  .data()[UserMessage.content]
                                                  .toString()
                                                  .toLowerCase() ==
                                              "pdf") {
                                          } else {
                                            Route route = MaterialPageRoute(
                                                builder: (_) => VideoApp(
                                                      videoUrl: document.data()[
                                                          UserMessage.content],
                                                    ));
                                            Navigator.push(context, route);
                                          }
                                        },
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            (document
                                                        .data()[
                                                            UserMessage.content]
                                                        .toString()
                                                        .toLowerCase() ==
                                                    "video")
                                                ? Container(
                                                    height: 20,
                                                    width: 20,
                                                    child:
                                                        CircularProgressIndicator(),
                                                  )
                                                : Icon(Icons.featured_video),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text('Video'),
                                          ],
                                        ),
                                      ))
                                  : Container(),
                ],
              ),
            ],
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.end,
      )
    ]);
  }

  bool isLastMessageLeft(int index) {
    if ((index > 0 &&
            listMessage != null &&
            listMessage[index - 1].data()[UserMessage.idFrom] == id) ||
        index == 0) {
      return true;
    } else {
      return false;
    }
  }

  bool isLastMessageRight(int index) {
    if ((index > 0 &&
            listMessage != null &&
            listMessage[index - 1].data()[UserMessage.idFrom] != id) ||
        index == 0) {
      return true;
    } else {
      return false;
    }
  }
}

class DateShow extends StatelessWidget {
  final String document;

  const DateShow({Key key, this.document}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          child: Text(
            DateFormat('dd MMM kk:mm').format(
                DateTime.fromMillisecondsSinceEpoch(int.parse(document))),
            style: TextStyle(
                color: greyColor, fontSize: 12.0, fontStyle: FontStyle.italic),
          ),
          margin: EdgeInsets.only(top: 3.0),
        ),
        Flexible(
          child: Container(),
        ),
      ],
    );
  }
}
