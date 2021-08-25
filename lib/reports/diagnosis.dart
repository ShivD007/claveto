
import 'package:claveto/model/home_screen_model.dart';
import 'package:claveto/models/diagnosis_model/diagnosis_response_model.dart';

import 'package:claveto/payment_success/payment_success.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:claveto/rest/api_services.dart';

import '../home.dart';

class DiagnosisScreen extends StatefulWidget {
  final List<Doctor> allDoctor;

  const DiagnosisScreen({Key key, this.allDoctor}) : super(key: key);

  @override
  _DiagnosisScreenState createState() => _DiagnosisScreenState();
}

class _DiagnosisScreenState extends State<DiagnosisScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        navigateTOHomeScreen(context);
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Diagnosis",
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
        body: Container(
          child: FutureBuilder<DiagnosisResponseModel>(
              future: getDiagnosis(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error while fetching blogs'),
                  );
                } else {
                  print('Diagnosis ${snapshot.data.diagnoses}');
                  List<Diagnoses> myDiagnoses =
                      snapshot.data.diagnoses.toList().reversed.toList();
                  return myDiagnoses.length==0?Center(child: Text('No Diagnosis Found'),):ListView.builder(
                      itemCount: snapshot.data.diagnoses.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        Diagnoses model = myDiagnoses[index];
                        Doctor doctor;
                        try{
                           doctor = cachedAllDoctors
                              .where((element) =>
                          element.id.toString() == model.docID)
                              .toList()[0];
                          print('Doctor ${doctor.toJson()}');
                        }
                        catch(e){

                        }

                        return Container(
                          margin: EdgeInsets.all(15),
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0xff14B4A5),
                                    Color(0xff3883EF),
                                  ],
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        alignment: Alignment.centerLeft,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        child: Text(
                                            'Prescription: ' +
                                                    model.prescription ??
                                                0,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 15))),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            alignment: Alignment.centerLeft,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            child: Text(
                                                'Remarks: ' + model.remarks ??
                                                    0,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15))),
                                      ],
                                    ),
                                    if(doctor!=null)Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            alignment: Alignment.centerLeft,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            child: Text(
                                                'Doctor: ' +
                                                        doctor.doctorDetailsNew.firstName+" "+doctor.doctorDetailsNew.lastName,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15))),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            alignment: Alignment.centerLeft,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            child: Text(
                                                'Date: ' + model.updatedAt.split('T').first ??
                                                    0,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15))),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      });
                }
              }),
        ),
      ),
    );
  }
}
