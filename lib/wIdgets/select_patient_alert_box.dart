

import 'package:claveto/model/get_family_member_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

typedef SelectMember(FamilyMember id);

class SelectPatientAlertBox extends StatelessWidget {
  final SelectMember member;
  final List<FamilyMember> allFamilyMember;

  const SelectPatientAlertBox({Key key, this.member, this.allFamilyMember}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  Dialog(backgroundColor: Colors.transparent,
      child: Container(padding: EdgeInsets.only(top: 10,),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color(0xff14B4A5),
              Color(0xff3883EF),
            ],
          ),
        ),
          //this right here
      child: Column(mainAxisSize: MainAxisSize.min,
        children: [
          Container(padding: EdgeInsets.all(10),
            child: Text('Select Members',style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                  fontSize: 18,
                  fontWeight:
                  FontWeight.w500,
                  color: Colors.white,
                ))),
          ),
          SingleChildScrollView(
            child: Container(padding: EdgeInsets.only(top: 20,),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                color: Colors.white
              ),
              height: 400,
              child: ListView.builder(
                itemCount: allFamilyMember.length+1,
                itemBuilder: (_,index){
                  return ListTile(
                    leading: Text(index==0?'Self':allFamilyMember[index-1].middleName,style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            fontSize: 15,
                            fontWeight:
                            FontWeight.w500,
                            color: Colors.grey,
                        ))),
                    onTap: (){
                      index==0?member(FamilyMember(
                          middleName: 'Self',
                          id: -1
                      )):member(allFamilyMember[index-1]);
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
