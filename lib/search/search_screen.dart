import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';

import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';

import 'package:http/http.dart';

// For storing our result
class Suggestion {
  final String placeId;
  final String description;

  Suggestion(this.placeId, this.description);

  @override
  String toString() {
    return 'Suggestion(description: $description, placeId: $placeId)';
  }
}

class PlaceApiProvider {
  final client = Client();

  PlaceApiProvider(this.sessionToken);

  final sessionToken;

  static final String androidKey = 'AIzaSyCPuEsCvU5_RfMNSe4U1RFS9uxkOXQ9Fz8';
  static final String iosKey = 'YOUR_API_KEY_HERE';
  final apiKey = Platform.isAndroid ? androidKey : iosKey;

  Future<List<Suggestion>> fetchSuggestions(String input, String lang) async {
    final request =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&types=address&language=$lang&components=country:in&key=$apiKey&sessiontoken=$sessionToken';
    final response = await client.get(request);
    print('Response ${response.body}');

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      //print('Result '+result);

      if (result['status'] == 'OK') {
        // compose suggestions in a list
        return result['predictions']
            .map<Suggestion>((p) => Suggestion(p['place_id'], p['description']))
            .toList();
      }
      if (result['status'] == 'ZERO_RESULTS') {
        return [];
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }

// Future<Place> getPlaceDetailFromId(String placeId) async {
//   // if you want to get the details of the selected place by place_id
// }
}

class AddressSearch extends SearchDelegate<Suggestion> {
  AddressSearch(this.sessionToken) {
    apiClient = PlaceApiProvider(sessionToken);
  }

  final sessionToken;
  PlaceApiProvider apiClient;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        tooltip: 'Clear',
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return null;
  }

  bool isLoading = false;

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: query == ""
          ? null
          : apiClient.fetchSuggestions(
              query, Localizations.localeOf(context).languageCode),
      builder: (context, snapshot) => query == ''
          ? Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Enter your address',
                    style: TextStyle(color: Colors.blueAccent, fontSize: 20),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  InkWell(
                      onTap: () {
                        fetchCurrentLocation(context);
                      },
                      child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.blueAccent),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Current Location ',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              Icon(
                                Icons.location_on_outlined,
                                color: Colors.white,
                              )
                            ],
                          ))),
                ],
              ),
            )
          : snapshot.hasData
              ? ListView.separated(
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                  itemBuilder: (context, index) => ListTile(
                    title: Text(
                      (snapshot.data[index] as Suggestion).description,
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                    leading: Icon(
                      Icons.my_location_sharp,
                      color: Colors.blueAccent.withOpacity(0.5),
                    ),
                    onTap: () {
                      close(context, snapshot.data[index] as Suggestion);
                    },
                  ),
                  itemCount: snapshot.data.length,
                )
              : Container(child: Text('Loading...')),
    );
  }

  fetchCurrentLocation(BuildContext context) async {
    //scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Loading...')));
    try {
      showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Text('Loading'),
            );
          });
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      // List<Placemark> placeMarks =
      // await placemarkFromCoordinates(position.latitude, position.longitude);
      // Placemark currentPlaceMark = placeMarks[0];
      // print('Place ${currentPlaceMark.toJson()}');
      // print('Place ${currentPlaceMark.toString()}');

      final coordinates =
          new Coordinates(position.latitude, position.longitude);
      var addresses =
          await Geocoder.local.findAddressesFromCoordinates(coordinates);
      var first = addresses.first;
      print(
          " Place 1 ${first.featureName} : ${first.addressLine} ${first.toMap()}  ");
      query = first.addressLine;

      Navigator.pop(context);
      apiClient.fetchSuggestions(
          first.addressLine, Localizations.localeOf(context).languageCode);
    } catch (e) {}
  }
}
