import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nokasa_app/context/data_provider.dart';
import 'package:nokasa_app/home_page.dart';
import 'package:provider/provider.dart';

class SelectSlotPage extends StatefulWidget {
  const SelectSlotPage({super.key});

  @override
  State<SelectSlotPage> createState() => _SelectSlotPageState();
}

class _SelectSlotPageState extends State<SelectSlotPage> {
  int selectedDayIndex = 0;
  int? selectedSlotIndex;

  final List<String> slots = [
    "06:00 - 07:00 AM",
    "06:30 - 07:30 AM",
    "07:00 - 08:00 AM",
    "07:30 - 08:30 AM",
    "08:00 - 09:00 AM",
    "08:30 - 09:30 AM",
    "09:00 - 10:00 AM",
    "09:30 - 10:30 AM",
    "10:00 - 11:00 AM",
    "10:30 - 11:30 AM",
    "11:00 - 12:00 AM",
    "11:30 - 12:30 AM",
    "12:00 - 01:00 PM",
    "12:30 - 01:30 PM",
    "01:00 - 02:00 PM",
    "01:30 - 02:30 PM",
    "02:00 - 03:00 PM",
    "02:30 - 03:30 PM",
    "03:00 - 04:00 PM",
    "03:30 - 04:30 PM",
    "04:00 - 05:00 PM",
    "04:30 - 05:30 PM",
    "05:00 - 06:00 PM",
    "05:30 - 06:30 PM",
    "06:00 - 07:00 PM",
    "06:30 - 07:30 PM",
  ];

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
          // Date selection (10 days from today)
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: const Text(
              'Schedule Pickup',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: double.infinity, height: 15),
          Container(
            height: 70,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) {
                DateTime date = DateTime.now().add(Duration(days: index));
                String day = DateFormat('EEE').format(date); // E.g., "Wed"
                String dateNumber = DateFormat('d').format(date); // E.g., "10"
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedDayIndex = index;
                      selectedSlotIndex =
                          null; // Clear the selected slot when a new day is chosen
                    });
                  },
                  child: Container(
                    width: 80,
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      color: selectedDayIndex == index
                          ? Colors.orange.shade100
                          : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: selectedDayIndex == index
                            ? Colors.orange
                            : Colors.grey,
                        width: 1,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          dateNumber,
                          style: TextStyle(
                            fontSize: 16,
                            color: selectedDayIndex == index
                                ? Colors.orange
                                : Colors.black,
                          ),
                        ),
                        Text(
                          day,
                          style: TextStyle(
                            fontSize: 14,
                            color: selectedDayIndex == index
                                ? Colors.orange
                                : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: double.infinity, height: 15),
          // Time Slot Selection
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 2.75,
                ),
                itemCount: slots.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedSlotIndex = index;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: selectedSlotIndex == index
                            ? Colors.green.shade100
                            : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: selectedSlotIndex == index
                              ? Colors.green
                              : Colors.grey,
                          width: 1,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          slots[index],
                          style: TextStyle(
                            fontSize: 14,
                            color: selectedSlotIndex == index
                                ? Colors.green
                                : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // Select & Pick Items Button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(5), // Adjust the radius here
                ),
              ),
              onPressed: selectedSlotIndex != null
                  ? () {
                      // Handle slot selection and navigate to next page
                      String slot = '';
                      String slotTime = slots[selectedSlotIndex as int];
                      DateTime date =
                          DateTime.now().add(Duration(days: selectedDayIndex));
                      String fulldateTime =
                          DateFormat('EEE dd MMMM ').format(date);
                      slot = '$fulldateTime, $slotTime';
                      context.read<DataProvider>().selectSlot(slot);
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => HomePage()),
                        (Route<dynamic> route) =>
                            false, // Remove all previous routes
                      );
                    }
                  : null, // Disable button if no slot is selected
              child: Center(
                child: Text(
                  "Select & Pick Items",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color:
                        selectedSlotIndex != null ? Colors.white : Colors.black,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
