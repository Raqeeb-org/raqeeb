import 'package:flutter/material.dart';
import 'morningTrip.dart';
import 'driverAfrenonTrip.dart';
import 'package:raqeeb/widgets/schedule_card_widget.dart'; // Import the widget

class driverHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Image section
          Image.asset(
            'assets/images/header.png',
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
          ),
          // Title section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Schedules',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.amber[700],
              ),
            ),
          ),
          // Schedule Cards section
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                ScheduleCardWidget(
                  day: [
                    'Sun',
                    'Mon',
                    'Tue',
                    'Wed',
                    'Thu',
                    'Fri',
                    'Sat'
                  ][DateTime.now().weekday % 7],
                  date: DateTime.now().day.toString(),
                  tripTime: 'Morning trip: Start (6:00 AM) - End (8:00 AM)',
                  onSeeTripPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MorningTripScreen()),
                    );
                  },
                ),
                const SizedBox(height: 16),
                ScheduleCardWidget(
                  day: [
                    'Sun',
                    'Mon',
                    'Tue',
                    'Wed',
                    'Thu',
                    'Fri',
                    'Sat'
                  ][DateTime.now().weekday % 7],
                  date: DateTime.now().day.toString(),
                  tripTime: 'Afternoon trip: Start (2:00 PM) - End (4:00 PM)',
                  onSeeTripPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AfternoonTripScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
