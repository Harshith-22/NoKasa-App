import 'dart:convert';
import 'package:flutter/material.dart';
// For location services
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nokasa_app/complete_address_page.dart'; // For Google Maps

import 'package:nokasa_app/context/data_provider.dart';

import 'package:nokasa_app/select_location_screen.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class SearchLocationPage extends StatefulWidget {
  const SearchLocationPage({super.key});

  @override
  State<SearchLocationPage> createState() => _SearchLocationPageState();
}

class _SearchLocationPageState extends State<SearchLocationPage> {
  TextEditingController textController = TextEditingController();
  var uuid = const Uuid();
  String _sessionToken = '123456';
  List<dynamic> placesList = [];
  double latitude = 0;
  double longitude = 0;
  LatLng? selectedLocation;
  // Function to get current location
  @override
  void initState() {
    super.initState();
    textController.addListener(() {
      onChange();
    });
  }

  void onChange() {
    if (_sessionToken.isEmpty) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
    getSuggestion(textController.text);
  }

  void getSuggestion(String input) async {
    // ignore: no_leading_underscores_for_local_identifiers, non_constant_identifier_names
    final _kAPI_KEY = 'AIzaSyAQG14EFZsihB2VMa5IJoflL2P_DGSoBXA';
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String requestURL =
        '$baseURL?input=$input&key=$_kAPI_KEY&sessiontoken=$_sessionToken';

    var response = await http.get(Uri.parse(requestURL));
    //var responseData = response.body.toString();
    //print(responseData);
    if (response.statusCode == 200) {
      setState(() {
        placesList = jsonDecode(response.body.toString())['predictions'];
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  // Future<void> _getCurrentLocation() async {
  //   bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     return Future.error('Location services are disabled.');
  //   }

  //   LocationPermission permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       return Future.error('Location permissions are denied.');
  //     }
  //   }

  //   if (permission == LocationPermission.deniedForever) {
  //     return Future.error('Location permissions are permanently denied.');
  //   }

  //   Position position = await Geolocator.getCurrentPosition(
  //       locationSettings: LocationSettings(
  //     accuracy: LocationAccuracy.high, // Updated to 'accuracy'
  //     distanceFilter: 100,
  //   ));

  //   setState(() {
  //     selectedLocation = LatLng(position.latitude, position.longitude);
  //     latitude = position.latitude;
  //     longitude = position.longitude;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          '',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0), // Height of the line
          child: Container(
            height: 1.0, // Height of the line
            color: Colors.grey, // Color of the line
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle, color: Colors.green, size: 32),
            onPressed: () {
              // Handle account button pressed
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: const Text(
              'Search Location',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              controller: textController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: "Search for area, street name...",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Visibility(
            visible: textController.text.isEmpty ? false : true,
            child: Expanded(
              child: ListView.builder(
                itemCount: placesList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () async {
                      // List<Location> locations = await locationFromAddress(
                      //     placesList[index]['description']);
                      context
                          .read<DataProvider>()
                          .addAddress(placesList[index]['description']);
                      // context
                      //     .read<DataProvider>()
                      //     .addToAddressList(placesList[index]['description']);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CompleteAddressPage()),
                      );
                      setState(() {
                        // latitude = locations.last.latitude;
                        // longitude = locations.last.longitude;
                      });
                    },
                    leading: Icon(Icons.location_on, color: Colors.green),
                    selectedColor: Colors.green,
                    hoverColor: Colors.green,
                    title: Text(
                      placesList[index]['description'],
                    ),
                  );
                },
              ),
            ),
          ),
          Visibility(
            visible: textController.text.isEmpty ? true : false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SelectLocationScreen()),
                  );
                },
                child: Row(
                  children: [
                    Icon(Icons.my_location),
                    SizedBox(width: 10),
                    Text("Use your current location",
                        style: TextStyle(color: Colors.green)),
                  ],
                ),
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(5), // Adjust the radius here
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CompleteAddressPage()),
                );
              },
              child: Center(
                child: Text(
                  "Add Address",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
