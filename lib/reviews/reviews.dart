
import 'package:claveto/models/reviews/review_resonse.dart';
import 'package:claveto/rest/api_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class ReviewsScreen extends StatefulWidget {
  final String id;

  const ReviewsScreen({Key key, this.id}) : super(key: key);
  @override
  _ReviewsScreenState createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reviews'),
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
      body: Container(
        child: FutureBuilder<ReviewsModel>(
            future: getReviews(widget.id),
            builder: (context, snapshot) {
              print('Called snapshot ${snapshot}');
              if (!snapshot.hasData ||
                  snapshot.connectionState == ConnectionState.waiting ||
                  snapshot.connectionState == ConnectionState.none) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error while fetching blogs'),
                );
              } else
                return ListView.builder(
                    itemCount: snapshot.data.reviews.length + 1,
                    // adding 1 because at 0 index showing average ratings
                    itemBuilder: (BuildContext context, int index) {
                      Reviews model;
                      if(index!=0){
                        model = snapshot.data.reviews[index-1];
                      }
                      return index==0?Container(  margin:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        child: Material(elevation: 5,borderRadius: BorderRadius.circular(15),
                          child: Container(

                            padding: EdgeInsets.all(15),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(color: Colors.grey.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(15),
                              // border: Border.all(
                              //     color: Colors.grey.withOpacity(0.3), width: 2),
                            ),

                            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Average Reviews', style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                        color: Colors.black
                                            .withOpacity(0.7),
                                        fontSize: 25)),),
                                Container(margin: EdgeInsets.symmetric(vertical: 10),
                                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text('${snapshot.data.avgRatings.toStringAsPrecision(3)} ',style: GoogleFonts.montserrat(
                                              textStyle: TextStyle(
                                                  color: Colors.lightBlueAccent
                                                      .withOpacity(0.7),
                                                  fontSize: 25)),),
                                          Icon(Icons.star,color: Colors.orange,)
                                        ],
                                      ),
                                      Text('Average Rating ',style: GoogleFonts.montserrat(
                                          textStyle: TextStyle(
                                              color: Colors.black
                                                  .withOpacity(0.7),
                                              fontSize: 19))),
                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                      ):Container(margin:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        child: Material(elevation: 5,borderRadius: BorderRadius.circular(15),
                          child: Container(

                            padding: EdgeInsets.all(15),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(color: Colors.grey.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(15),
                              // border: Border.all(
                              //     color: Colors.grey.withOpacity(0.3), width: 2),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    child: Text(
                                      "Review ${index}",
                                      style: GoogleFonts.montserrat(
                                          textStyle: TextStyle(
                                              color: Colors.black
                                                  .withOpacity(0.7),
                                              fontSize: 25)),
                                    )),
                                Row(
                                  children: [
                                    Text(
                                      "${model.ratings} ",
                                      style: GoogleFonts.montserrat(
                                          textStyle: TextStyle(
                                              color: Colors.lightBlueAccent
                                                  .withOpacity(0.7),
                                              fontSize: 25)),
                                    ),
                                    RatingBarIndicator(
                                      rating: double.parse(model.ratings),
                                      itemBuilder: (context, index) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      itemCount: 5,
                                      itemSize: 25.0,
                                      unratedColor: Colors.amber.withAlpha(50),
                                      //direction: _isVertical ? Axis.vertical : Axis.horizontal,
                                    ),
                                  ],
                                ),

                                Text(
                                  '${model.review}',
                                  style: GoogleFonts.montserrat(
                                      textStyle: TextStyle(
                                          color: Colors.black, fontSize: 13)),
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
