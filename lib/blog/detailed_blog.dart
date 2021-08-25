// import 'package:admob_flutter/admob_flutter.dart';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:claveto/models/appointement/all_blogs_response.dart';
import 'package:claveto/rest/api_services.dart';
import 'package:claveto/services/ad_mod_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:claveto/book_appointment.dart';

class DetailedBlog extends StatefulWidget {
  final Blogs model;

  const DetailedBlog({Key key, this.model}) : super(key: key);
  @override
  _DetailedBlogState createState() => _DetailedBlogState();
}

class _DetailedBlogState extends State<DetailedBlog> {
  final ams = AdmodService();

  @override
  void initState() {
    super.initState();
    Admob.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
        child: SafeArea(
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                height: MediaQuery.of(context).size.height,
                color: Colors.grey[300],
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        alignment: Alignment.bottomLeft,
                        height: MediaQuery.of(context).size.width * .8,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              colorFilter: ColorFilter.mode(
                                  Colors.black38, BlendMode.darken),
                              fit: BoxFit.fill,
                              image: NetworkImage(
                                IMAGE_URL +
                                            BLOG_ENDPOINT +
                                            widget.model.featuredImage !=
                                        null
                                    ? IMAGE_URL +
                                        BLOG_ENDPOINT +
                                        widget.model.featuredImage
                                    : "assets/blogbg.jpeg",
                              )),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                }),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width - 30,
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    child: Text(widget.model.title,
                                        maxLines: 3,
                                        softWrap: true,
                                        style: TextStyle(
                                            // backgroundColor: Colors.grey,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20))),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        child: Text(
                                            changeFormat(widget.model.createdAt
                                                .substring(0, 10)),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15))),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.model.sortDescription,
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      html(widget.model.description),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                  // ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: AdmobBanner(
                    adUnitId: ams.getBannerAdId(),
                    adSize: AdmobBannerSize.BANNER),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget html(a) => Html(
        data: """
        $a
      """,
        style: {
          // 'h1': Style(color: Colors.red,),
          'p': Style(color: Colors.black87, fontSize: FontSize(18)),
          'ul': Style(margin: EdgeInsets.symmetric(vertical: 20))
        },
        //Optional parameters:
        // backgroundColor: Colors.white70,

        onLinkTap: (url) async {
          if (await canLaunch(url)) {
            await launch(
              url,
            );
          } else {
            throw 'Could not launch $url';
          }
        },
      );
}
