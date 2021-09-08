import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:url_launcher/url_launcher.dart';
import 'rest/api_services.dart';
import 'common/constant.dart';
import 'common/keys.dart';
import 'wIdgets/my_snackbar.dart';
class WriteReviewScreen extends StatefulWidget {
  final String id;

  const WriteReviewScreen({Key key, this.id}) : super(key: key);
  @override
  _WriteReviewScreenState createState() => _WriteReviewScreenState();
}

class _WriteReviewScreenState extends State<WriteReviewScreen> {
  final formStateKey = GlobalKey<FormState>();
  final _emailController =
  TextEditingController(text: getPrefValue(Keys.EMAIL));
  final _nameController =
  TextEditingController(text: getPrefValue(Keys.NAME));
  final _reviewController = TextEditingController();
  final _phoneNumberController =
  TextEditingController(text: getPrefValue(Keys.PHONE));

  double rating = 4.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Review",
          style: GoogleFonts.montserrat(
              textStyle: TextStyle(color: Colors.white, fontSize: 20)),
        ),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
                key: formStateKey,
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Write your review',
                            style: TextStyle(fontSize: 20),
                          )),
                      SizedBox(
                        height: 10,
                      ),


                      Align(
                          alignment: Alignment.centerLeft,
                        child: SmoothStarRating(
                            allowHalfRating: false,
                            onRated: (v) {
                              rating = v;
                              print('New Rating $v');
                              setState(() {

                              });
                            },
                            starCount: 5,
                            rating: rating,
                            size: 40.0,
                            isReadOnly: false,
                            defaultIconData: Icons.star_border_outlined,
                            filledIconData: Icons.star,

                            color: Color(0xff14B4A5),
                            borderColor: Color(0xff14B4A5),
                            spacing:0.0
                        ),
                      ),


                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 10),
                        child: TextFormField(
                          maxLines: 10,
                          validator: (value) {
                            return value.isNotEmpty
                                ? null
                                : 'Review cannot be empty';
                          },
                          controller: _reviewController,
                          decoration: InputDecoration(
                            hintText: 'Review',
                            labelText: 'Review',
                            alignLabelWithHint: true,
                            border: OutlineInputBorder(
                                borderSide: new BorderSide(color: Colors.teal)),
                            disabledBorder: OutlineInputBorder(
                                borderSide: new BorderSide(color: Colors.teal)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: new BorderSide(color: Colors.teal)),
                          ),
                        ),
                      ),
                      OutlineButton(
                        onPressed: submitQuery,
                        color: Colors.teal,
                        child: Text('Submit'),
                        highlightedBorderColor: Colors.teal,
                        highlightColor: Colors.teal,
                        disabledBorderColor: Colors.teal,
                      ),
                      // RaisedButton(onPressed: submitQuery),
                    ],
                  ),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  color: Colors.grey,
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: 1,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('OR'),
                ),
                Container(
                  color: Colors.grey,
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: 1,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 2),
                  child: Icon(Icons.phone),
                ),
                Container(child: Text('Call us at ')),
                InkWell(
                  onTap: makePhoneCall,
                  child: Text(
                    '+91-7089840083',
                    style: TextStyle(
                        color: Colors.teal, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _reviewController.dispose();
  }
  void makePhoneCall() {
    try {
      launch("tel: +917089840083");
    } catch (a) {}
  }

  Future<void> submitQuery() async {
    if (formStateKey.currentState.validate()) {
      try {
        showSnackBar(message: 'Loading...');
        await userAppointmentReview(
            appointmentID: widget.id,
            rating: rating.toString(),
            review: _reviewController.text);
        showSnackBar(message: 'Review Sent');
        _reviewController.clear();
      } catch (e) {
        showSnackBar(message: '${e.message.toString()}');

      }
    }
  }
}
