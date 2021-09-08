import 'package:claveto/models/appointement/all_blogs_response.dart';
import 'package:claveto/rest/api_services.dart';
import 'package:flutter/material.dart';

import 'detailed_blog.dart';
import 'package:claveto/book_appointment.dart';

class AllBlogs extends StatefulWidget {
  @override
  _AllBlogsState createState() => _AllBlogsState();
}

class _AllBlogsState extends State<AllBlogs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder<AllBlogsResponse>(
            future: getBlogs(),
            builder: (context, snapshot) {
              print('Called snapshot ${snapshot}');
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error while fetching blogs'),
                );
              } else
                return ListView.builder(
                    itemCount: snapshot.data.blogs.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      final reversedIndex =
                          snapshot.data.blogs.length - 1 - index;
                      Blogs model = snapshot.data.blogs[reversedIndex];
                      return new Container(
                        margin: EdgeInsets.all(15),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailedBlog(
                                        model: model,
                                      )),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            alignment: Alignment.bottomLeft,
                            height: MediaQuery.of(context).size.width / 2,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  colorFilter: ColorFilter.mode(
                                      Colors.black54, BlendMode.darken),
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                   
                                                model.featuredImage !=
                                            null
                                        ?
                                            model.featuredImage
                                        : "assets/blogbg.jpeg",
                                  )),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width - 30,
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    child: Text(model.title,
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
                                            changeFormat(model.createdAt
                                                .substring(0, 10)),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15))),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
            }),
      ),
    );
  }
}
