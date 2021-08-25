import 'package:claveto/categories/categories_in_clinic.dart';
import 'package:claveto/model/home_screen_model.dart';
import 'package:claveto/rest/api_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class AllCategoriesScreen extends StatefulWidget {
  final List<Category> allDoctors;
  final List<Doctor> doctor;

  const AllCategoriesScreen({Key key, this.allDoctors, this.doctor})
      : super(key: key);

  @override
  _AllCategoriesScreenState createState() => _AllCategoriesScreenState();
}

class _AllCategoriesScreenState extends State<AllCategoriesScreen> {
  List<Category> doctors;

  @override
  void initState() {
    doctors = widget.allDoctors;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        title: Text('All Categories'),
      ),
      body: ListView.builder(
        itemCount: doctors.length,
        itemBuilder: (_, index) {
          return horizontalDoctorCard(doctors[index], context, widget.doctor);
        },
      ),
    );
  }
}

Widget horizontalDoctorCard(
    Category doctor, BuildContext context, List<Doctor> doctors,
    {bool isSearch = false}) {
  return InkWell(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => CategoriesInClinics(
                    categoryId: doctor.id,
                    allDoctors: doctors,
                    speciality: doctor.name,
                  )));
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      // width: 130,
                      child: ClipRRect(
                    child: doctor.icon != null
                        ? ClipOval(
                            // decoration: BoxDecoration(color: Colors.white),
                            child: FadeInImage.assetNetwork(
                              width: 60,
                              height: 60,
                              placeholder: "assets/appLogo.png",
                              image: IMAGE_URL + "icons/" + doctor.icon,
                              fit: BoxFit.fill,
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(color: Colors.white),
                            child: Image.asset(
                              "assets/appLogo.png",
                              height: 150,
                              width: 60,
                            ),
                          ),
                  )),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 9, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Text(
                              '',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: Text(
                                '${doctor.name}',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                // overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Fees: ',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              ' ₹ ${doctor.fees ?? ''}',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                        // if(doctor.dob!=null)Row(
                        //   children: [
                        //     Text(
                        //       'DOB: ',
                        //       style: TextStyle(
                        //           color: Colors.white,
                        //           fontWeight: FontWeight.bold),
                        //     ),
                        //
                        //     Text(
                        //       '${doctor.dob.toString().substring(0, 10)}',
                        //       style: TextStyle(
                        //         color: Colors.white,
                        //       ),
                        //     )
                        //   ],
                        // ),
                        // Row(
                        //   children: [
                        //     Text(
                        //       'PinCode: ',
                        //       style: TextStyle(
                        //           color: Colors.white,
                        //           fontWeight: FontWeight.bold),
                        //     ),
                        //     Text(
                        //       '${doctor.pincode}',
                        //       style: TextStyle(
                        //         color: Colors.white,
                        //       ),
                        //     )
                        //   ],
                        // ),
                      ],
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
