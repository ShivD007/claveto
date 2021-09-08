import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:claveto/all_user_types/all_categories.dart';

import 'package:claveto/all_user_types/all_doctors.dart';
import 'package:claveto/all_user_types/all_labs.dart';
import 'package:claveto/categories/categories_in_clinic.dart';
import 'package:claveto/lab/lab.dart';
import 'package:claveto/model/home_screen_model.dart';
import 'package:claveto/rest/api_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:claveto/models/static_banner.dart';
import 'package:claveto/all_user_types/all_symptons.dart';
import 'package:url_launcher/url_launcher.dart';
import '../aboutdoctors.dart';
import '../book_appointment.dart';
import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';

class CustomerService extends StatefulWidget {
  final List<Doctor> allDoctors;

  final List<Symptom> allsymptoms;

  final List<Category> allcategories;

  final List<Lab> alllabs;
  final List<Banners> allBanners;
  // final List<

  const CustomerService(
      {Key key,
      this.allDoctors,
      this.allsymptoms,
      this.allcategories,
      this.alllabs,
      this.allBanners})
      : super(key: key);

  @override
  _CustomerServiceState createState() => _CustomerServiceState(
      allCategories: allcategories,
      allDoctors: allDoctors,
      allLabs: alllabs,
      allBanners: allBanners,
      allSymptoms: allsymptoms);
}

class _CustomerServiceState extends State<CustomerService> {
  final List<Doctor> allDoctors;

  final List<Symptom> allSymptoms;

  final List<Category> allCategories;

  final List<Lab> allLabs;
  final List<Banners> allBanners;

  _CustomerServiceState(
      {this.allDoctors,
      this.allSymptoms,
      this.allCategories,
      this.allBanners,
      this.allLabs});
  static FirebaseInAppMessaging fiam = FirebaseInAppMessaging();

  @override
  void initState() {
    fiam.triggerEvent('in_start');
    super.initState();
  }

  final _controller = PageController(viewportFraction: 0.9);
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    final itemHeight = (_size.height - kToolbarHeight - 24) / 3;
    final itemWidth = _size.width / 2;
    print('Customer Service ${allDoctors.length}');
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.3,
            child: CarouselSlider(
                items: allBanners
                    .map((e) => Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: CachedNetworkImage(
                              //placeholder: (context, url)=>Image.asset("assets/appLogo.png"),
                              imageUrl: e.bannerImage,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ))
                    .toList(),
                options: CarouselOptions(
                  height: 400,
                  aspectRatio: 1,
                  viewportFraction: 1,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  //    onPageChanged: callbackFunction,
                  scrollDirection: Axis.horizontal,
                )),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 20,
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Text(
                        "Top Doctors",
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AllDoctorsScreen(
                                    allDoctors: allDoctors,
                                  )),
                        );
                      },
                      child: Container(
                          child: Text("See All",
                              style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(fontSize: 15)))),
                    )
                  ],
                ),
                SizedBox(height: 15),
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxHeight: 230,
                    minHeight: 50,
                  ),
                  child: ListView.builder(
                    itemCount: allDoctors.length,
                    //shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    // physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AboutDoctors(
                                      doctorDetail: allDoctors[index],
                                    )),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                            width: 1,
                            color: Colors.black12,
                          )),
                          margin: EdgeInsets.all(1),
                          width: _size.width * 0.41,
                          height: _size.height * 0.41,
                          child: Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // allDoctors[index].avatar != null
                                  //     ?
                                  Stack(
                                    children: [
                                      CircleAvatar(
                                          radius: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .15,
                                          backgroundColor: Colors.black12,
                                          child: CircleAvatar(
                                            backgroundColor: Colors.white,
                                            radius: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2,
                                            child: Align(
                                              alignment: Alignment.bottomRight,
                                              child: Image.asset(
                                                  "assets/badge.png",
                                                  height: 33),
                                              //  CircleAvatar(
                                              //   backgroundColor: Colors.white,
                                              //   radius: 18,
                                              //   child: Image.asset(
                                              //       "assets/badge.png",
                                              //       height: 33),
                                              // ),
                                            ),
                                            backgroundImage: allDoctors[index]
                                                        .avatar !=
                                                    null
                                                ? NetworkImage(
                                                    allDoctors[index].avatar)
                                                : AssetImage(
                                                    "assets/appLogo.png",
                                                    // height: 140,
                                                  ),
                                          ),
                                          backgroundImage:
                                              AssetImage("assets/appLogo.png")),
                                    ],
                                  ),

                                  SizedBox(height: 5),
                                  Flexible(
                                    flex: 1,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Flexible(
                                          child: RichText(
                                              textAlign: TextAlign.center,
                                              text: TextSpan(
                                                style: GoogleFonts.montserrat(
                                                    textStyle: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.black,
                                                        fontSize: 10)),
                                                children: [
                                                  TextSpan(
                                                      text: allDoctors[index]
                                                                  .doctorDetailsNew
                                                                  .middleName ==
                                                              null
                                                          ? 'Dr '
                                                          : allDoctors[index]
                                                                  .doctorDetailsNew
                                                                  .middleName +
                                                              ' ',
                                                      children: [
                                                        TextSpan(
                                                          text: allDoctors[
                                                                          index]
                                                                      .doctorDetailsNew
                                                                      .lastName ==
                                                                  null
                                                              ? ' '
                                                              : allDoctors[
                                                                      index]
                                                                  .doctorDetailsNew
                                                                  .lastName,
                                                        )
                                                      ])
                                                ],
                                                text: allDoctors[index]
                                                            .doctorDetailsNew
                                                            .firstName ==
                                                        null
                                                    ? ' '
                                                    : allDoctors[index]
                                                            .doctorDetailsNew
                                                            .firstName +
                                                        ' ',
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                BookAppointment(
                                                  doctorDetails:
                                                      allDoctors[index],
                                                )),
                                      );
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      margin: EdgeInsets.only(bottom: 10),
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey,
                                              blurRadius: 5.0,
                                            ),
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.lightBlueAccent
                                              .withOpacity(0.9)),
                                      child: Text(
                                        'Consult Now',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 10),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    child: Text("Categories",
                        style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w500)))),
                allCategories.length > 5
                    ? InkWell(
                        onTap: () {
                          Route route = MaterialPageRoute(
                              builder: (_) => AllCategoriesScreen(
                                    doctor: allDoctors,
                                    allDoctors: allCategories,
                                  ));
                          Navigator.push(context, route);
                        },
                        child: Container(
                            // margin: EdgeInsets.symmetric(
                            //     horizontal: 20, vertical: 10),
                            child: Text("See All",
                                style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(fontSize: 15)))),
                      )
                    : Container()
              ],
            ),
          ),
        ),
        // SizedBox(height: 10),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 150,
                minHeight: 50,
              ),
              child: ListView.builder(
                itemCount: allCategories.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  List<Doctor> doctorsInClinics = [];
                  for (var doctor in allDoctors) {
                    if (doctor.doctorDetailsNew.catagoryId ==
                        allCategories[index].id) {
                      doctorsInClinics.add(doctor);
                    }
                  }

                  return doctorsInClinics.length != 0
                      ? Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                  onTap: () {
                                    Route route = MaterialPageRoute(
                                        builder: (_) => CategoriesInClinics(
                                              categoryId:
                                                  allCategories[index].id,
                                              allDoctors: allDoctors,
                                              speciality:
                                                  allCategories[index].name,
                                            ));
                                    Navigator.push(context, route);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: new BorderRadius.all(
                                          new Radius.circular(
                                              MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2)),
                                      border: new Border.all(
                                        color: Colors.black,
                                        width: 1.0,
                                      ),
                                    ),
                                    child: ClipOval(
                                      child: allCategories[index].icon != null
                                          ? FadeInImage.assetNetwork(
                                              width: _size.width * .20,
                                              height: _size.width * .20,
                                              placeholder: "assets/appLogo.png",
                                              image: allCategories[index].icon,
                                              fit: BoxFit.fill,
                                            )
                                          : Image.asset("assets/appLogo.png"),
                                    ),
                                  )),
                              Container(
                                alignment: Alignment.center,
                                width: 100,
                                padding: EdgeInsets.only(top: 10),
                                child: Text(allCategories[index].name,
                                    softWrap: true,
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold)),
                              )
                            ],
                          )
                          // : null,
                          )
                      : SizedBox();
                },
              ),
            ),
          ),
        ),
        // SizedBox(height: 10),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        child: Text("Labs",
                            style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500)))),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AllLabsScreen(
                                    allLabs: allLabs,
                                  )),
                        );
                      },
                      child: Container(
                          child: Text("See All",
                              style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(fontSize: 15)))),
                    )
                  ],
                ),
                SizedBox(height: 10),
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxHeight: 230,
                    minHeight: 120,
                  ),
                  child: ListView.builder(
                    itemCount: allLabs.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      Lab lab = allLabs[index];
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
                          margin: EdgeInsets.all(5),
                          width: MediaQuery.of(context).size.width * 0.41,
                          height: MediaQuery.of(context).size.height * 0.41,
                          child: Card(
                            elevation: 2,
                            child: Container(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  lab.avatar != null
                                      ? Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.withOpacity(0.3),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            child: FadeInImage.assetNetwork(
                                              width: 60,
                                              height: 150,
                                              placeholder: "assets/appLogo.png",
                                              image: lab.avatar,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        )
                                      : Image.asset(
                                          "assets/appLogo.png",
                                          height: 100,
                                          width: 60,
                                        ),
                                  Container(
                                    padding: EdgeInsets.all(5),
                                    child: Text(
                                        lab.labDetailsNew.legalName ?? '',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.montserrat(
                                            textStyle:
                                                TextStyle(fontSize: 10))),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 10),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 3),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.lightBlueAccent
                                          .withOpacity(0.9),
                                    ),
                                    child: Text(
                                      'Lab',
                                      style: GoogleFonts.montserrat(
                                          textStyle: TextStyle(fontSize: 12),
                                          color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),

        SliverToBoxAdapter(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(right: 16,left: 16),
                height: 170,
                width: MediaQuery.of(context).size.width,
                child: Image(
                  image: AssetImage(
                    "assets/hi1.jpg",
                  ),
                  fit: BoxFit.fill,
                ),
              ),
              // Container(
              //   height: MediaQuery.of(context).size.height * 0.25,
              //   width: MediaQuery.of(context).size.width,
              //   // color: Colors.grey,
              //   child: FutureBuilder<StaticBanner>(
              //     future: getStaticBanner(),
              //     builder: (context, snapshot) {
              //       if (!snapshot.hasData) {
              //         return Center(
              //           child: CircularProgressIndicator(),
              //         );
              //       } else if (snapshot.hasError) {
              //         return Center(
              //           child: Text('Error while fetching product s'),
              //         );
              //       } else
              //         return PageView.builder(
              //             controller: _controller,
              //             itemCount: snapshot.data.data.length,
              //             scrollDirection: Axis.horizontal,
              //             itemBuilder: (context, index) {
              //               return InkWell(
              //                 onTap: () async {
              //                   if (await canLaunch(
              //                       snapshot.data.data[index].link)) {
              //                     await launch(
              //                       snapshot.data.data[index].link,
              //                     );
              //                   } else {
              //                     throw 'Could not launch ${snapshot.data.data[index].link}';
              //                   }
              //                 },
              //                 child: Padding(
              //                   padding:
              //                       const EdgeInsets.symmetric(horizontal: 0),
              //                   child: Card(
              //                     elevation: 3,
              //                     child: Container(
              //                       width: 400,
              //                       // margin: EdgeInsets.all(40),
              //                       padding: EdgeInsets.only(
              //                         right: 400,
              //                       ),
              //                       color: Colors.grey[350],
              //                       child: Row(
              //                         children: [
              //                           FadeInImage.assetNetwork(
              //                             placeholder: "assets/appLogo.png",
              //                             image:
              //                                 snapshot.data.data[index].image,
              //                             fit: BoxFit.fill,
              //                             height: MediaQuery.of(context)
              //                                     .size
              //                                     .height *
              //                                 0.25,
              //                             width: MediaQuery.of(context)
              //                                     .size
              //                                     .height *
              //                                 0.20,
              //                           ),
              //                           SizedBox(width: 8),
              //                           Flexible(
              //                             child: Column(
              //                               mainAxisAlignment:
              //                                   MainAxisAlignment.start,
              //                               crossAxisAlignment:
              //                                   CrossAxisAlignment.start,
              //                               children: [
              //                                 SizedBox(height: 10),
              //                                 Text(
              //                                   snapshot.data.data[index].title,
              //                                   maxLines: 2,
              //                                   style: TextStyle(
              //                                       fontSize:
              //                                           _size.width * .035,
              //                                       fontWeight:
              //                                           FontWeight.bold),
              //                                 ),
              //                                 SizedBox(height: 7),
              //                                 Text(
              //                                   "Description",
              //                                   style: TextStyle(
              //                                       fontSize:
              //                                           _size.width * .030,
              //                                       fontWeight:
              //                                           FontWeight.bold),
              //                                 ),
              //                                 SizedBox(height: 2),
              //                                 Expanded(
              //                                   child: Container(
              //                                     padding: EdgeInsets.only(
              //                                         bottom: 10),
              //                                     child: Text(
              //                                       snapshot.data.data[index]
              //                                           .description,
              //                                       style: TextStyle(
              //                                         fontSize:
              //                                             _size.width * .030,
              //                                       ),
              //                                     ),
              //                                   ),
              //                                 )
              //                               ],
              //                             ),
              //                           )
              //                         ],
              //                       ),
              //                     ),
              //                   ),
              //                 ),
              //               );
              //             });
              //     },
              //   ),
              // ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        child: Text("Common Symptoms",
                            style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500)))),
                    allSymptoms.length > 5
                        ? InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AllSymptomsScreen(
                                    allSymptoms: allSymptoms,
                                    allDoctors: allDoctors,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              child: Text("See All",
                                  style: GoogleFonts.montserrat(
                                      textStyle: TextStyle(fontSize: 15))),
                            ),
                          )
                        : Container()
                  ],
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),

        SliverGrid.count(
          crossAxisCount:
              MediaQuery.of(context).orientation == Orientation.landscape
                  ? 4
                  : 3,
          children: List.generate(
            12,
            (index) {
              return Container(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ontext) => CategoriesInClinics(
                                  categoryId: 11,
                                  allDoctors: allDoctors,
                                  speciality: allSymptoms[index].name,
                                )));
                  },
                  child: Card(
                    elevation: 2,
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        allSymptoms[index].icon != null
                            ? Flexible(
                                flex: 3,
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: Colors
                                        .primaries[Random()
                                            .nextInt(Colors.primaries.length)]
                                        .shade200,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: FadeInImage.assetNetwork(
                                      width: itemHeight,
                                      // height: itemHeight * .7,
                                      placeholder: "assets/appLogo.png",
                                      image: allSymptoms[index].icon,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              )
                            : Image.asset("assets/appLogo.png"),
                        Flexible(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.center,
                            // height: itemHeight * .15,
                            // padding: EdgeInsets.all(5),
                            child: Text(allSymptoms[index].name,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                        fontSize: itemWidth * .06,
                                        fontWeight: FontWeight.w500))),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
