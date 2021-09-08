import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'rest/api_services.dart';
import 'common/constant.dart';
import 'common/keys.dart';
import 'wIdgets/my_snackbar.dart';
class SupportCentre extends StatefulWidget {
  @override
  _SupportCentreState createState() => _SupportCentreState();
}

class _SupportCentreState extends State<SupportCentre> {
  final formStateKey = GlobalKey<FormState>();
  final _emailController =
      TextEditingController(text: getPrefValue(Keys.EMAIL));
  final _nameController =
      TextEditingController(text: getPrefValue(Keys.NAME));
  final _descriptionController = TextEditingController();
  final _phoneNumberController =
      TextEditingController(text: getPrefValue(Keys.PHONE));


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Support Centre",
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
                            'Write your query',
                            style: TextStyle(fontSize: 20),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 10),
                        child: TextFormField(
                          validator: (value) {
                            return GetUtils.isEmail(value)
                                ? null
                                : 'Enter valid email';
                          },
                          controller: _emailController,
                          decoration: InputDecoration(
                            hintText: 'Email',
                            labelText: 'Email',
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
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 10),
                        child: TextFormField(
                          controller: _nameController,
                          validator: (value) {
                            return value.isNotEmpty
                                ? null
                                : 'Name cannot be empty';
                          },
                          decoration: InputDecoration(
                            hintText: 'Name',
                            labelText: 'Name',
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
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 10),
                        child: TextFormField(
                          controller: _phoneNumberController,
                          validator: (value) {
                            return value.isNotEmpty
                                ? null
                                : 'Phone Number cannot be empty';
                          },
                          decoration: InputDecoration(
                            hintText: 'Phone Number',
                            labelText: 'Phone Number',
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
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 10),
                        child: TextFormField(
                          maxLines: 10,
                          validator: (value) {
                            return value.isNotEmpty
                                ? null
                                : 'Description cannot be empty';
                          },
                          controller: _descriptionController,
                          decoration: InputDecoration(
                            hintText: 'Description',
                            labelText: 'Description',
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
    _descriptionController.dispose();
  }
  void makePhoneCall() {
    try {
      launch("tel: +919988998899");
    } catch (a) {}
  }

  Future<void> submitQuery() async {
    if (formStateKey.currentState.validate()) {
      try {
        showSnackBar(message: 'Loading...');
        await userSupport(
            name: _nameController.text,
            email: _emailController.text,
            phoneNumber: _phoneNumberController.text,
            query: _descriptionController.text);
        showSnackBar(message: 'Email Sent');
        _descriptionController.clear();
      } catch (e) {
        showSnackBar(message: '${e.toString()}');

      }
    }
  }
}
