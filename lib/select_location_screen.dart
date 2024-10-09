import 'dart:async';
import 'package:geocoding/geocoding.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nokasa_app/complete_address_page.dart';
import 'package:nokasa_app/context/data_provider.dart';

import 'package:nokasa_app/select_location_page.dart';
import 'package:provider/provider.dart';

class SelectLocationScreen extends StatefulWidget {
  const SelectLocationScreen({super.key});

  @override
  State<SelectLocationScreen> createState() => _SelectLocationScreenState();
}

class _SelectLocationScreenState extends State<SelectLocationScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  CameraPosition _kCharminar = CameraPosition(
    target: LatLng(17.361431, 78.474533),
    zoom: 18,
  );

  void _getUserLocation() async {
    Position position = await _getCurrentLocation();
    _kCharminar = CameraPosition(
      target: LatLng(position.latitude, position.longitude),
      zoom: 18,
    );
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(_kCharminar),
    );
  }

  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied.');
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
  }

  String setAddress = "";
  Future<void> _getAddressFromLatLng(double lat, double lng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        setState(() {
          setAddress =
              "${place.name},${place.street} , ${place.locality}, ${place.administrativeArea}, ${place.country}";
        });
      } else {
        setState(() {
          setAddress = "No address found";
        });
      }
    } catch (e) {
      setState(() {
        setAddress = "Error fetching address: $e";
      });
    }
  }

  @override
  void initState() {
    super.initState();

    _getUserLocation();
  }

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
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Picking up From',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {
                  // Navigate to select address page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SelectLocationPage()),
                  );
                },
                child: const Text('Change',
                    style: TextStyle(color: Colors.orange)),
              )
            ],
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.green.shade100,
                  Colors.white
                ], // Gradient colors
                begin: Alignment.topLeft, // Start position
                end: Alignment.bottomRight, // End position
              ),
            ),
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            child: Row(
              children: [
                Icon(Icons.location_on),
                Expanded(
                  child: Text(setAddress),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Stack(
                children: [
                  GoogleMap(
                    mapType: MapType.hybrid,
                    initialCameraPosition: _kCharminar,
                    myLocationButtonEnabled: true,
                    myLocationEnabled: true,
                    //markers: Set<Marker>.of(),
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                    onCameraMove: (CameraPosition position) async {
                      _getAddressFromLatLng(
                          position.target.latitude, position.target.longitude);
                    },
                  ),
                  Center(
                      child: Icon(Icons.location_on,
                          size: 50, color: Colors.redAccent))
                ],
              ),
            ),
          ),
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
                context.read<DataProvider>().addAddress(setAddress);
                //context.read<DataProvider>().addToAddressList(setAddress);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CompleteAddressPage()),
                );
              },
              child: Center(
                child: Text(
                  "Confirm location & proceed",
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
