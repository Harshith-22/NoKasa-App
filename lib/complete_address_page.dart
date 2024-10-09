import 'package:flutter/material.dart';
import 'package:nokasa_app/context/data_provider.dart';
import 'package:nokasa_app/home_page.dart';
import 'package:nokasa_app/select_location_page.dart';
import 'package:provider/provider.dart';

class CompleteAddressPage extends StatefulWidget {
  const CompleteAddressPage({super.key});

  @override
  State<CompleteAddressPage> createState() => _CompleteAddressPageState();
}

class _CompleteAddressPageState extends State<CompleteAddressPage> {
  // String selectedAddress =
  //     'HSR BDA Complex\n12th main Road, Sector 6, HSR layout';

  final TextEditingController flatController = TextEditingController();
  final TextEditingController floorController = TextEditingController();
  final TextEditingController landmarkController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final address = context.watch<DataProvider>().selectedAddress;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          '',
          style: TextStyle(
            color: Colors.black,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0), // Height of the line
          child: Container(
            height: 1.0, // Height of the line
            color: Colors.grey, // Color of the line
          ),
        ),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Complete Address',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Add an address so we can pick up trash',
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            SizedBox(height: 20),

            // Selected Address Box
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Area',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Navigate to select address page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SelectLocationPage()),
                        );
                      },
                      child: const Text('change',
                          style: TextStyle(color: Colors.orange)),
                    ),
                  ],
                ),
                Container(
                  color: Colors.grey.shade100,
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
              ],
            ),

            SizedBox(height: 20),

            // Address Form Fields
            TextField(
              controller: flatController,
              decoration: InputDecoration(
                labelText: 'Flat / House no / Building name *',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: floorController,
              decoration: InputDecoration(
                labelText: 'Floor',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: landmarkController,
              decoration: InputDecoration(
                labelText: 'Nearby landmark',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(
                labelText: 'Alternate Phone Number',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.person),
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 20),
            const Spacer(),
            // Save Address Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if ((flatController.text.isNotEmpty &&
                      floorController.text.isNotEmpty &&
                      landmarkController.text.isNotEmpty &&
                      phoneController.text.isNotEmpty)) {
                    //Add address to saved addresslist and navigate
                    final addData = {
                      "flatNo": flatController.text,
                      "floorNo": floorController.text,
                      "landmark": landmarkController.text,
                      "phnNo": phoneController.text,
                      "address": address,
                    };
                    final data =
                        'Flat.no-${flatController.text},Floor.no-${floorController.text},$address';
                    context.read<DataProvider>().addToAddressList(addData);
                    context.read<DataProvider>().addHomeAddress(data);

                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => HomePage()),
                      (Route<dynamic> route) =>
                          false, // Remove all previous routes
                    );
                  } else {
                    // warning
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                            'Missing Rows',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          content: const Text('Fill all the required details'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                'Ok',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, // Background color
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(5), // Adjust the radius here
                  ), // Full width button
                ),
                child: Text(
                  'Save Address & Select Slot',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
