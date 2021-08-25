
import 'package:claveto/models/diagnosis_model/report_response_model.dart';

import 'package:claveto/payment_success/payment_success.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:claveto/rest/api_services.dart';
import 'package:claveto/wIdgets/photo_view.dart';

class ReportsScreen extends StatefulWidget {
  @override
  _ReportsScreenState createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
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
            "Reports",
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
          child: FutureBuilder<ReportResponseModel>(
              future: getReports(),
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
                } else {
                  print('Snapshot data ${snapshot.data.toJson()}');
                  List<Reports> reports1 =
                  snapshot.data.reports?.toList()?.reversed?.toList(),reports=[];
                  int id = 0;
                  reports1.forEach((element) {
                    if(id!=element.orderId){

                      reports.add(element);

                      id  = element.orderId;
                    }
                    else{

                      id  = element.orderId;

                    }
                  });

                  return reports.length==0?Center(child: Text('No Reports Found'),):ListView.builder(
                      itemCount: reports.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        Reports model = reports[index];
                        return new Container(
                          margin: EdgeInsets.all(15),
                          child: InkWell(
                            onTap: () {

                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ReportsPerLab(
                                  reports: reports1.where((element) => element.orderId == model.orderId).toList()

                                )),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.all(15),
                              child: Material(
                                elevation: 5,
                                borderRadius: BorderRadius.circular(15),
                                child: Container(
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                        Color(0xff14B4A5).withOpacity(0.5),
                                        Color(0xff3883EF).withOpacity(0.5),
                                      ],
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 0),
                                        child: Container(
                                            margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                            child: Text(
                                              '${model.name} ',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            )),
                                      ),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                          Flexible(
                                            child: Container(
                                              margin: EdgeInsets.symmetric(horizontal: 9, vertical: 0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        'Lab Name: ',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight: FontWeight.bold),
                                                      ),
                                                      Expanded(
                                                          child: Text(
                                                            '${model.legalName}',
                                                            style: TextStyle(color: Colors.white),
                                                          )),
                                                    ],
                                                  ),
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        'Name: ',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight: FontWeight.bold),
                                                      ),
                                                      Expanded(
                                                          child: Text(
                                                            '${model.firstName + " " + model.middleName + " " + model.lastName}',
                                                            style: TextStyle(color: Colors.white),
                                                          )),
                                                    ],
                                                  ),
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        'Address: ',
                                                        overflow: TextOverflow.ellipsis,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight: FontWeight.bold),
                                                      ),
                                                      Expanded(
                                                          child: Text(
                                                            '${model.address}',
                                                            style: TextStyle(
                                                              color: Colors.white,
                                                            ),
                                                          ))
                                                    ],
                                                  ),
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        'City: ',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight: FontWeight.bold),
                                                      ),
                                                      Expanded(
                                                          child: Text(
                                                            '${model.city}',
                                                            style: TextStyle(
                                                              color: Colors.white,
                                                            ),
                                                          ))
                                                    ],
                                                  ),
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        'State: ',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight: FontWeight.bold),
                                                      ),
                                                      Text(
                                                        '${model.state}',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        'PinCode: ',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight: FontWeight.bold),
                                                      ),
                                                      Text(
                                                        '${model.pincode}',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
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

class ReportsPerLab extends StatefulWidget {
  final List<Reports> reports;

  const ReportsPerLab({Key key, this.reports}) : super(key: key);
  @override
  _ReportsPerLabState createState() => _ReportsPerLabState();
}

class _ReportsPerLabState extends State<ReportsPerLab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.reports.length==0?'':widget.reports[0].name),
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
      body: widget.reports.length==0?Center(child: Text('No Report Found'),):ListView.builder(
          itemCount: widget.reports.length,
          itemBuilder: (BuildContext ctxt, int index) {
            Reports model = widget.reports[index];
            return new Container(
              margin: EdgeInsets.all(15),
              child: InkWell(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => DetailedBlog(
                  //     model: model,
                  //   )),
                  // );
                },
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
                  child: Container(

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Text('model.report ${model.report}'),
                        model.report!=null?InkWell(
                          onTap: (){
                            print('Url ${"https://claveto.s3.ap-south-1.amazonaws.com/lab_report/" +
                                model.report}');
                            Route route = MaterialPageRoute(builder: (_)=>ViewZoomPhoto(url: "https://claveto.s3.ap-south-1.amazonaws.com/lab_report/" +
                                model.report,));
                            Navigator.push(context, route);

                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: FadeInImage.assetNetwork(
                              width: MediaQuery.of(context).size.height,
                              height: 200,
                              placeholder:
                              "assets/appLogo.png",
                              image:
                              "https://claveto.s3.ap-south-1.amazonaws.com/lab_report/" +
                                  model.report,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                            : ClipRRect(borderRadius: BorderRadius.circular(15),
                            child: Image.asset("assets/appLogo.png")),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}




