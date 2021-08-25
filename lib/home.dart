import 'package:claveto/appointments.dart';
import 'package:claveto/common/constant.dart';
import 'package:claveto/common/keys.dart';
import 'package:claveto/common/loading.dart';
import 'package:claveto/editprofile.dart';
import 'package:claveto/main.dart';
import 'package:claveto/model/home_screen_model.dart';

import 'package:claveto/reports/diagnosis.dart';
import 'package:claveto/reports/reports.dart';
import 'package:claveto/rest/api_services.dart';
import 'package:claveto/supportcentre.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:location_permissions/location_permissions.dart';
import 'package:uuid/uuid.dart';

import 'blog/all_blogs.dart';
import 'customer_service/customer_service.dart';
import 'customer_service/search_screen.dart';
import 'familymemberList.dart';
import 'help.dart';

import 'model/get_family_member_model.dart';
import 'package:geocoder/geocoder.dart';
import 'model/home_screen_model.dart';
import 'search/search_screen.dart';
import 'package:claveto/all_user_types/all_labs.dart';
import 'package:share/share.dart';

GetFamilyMember model;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

List<Doctor> cachedAllDoctors = [];

class _HomeState extends State<Home> {
  List<Doctor> allDoctors = <Doctor>[];
  List<Symptom> allsymptoms = <Symptom>[];
  List<Category> allcategories = <Category>[];

  List<Lab> alllabs = <Lab>[];
  List<Widget> homeScreenWidgets = [];
  List<Banners> allBanners = [];
  bool isLocationEnable;
  String selectedAddress;

  @override
  void initState() {
    super.initState();

    //fetchCurrentLocation();
    selectedAddress = '';
    _determinePosition();

    homeScreenWidgets = [
      Center(),
      Center(),
      Center(
        child: Text('Offers Screen'),
      )
      //SearchScreen(),
    ];
    // if(isLocationEnable){
    //   // Future.delayed(Duration(milliseconds: 1000), () {
    //   //   getHomeDataAPI();
    //   // });
    //   homeScreenWidgets = [
    //     Center(),
    //     Center(),
    //     Center(
    //       child: Text('Offers Screen'),
    //     )
    //     //SearchScreen(),
    //   ];
    //
    // }
  }

  Position userCurrentPosition;

  Future<Position> fetchCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    await setCoordinates(position.latitude, position.longitude);
    List<Placemark> placeMarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark currentPlaceMark = placeMarks[0];
    selectedAddress =
        '${currentPlaceMark.name} ${currentPlaceMark.subAdministrativeArea} ${currentPlaceMark.administrativeArea}';
    print('Place ${currentPlaceMark.toJson()}');
    return position;
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    // if (!serviceEnabled) {
    //   return Future.error('Location services are disabled.');
    // }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      isLocationEnable = false;
      permission = await Geolocator.requestPermission();
      setState(() {});
      return Future.error(
          'Location permissions are permantly denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        isLocationEnable = false;
        setState(() {});
        return Future.error(
            'Location permissions are denied (actual value: $permission).');
      }
    } else if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      try {
        userCurrentPosition = await fetchCurrentLocation();
      } catch (e) {
        print('Error While fetching address');
      }

      await getHomeDataAPI();
      setState(() {
        isLocationEnable = true;
      });
    }
    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      try {
        userCurrentPosition = await fetchCurrentLocation();
      } catch (e) {
        print('Error While fetching address');
      }

      await getHomeDataAPI();
      setState(() {
        isLocationEnable = true;
      });
    }
    setState(() {});
    return await Geolocator.getCurrentPosition();
  }

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    print('URl ${getPrefValue(Keys.PROFILE_PIC).toString().isEmpty}');
    return Scaffold(
      drawer: allDoctors == null
          ? Drawer()
          : Drawer(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Color(0xff14B4A5),
                      Color(0xff3883EF),
                    ],
                  ),
                ),
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(top: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0.0, vertical: 15),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white, shape: BoxShape.circle),
                              child: getPrefValue(Keys.PROFILE_PIC) != null ||
                                      getPrefValue(Keys.PROFILE_PIC) != '' ||
                                      !getPrefValue(Keys.PROFILE_PIC)
                                          .toString()
                                          .isEmpty
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(32.5),
                                      child: FadeInImage.assetNetwork(
                                        width: 65,
                                        height: 65,
                                        placeholder: "assets/appLogo.png",
                                        image: getPrefValue(Keys.PROFILE_PIC),
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : Image.asset(
                                      "assets/appLogo.png",
                                      width: 65,
                                      height: 65,
                                    ),
                            ),
                          ),
                          Column(
                            children: [
                              Container(
                                  width: 290,
                                  child: Text(getPrefValue(Keys.NAME),
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                      style: GoogleFonts.montserrat(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18)))),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditProfile()),
                                  );
                                },
                                child: Container(
                                    margin: EdgeInsets.all(10),
                                    child: Text('View or Edit Profile',
                                        style: GoogleFonts.montserrat(
                                            textStyle: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10)))),
                              ),
                            ],
                          )
                        ],
                      ),
                      Divider(
                        indent: 50,
                        endIndent: 50,
                        color: Colors.white,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FamilyMemberList()),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  height: 37,
                                  width: 40,
                                  child: Image.asset(
                                    "assets/add.png",
                                  )),
                              Container(
                                  child: Text('Family members',
                                      style: GoogleFonts.montserrat(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15))))
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DiagnosisScreen()),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  height: 40,
                                  width: 40,
                                  child: Image.asset(
                                    "assets/rx.png",
                                  )),
                              Container(
                                  child: Text('Prescriptions',
                                      style: GoogleFonts.montserrat(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15))))
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AppointmentsScreen()),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  height: 40,
                                  width: 40,
                                  child: Image.asset(
                                    "assets/cal.png",
                                  )),
                              Container(
                                  child: Text('Appointments',
                                      style: GoogleFonts.montserrat(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15))))
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ReportsScreen()),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  height: 40,
                                  width: 40,
                                  child: Image.asset(
                                    "assets/micro.png",
                                  )),
                              Container(
                                  child: Text('Lab Reports',
                                      style: GoogleFonts.montserrat(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15))))
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AllLabsScreen(
                                      allLabs: alllabs,
                                    )),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  height: 40,
                                  width: 40,
                                  child: Image.asset(
                                    "assets/micro2.png",
                                  )),
                              Container(
                                  child: Text('Lab Tests',
                                      style: GoogleFonts.montserrat(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15))))
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SupportCentre()),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  height: 40,
                                  width: 40,
                                  child: Image.asset(
                                    "assets/help.png",
                                  )),
                              Container(
                                  child: Text('Support centre',
                                      style: GoogleFonts.montserrat(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15))))
                            ],
                          ),
                        ),
                      ),
                      Divider(
                        indent: 50,
                        endIndent: 50,
                        color: Colors.white,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Help()),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  margin: EdgeInsets.symmetric(horizontal: 15),
                                  height: 40,
                                  width: 40,
                                  child: Image.asset(
                                    "assets/quest.png",
                                  )),
                              Container(
                                  child: Text('Help center',
                                      style: GoogleFonts.montserrat(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15))))
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          clearPref();

                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyHomePage()),
                              (route) => false);
                        },
                        child: Container(
                          margin: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  margin: EdgeInsets.symmetric(horizontal: 15),
                                  height: 40,
                                  width: 40,
                                  child: Image.asset(
                                    "assets/logout.png",
                                  )),
                              Container(
                                  child: Text('Logout',
                                      style: GoogleFonts.montserrat(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15))))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
              icon: Icon(Icons.share),
              onPressed: () {
                Share.share(
                    " Consult online with top Doctors of India using advance 3D Body feature and book lab tests online.\n \n https://play.google.com/store/apps/details?id=com.infikeytechnologies.claveto \n \n Click here to download Claveto App",
                    subject:
                        "Claveto, India\'s no. 1 doctor Consultation app   DownLoad Claveto App on Playstore");
              })
        ],
        title: Image.asset(
          'assets/splash_screen/new_splash.png',
          width: MediaQuery.of(context).size.width * .35,
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
        // actions: [
        //   Container(
        //       width: 120,
        //       padding: EdgeInsets.symmetric(vertical: 20),
        //       child: Text(selectedAddress,
        //           maxLines: 1,
        //           overflow: TextOverflow.ellipsis,
        //           softWrap: true,
        //           style: GoogleFonts.montserrat(
        //               textStyle:
        //                   TextStyle(color: Colors.white, fontSize: 10)))),
        //   InkWell(
        //     onTap: () async {
        //       final sessionToken = Uuid().v4();
        //       final Suggestion result = await showSearch(
        //         context: context,
        //         delegate: AddressSearch(sessionToken),
        //       );
        //       // This will change the text displayed in the TextField
        //       if (result != null) {
        //         await getAddressListFromQuery(result.description);
        //         setState(() {});
        //         //changeLocationBottomSheet();
        //       }
        //     },
        //     child: Container(
        //         padding: EdgeInsets.all(20), child: Icon(Icons.location_on)),
        //   )
        // ],
        bottom: PreferredSize(
            child: InkWell(
              onTap: () async {
                final sessionToken = Uuid().v4();
                final Suggestion result = await showSearch(
                  context: context,
                  delegate: AddressSearch(sessionToken),
                );
                // This will change the text displayed in the TextField
                if (result != null) {
                  await getAddressListFromQuery(result.description);
                  setState(() {});
                  //changeLocationBottomSheet();
                }
              },
              child: Row(
                children: [
                  Container(
                      padding: EdgeInsets.only(left: 20, top: 5, right: 4),
                      child: Icon(
                        Icons.location_on,
                        color: Colors.white,
                        size: 15,
                      )),
                  Container(
                      constraints: BoxConstraints(
                        minWidth: 10,
                        maxWidth: MediaQuery.of(context).size.width * .7,
                      ),

                      // width: MediaQuery.of(context).size.width * .7,
                      child: Text(selectedAddress,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          // softWrap: true,
                          style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                  color: Colors.white, fontSize: 15)))),
                  Container(
                      child: Icon(
                    Icons.expand_more,
                    color: Colors.white,
                  )),
                ],
              ),
            ),
            preferredSize: Size.fromHeight(20.0)),
      ),
      body: isLocationEnable == null
          ? Center(
              child: Container(
                height: 200,
                width: 200,
                child: Loading(),
              ),
            )
          : isLocationEnable == true
              ? homeScreenWidgets[_currentIndex]
              : noServiceEnabelWidget(),
      bottomNavigationBar: Container(
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color(0xff14B4A5),
                  Color(0xff3883EF),
                ],
              ),
              borderRadius: BorderRadius.circular(20)),
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            currentIndex: _currentIndex,
            onTap: (index) {
              _currentIndex = index;
              setState(() {});
            },
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Container(
                      child: Icon(
                    Icons.home,
                    color: Colors.white,
                    size: 37,
                  )),
                  title: Text('Home')),
              BottomNavigationBarItem(
                  icon: Container(
                      child: Icon(Icons.search, color: Colors.white, size: 37)),
                  title: Text('Search')),
              BottomNavigationBarItem(
                  icon: Container(
                      child:
                          Icon(Icons.post_add, color: Colors.white, size: 37)),
                  title: Text('Blog')),
            ],
            fixedColor: Colors.white,
          )),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  clearPref() {
    setPrefValue(Keys.TOKEN, "");
    clearAllPrefs();
  }

  Future<void> getHomeDataAPI() async {
    //showDialog(context: context, builder: (context) => Loading());
    await getHomeData(userCurrentPosition.latitude ?? 22,
            userCurrentPosition.longitude ?? 77)
        .then((response) {
      print('Doctors ${response.doctors.toList().length}');
      response.doctors.toList().forEach((element) {
        print('Doctor Details ${element.toJson()}');
      });

      allDoctors = response.doctors
          .toList()
          .where((element) =>
              element.isActive == 1 &&
              element.doctorDetailsNew.firstName != null &&
              element.doctorDetailsNew.pincode != null)
          .toList();

      allsymptoms = response.symptoms;

      print(allsymptoms.length);
      allcategories = response.categories;
      print('Category length ${allcategories.length}');
      allcategories.forEach((element) {
        print('Category ID ${element.id} with name ${element.name}');
      });

      alllabs = response.labs
          .toList()
          .where((element) =>
              element.isActive == 1 && element.labDetailsNew.legalName != null)
          .toList();
      ;
      allBanners = response.banners;
      print('Doctor 2 ${allDoctors.length}');
      cachedAllDoctors = allDoctors;
      homeScreenWidgets = [
        CustomerService(
          allcategories: allcategories,
          allDoctors: allDoctors,
          alllabs: alllabs,
          allsymptoms: allsymptoms,
          allBanners: allBanners,
        ),
        SearchScreen(
          allcategories: allcategories,
          allDoctors: allDoctors,
          alllabs: alllabs,
          allsymptoms: allsymptoms,
        ),
        AllBlogs() //SearchScreen(),
      ].toList();

      //SearchScreen(),
    });
    model = await getFamilyMemberList();
    setState(() {});
    // setState(() {});
    // Navigator.pop(context);
  }

  Widget noServiceEnabelWidget() {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                'https://www.umhs-adolescenthealth.org/wp-content/uploads/2016/12/google-map-background.jpg',
              ))),
      child: Container(
        color: Colors.white.withOpacity(0.8),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.lightBlueAccent.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(990)),
                  child: Image.network(
                    'https://freesvg.org/img/1392496432.png',
                    height: 250,
                  )),
              SizedBox(
                height: 120,
              ),
              Text(
                "We are unable to Locate you",
                style: TextStyle(color: Colors.black, fontSize: 28),
              ),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  margin: EdgeInsets.all(15),
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
                  child: InkWell(
                    onTap: () async {
                      bool isOpened =
                          await LocationPermissions().openAppSettings();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'Enable Location',
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  List<Address> address = [];

  changeLocationBottomSheet() {
    showModalBottomSheet<void>(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.9,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(25)),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        child: Text('Search Location',
                            style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                    fontSize: 25,
                                    color: Colors.lightBlueAccent)))),
                    Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        height: 30,
                        width: 30,
                        child: Image.asset('assets/close.png'))
                  ],
                ),
                Container(
                  height: 45,
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(.5),
                      borderRadius: BorderRadius.circular(590)),
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(590)),
                    child: TextFormField(
                      onChanged: (query) async {
                        await getAddressListFromQuery(query);
                        setState(() {});
                      },
                      decoration: new InputDecoration(
                        suffixIcon: Icon(
                          Icons.search,
                          color: Colors.blue.withOpacity(.7),
                        ),
                        hintText: "search",
                        hintStyle: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                                fontSize: 15)),
                        border: InputBorder.none,
                        //fillColor: Colors.green
                      ),
                    ),
                  ),
                ),
                address.length != 0
                    ? Container(
                        child: ListView.builder(
                            itemCount: address.length,
                            itemBuilder: (_, index) {
                              return Text(address[index].toMap().toString());
                            }),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              height: 30,
                              width: 30,
                              child: Icon(
                                Icons.my_location,
                                color: Colors.lightBlueAccent,
                              )),
                          Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              child: Text('Detect Current Location',
                                  style: GoogleFonts.montserrat(
                                      textStyle: TextStyle(
                                          fontSize: 15,
                                          color: Colors.lightBlueAccent)))),
                        ],
                      ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<List<Address>> getAddressListFromQuery(String query) async {
    //final query = "1600 Amphiteatre Parkway, Mountain View";
    var addresses = await Geocoder.local.findAddressesFromQuery(query);
    var first = addresses.first;
    print("Address From Query ${first.featureName} : ${first.coordinates}");
    userCurrentPosition = Position(
        longitude: first.coordinates.longitude,
        latitude: first.coordinates.latitude);

    getHomeDataAPI();
    selectedAddress = query;
    return addresses;
  }

  double calculateDistanceBetweenTwoPoints({
    Position clinicLabPosition,
    Position userPosition,
  }) {
    final distanceInMetres = Geolocator.distanceBetween(
            userPosition.latitude,
            userPosition.longitude,
            clinicLabPosition.latitude,
            clinicLabPosition.longitude) /
        1000;

    return distanceInMetres;
  }
}
