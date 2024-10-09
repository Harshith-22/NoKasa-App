import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nokasa_app/context/data_provider.dart';
import 'package:nokasa_app/pickup_scheduled.dart';
import 'package:nokasa_app/select_location_page.dart';
import 'package:nokasa_app/select_slot_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<dynamic> listOfTrash = [
    FaIcon(
      FontAwesomeIcons.newspaper,
      size: 38,
      color: Colors.grey.shade600,
    ),
    FaIcon(
      FontAwesomeIcons.bottleWater,
      size: 38,
      color: Colors.grey.shade600,
    ),
    FaIcon(
      FontAwesomeIcons.sheetPlastic,
      size: 38,
      color: Colors.grey.shade600,
    ),
    FaIcon(
      FontAwesomeIcons.dumpster,
      size: 38,
      color: Colors.grey.shade600,
    ),
    FaIcon(
      FontAwesomeIcons.bowlFood,
      size: 38,
      color: Colors.grey.shade600,
    ),
    FaIcon(
      FontAwesomeIcons.tablets,
      size: 38,
      color: Colors.grey.shade600,
    ),
  ];
  final List<String> trashItemsList = [
    'Paper',
    'Glass',
    'Plastic',
    'Dry Waste',
    'Food',
    'Medical',
  ];
  Map<String, bool> selectedTrash = {};
  final String defaultAdd = "Add Address";
  @override
  void initState() {
    super.initState();
    // Initialize selectedTrash map with false for each trash item
    for (var item in trashItemsList) {
      selectedTrash[item] = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final slot = context.watch<DataProvider>().selectedSlot;
    final address = context.watch<DataProvider>().homeAddress;
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.public, color: Colors.green, size: 32),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'NoKasa',
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
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: 800,
          //height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Schedule Pickup',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // Address Section
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Address',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Visibility(
                        visible: address == defaultAdd ? false : true,
                        child: TextButton(
                          onPressed: () {
                            // Navigate to select address page
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SelectLocationPage()),
                            );
                          },
                          child: const Text('change',
                              style: TextStyle(color: Colors.orange)),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      if (address == defaultAdd) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SelectLocationPage()),
                        );
                      }
                    },
                    child: Container(
                      //color: Colors.green.shade50,
                      padding: EdgeInsets.all(16),
                      constraints: BoxConstraints(minHeight: 60),
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
                      width: double.infinity,
                      child: Row(
                        children: [
                          (address != defaultAdd)
                              ? Icon(Icons.location_on)
                              : Text(""),
                          Expanded(
                            child: (address == defaultAdd)
                                ? Center(
                                    child: Text(address),
                                  )
                                : Text(address),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Select Slot Section
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Select Slot',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Visibility(
                        visible: slot == "Select" ? false : true,
                        child: TextButton(
                          onPressed: () {
                            // Navigate to select address page
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SelectSlotPage()),
                            );
                          },
                          child: const Text('Change',
                              style: TextStyle(color: Colors.orange)),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      if (slot == "Select") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SelectSlotPage()),
                        );
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(16),
                      width: double.infinity,
                      //color: Colors.green.shade50,
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
                      height: 60,
                      child: Center(
                        child: Text(slot),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Trash Selection Section
              const Text('Choose Trash',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 1.25,
                    ),
                    itemCount: trashItemsList.length,
                    itemBuilder: (context, index) {
                      final item = trashItemsList[index];
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedTrash[item] = !selectedTrash[item]!;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: selectedTrash[item]!
                                  ? [
                                      Colors.orange.shade300,
                                      Colors.orange.shade100
                                    ]
                                  : [
                                      Colors.green.shade50,
                                      Colors.white
                                    ], // Gradient colors
                              begin: Alignment.topLeft, // Start position
                              end: Alignment.bottomRight, // End position
                            ),
                            color: selectedTrash[item]!
                                ? Colors.orange.shade50
                                : Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: selectedTrash[item]!
                                  ? Colors.orange
                                  : Colors.white,
                              width: 1,
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Icon(Icons.delete_outline_rounded,
                              //     color: selectedTrash[item]!
                              //         ? Colors.orange.shade700
                              //         : Colors.black),
                              listOfTrash[index],
                              const SizedBox(height: 4),
                              Text(item,
                                  style: TextStyle(
                                      color: selectedTrash[item]!
                                          ? Colors.orange.shade700
                                          : Colors.black)),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              // Buttons at the bottom
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Items Count Button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(5), // Adjust the radius here
                      ),
                    ),
                    onPressed: () {
                      // Handle items selected action
                    },
                    child: Text(
                      '${selectedTrash.values.where((isSelected) => isSelected).length} Items',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),

                  // Schedule Pickup Button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(5), // Adjust the radius here
                      ),
                    ),
                    onPressed: () {
                      // Handle schedule pickup action
                      int selectedItemsCount = selectedTrash.values
                          .where((isSelected) => isSelected)
                          .length;
                      if (slot == "Select" ||
                          address == defaultAdd ||
                          selectedItemsCount == 0) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(
                                'Missing Rows',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              content:
                                  const Text('Fill all the required details'),
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
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const PickupScheduledPage()),
                        );
                      }
                    },
                    child: const Text(
                      'Schedule Pickup',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
