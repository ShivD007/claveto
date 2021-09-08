import 'package:claveto/lab/lab.dart';
import 'package:claveto/model/home_screen_model.dart';
import 'package:claveto/rest/api_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class AllLabsScreen extends StatefulWidget {
  final List<Lab> allLabs;

  const AllLabsScreen({Key key, this.allLabs}) : super(key: key);

  @override
  _AllLabsScreenState createState() => _AllLabsScreenState();
}

class _AllLabsScreenState extends State<AllLabsScreen> {
  List<Lab> allLabs;

  @override
  void initState() {
    allLabs = widget.allLabs;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Labs'),
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
      body: ListView.builder(
        itemCount: allLabs.length,
        itemBuilder: (_, index) {
          return horizontalLabCard(allLabs[index], context);
        },
      ),
    );
  }
}

Widget horizontalLabCard(Lab lab, BuildContext context,
    {bool isSearch = false}) {
  return InkWell(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => LabScreen(
                    lab: lab,
                  )));
    },
    child: Container(
      margin: EdgeInsets.only(top:7,left:6,bottom: 7),
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
              isSearch
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0),
                      child: Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                          child: Text(
                            'Lab\'s ',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          )),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Lab Name: ',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Expanded(
                              child: Text(
                            '${lab.labDetailsNew.legalName}',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          )),
                        ],
                      ),
                    ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      width: 120,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Container(
                            color: Colors.white,
                            child: lab.avatar != null
                                ? Container(
                                    decoration:
                                        BoxDecoration(color: Colors.white),
                                    child: FadeInImage.assetNetwork(
                                      width: 60,
                                      height: 150,
                                      placeholder: "assets/appLogo.png",
                                      image:  lab.avatar,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Container(
                                    decoration:
                                        BoxDecoration(color: Colors.white),
                                    child: Image.asset(
                                      "assets/appLogo.png",
                                      height: 150,
                                      width: 60,
                                    ),
                                  ),
                          ))),
                  Flexible(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 9, vertical: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          if (isSearch)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Lab Name: ',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width * .35,
                                    child: Text(
                                      '${lab.labDetailsNew.legalName}',
                                      style: TextStyle(color: Colors.white),
                                    )),
                              ],
                            ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Name: ',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width * .35,
                                  child: Text(
                                    '${lab.labDetailsNew.firstName + " " + lab.labDetailsNew.middleName + " " + lab.labDetailsNew.lastName}',
                                    style: TextStyle(color: Colors.white),
                                  )),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Address: ',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width * .35,
                                  child: Text(
                                    '${lab.labDetailsNew.address}',
                                    maxLines: 3,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ))
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'City: ',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width * .35,
                                  child: Text(
                                    '${lab.labDetailsNew.city}',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ))
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'State: ',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * .35,
                                child: Text(
                                  '${lab.labDetailsNew.state}',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'PinCode: ',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * .35,
                                child: Text(
                                  '${lab.labDetailsNew.pincode}',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
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
  );
}
