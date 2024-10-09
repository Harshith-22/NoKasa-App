import 'package:flutter/material.dart';

class PickupScheduledPage extends StatelessWidget {
  const PickupScheduledPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'NoKasa',
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.calendar_today_rounded,
              color: Colors.green,
              size: 100,
            ),
            SizedBox(height: 20),
            Text(
              'Pickup Scheduled',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
