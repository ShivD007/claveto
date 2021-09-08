import 'package:claveto/add_family_member.dart';
import 'package:claveto/common/loading.dart';
import 'package:claveto/edit_family_member.dart';
import 'package:claveto/model/get_family_member_model.dart';
import 'package:claveto/rest/api_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class FamilyMemberList extends StatefulWidget {
  @override
  _FamilyMemberListState createState() => _FamilyMemberListState();
}

class _FamilyMemberListState extends State<FamilyMemberList> {
  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Members",
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddMember()),
          );
        },
        //backgroundColor: ,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xff14B4A5),
                Color(0xff3883EF),
              ],
            ),
          ),
          child: Icon(Icons.add, size: 40),
        ),
      ),
      body: FutureBuilder<GetFamilyMember>(
          future: getFamilyMemberList(),
          // ignore: missing_return
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Loading();
            } else if (snapshot.hasData) {
              if (snapshot.data.familyMembers.isEmpty) {
                return Center(
                  child: Text("No Family Members"),
                );
              } else
                return ListView.builder(
                  itemCount: snapshot.data.familyMembers.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      padding: EdgeInsets.all(15),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                            color: Colors.grey.withOpacity(0.3), width: 2),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ClipOval(
                                child:
                                    snapshot.data.familyMembers[index].image !=
                                            null
                                        ? FadeInImage.assetNetwork(
                                            width: _size.width * .20,
                                            height: _size.width * .20,
                                            placeholder: "assets/appLogo.png",
                                            image:
                                                snapshot.data
                                                    .familyMembers[index].image,
                                            fit: BoxFit.fill,
                                          )
                                        : Image.asset(
                                            "assets/appLogo.png",
                                            height: _size.width * .20,
                                            width: _size.width * .20,
                                          ),
                              ),
                              SizedBox(width: 15),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                      text: TextSpan(children: <TextSpan>[
                                    TextSpan(
                                      text: snapshot.data.familyMembers[index]
                                              .firstName[0]
                                              .toUpperCase() +
                                          snapshot.data.familyMembers[index]
                                              .firstName
                                              .substring(1) +
                                          " ",
                                      style: GoogleFonts.montserrat(
                                          textStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15)),
                                    ),
                                    TextSpan(
                                      text: snapshot.data.familyMembers[index]
                                              .middleName[0]
                                              .toUpperCase() +
                                          snapshot.data.familyMembers[index]
                                              .middleName
                                              .substring(1) +
                                          " ",
                                      style: GoogleFonts.montserrat(
                                          textStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15)),
                                    ),
                                    TextSpan(
                                      text: snapshot.data.familyMembers[index]
                                              .lastName[0]
                                              .toUpperCase() +
                                          snapshot.data.familyMembers[index]
                                              .lastName
                                              .substring(1),
                                      style: GoogleFonts.montserrat(
                                          textStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15)),
                                    ),
                                  ])),
                                  SizedBox(height: 10),
                                  Text(
                                    snapshot
                                        .data.familyMembers[index].relationship,
                                    style: GoogleFonts.montserrat(
                                        textStyle: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            fontSize: 16)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => EditMember(
                                                familyMember: snapshot
                                                    .data.familyMembers[index],
                                              )),
                                    );
                                  },
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.lightBlueAccent,
                                  )),
                              SizedBox(width: 10),
                              InkWell(
                                  onTap: () {
                                    deleteFamilyMemberList(
                                        snapshot.data.familyMembers[index].id);
                                  },
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.lightBlueAccent,
                                  )),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                );
            } else
              Center(
                child: Text(snapshot.hasError.toString()),
              );
          }),
    );
  }

  // Future<void> getFmilyMemberAPI() async {
  //   showDialog(context: context, builder: (context) => Loading());
  //   await getFamilyMemberList().then((response) {
  //     allFamilyMember = response.familyMembers;
  //     print(allFamilyMember.length);
  //     setState(() {});
  //   });
  //   Navigator.pop(context);
  // }
}
