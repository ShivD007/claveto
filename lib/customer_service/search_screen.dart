import 'package:claveto/all_user_types/all_doctors.dart';
import 'package:claveto/all_user_types/all_labs.dart';
import 'package:claveto/model/home_screen_model.dart';
import 'package:flutter/material.dart';

import '';

class SearchScreen extends StatefulWidget {
  final List<Doctor> allDoctors;

  final List<Symptom> allsymptoms;

  final List<Category> allcategories;

  final List<Lab> alllabs;

  const SearchScreen(
      {Key key,
      this.allDoctors,
      this.allsymptoms,
      this.allcategories,
      this.alllabs})
      : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Doctor> allDoctors = [];

  List<Symptom> allSymptoms = [];
  List<Category> allCategories = [];

  List<Lab> allLabs = [];
  bool isSearchingItems;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isSearchingItems = false;
    allDoctors = widget.allDoctors;
    allSymptoms = widget.allsymptoms;
    allCategories = widget.allcategories;
    allLabs = widget.alllabs;
  }

  List filteredList = [];
  Map filteredMap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
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
        centerTitle: true,
        title: Container(
          width: MediaQuery.of(context).size.width,
          height: 45,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.white.withOpacity(0.5)),
          child: TextFormField(
            cursorColor: Colors.white,
            onChanged: (value) {
              searchByName(value);
            },
            decoration: new InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding:
                    EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                hintText: 'Search..',
                hintStyle: TextStyle(color: Colors.white),
                suffixIcon: Icon(
                  Icons.search,
                  color: Colors.white,
                )),
          ),
        ),
        // actions: [
        //   InkWell(
        //     child: Container(
        //         margin: EdgeInsets.only(left: 5, right: 25),
        //         child: Icon(
        //           Icons.filter_list,
        //           color: Colors.white,
        //         )),
        //   )
        // ],
      ),
      body: Container(
        child: filteredMap == null
            ? Center(
                child: Text('Search Here'),
              )
            : filteredMap.values.toList().isEmpty
                ? Center(child: Text('No item found'))
                : ListView.separated(
                    itemCount: filteredMap.values.toList().length,
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(),
                    itemBuilder: (BuildContext ctxt, int index) {
                      print(
                          'List ${filteredMap.values.toList().isEmpty} ${filteredMap.values.toList().length}');
                      if (filteredMap.values.toList().isEmpty) {
                        return Center(child: Text('No item found'));
                      } else
                        switch (filteredMap.keys
                            .toList()[index]
                            .toString()
                            .substring(0, 1)) {
                          case '1':
                            return horizontalDoctorCard(
                                filteredMap.values.toList()[index], context,
                                isSearch: true);
                            break;
                          case '2': //
                            return horizontalLabCard(
                                filteredMap.values.toList()[index], context,
                                isSearch: true);
                        }
                      return horizontalDoctorCard(
                        filteredMap.values.toList()[index],
                        context,
                      );
                    }),
      ),
    );
  }

  searchByName(String name) {
    filteredMap = {};
    isSearchingItems = true;
    setState(() {});
    print('All doctors Length ${allDoctors.length}');
    for (int i = 0; i < allDoctors.length; i++) {
      Doctor element = allDoctors[i];
      bool shouldSearch = true;

      print('Searching $i ${element.doctorDetailsNew.middleName}');

      if (element.doctorDetailsNew.middleName != null) {
        if (element.doctorDetailsNew.middleName
                .toLowerCase()
                .contains(name.toLowerCase()) ||
            element.doctorDetailsNew.firstName
                .toLowerCase()
                .contains(name.toLowerCase()) ||
            element.doctorDetailsNew.lastName
                .toLowerCase()
                .contains(name.toLowerCase()) ||
            element.doctorDetailsNew.speciality
                .toLowerCase()
                .contains(name.toLowerCase())) {
          print('Element Found ${element.doctorDetailsNew.userId}');
          //filteredMap = {'1${element.userId}': element};
          filteredMap['1${element.doctorDetailsNew.userId}'] = element;
          shouldSearch = false;
        }
      }
    }
    print('All Labs Length ${allLabs.length}');
    for (int i = 0; i < allLabs.length; i++) {
      Lab element = allLabs[i];
      print('Searching $i ${element.labDetailsNew.legalName}');
      if (element.labDetailsNew.legalName != null) {
        if (element.labDetailsNew.legalName
                .toLowerCase()
                .contains(name.toLowerCase()) ||
            element.labDetailsNew.firstName
                .toLowerCase()
                .contains(name.toLowerCase()) ||
            element.labDetailsNew.middleName
                .toLowerCase()
                .contains(name.toLowerCase()) ||
            element.labDetailsNew.lastName
                .toLowerCase()
                .contains(name.toLowerCase())) {
          print('Element Found ${element.labDetailsNew.userId}');
          //filteredMap = {'1${element.userId}': element};
          filteredMap['2${element.labDetailsNew.userId}'] = element;
        }
      }
    }
    print('All Labs Length ${allLabs.length}');

    isSearchingItems = false;
    setState(() {});
  }
}
