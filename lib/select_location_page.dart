import 'package:flutter/material.dart';
import 'package:nokasa_app/context/data_provider.dart';
import 'package:nokasa_app/home_page.dart';
import 'package:nokasa_app/search_location_page.dart';
import 'package:provider/provider.dart';

class SelectLocationPage extends StatefulWidget {
  const SelectLocationPage({super.key});

  @override
  State<SelectLocationPage> createState() => _SelectLocationPageState();
}

class _SelectLocationPageState extends State<SelectLocationPage> {
  @override
  Widget build(BuildContext context) {
    final savedAddressList = context.watch<DataProvider>().savedAddressList;
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
              'Select Location',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Visibility(
            visible: savedAddressList.isNotEmpty ? true : false,
            child: Flexible(
              child: ListView.builder(
                itemCount: savedAddressList.length,
                itemBuilder: (context, index) {
                  final addressData = savedAddressList[index];
                  final address =
                      'Flat.no-${addressData['flatNo']},Floor.no-${addressData['floorNo']},${addressData['address']}';
                  return GestureDetector(
                    onTap: () {
                      context.read<DataProvider>().addHomeAddress(address);
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => HomePage()),
                        (Route<dynamic> route) =>
                            false, // Remove all previous routes
                      );
                    },
                    child: Container(
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
                            child: Text(address),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SearchLocationPage()),
                  );
                },
                child: Text(
                  "+ Add New",
                  style: TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
