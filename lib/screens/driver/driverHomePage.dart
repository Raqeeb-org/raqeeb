import 'package:flutter/material.dart';
import 'morningTrip.dart';
import 'driverAfrenonTrip.dart';

class driverHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Image section
          Image.asset(
            'assets/images/header.png', // Ensure this asset exists in the right location
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
              children: const [
                ScheduleCard(
                  day: 'Sun',
                  date: '09',
                  tripTime: 'Morning trip: Start (6:00 AM) - End (8:00 AM)',
                  onSeeTripPressed: () {
                    Navigator.pushNamed(context, '/morningTrip');
                  },
                ),
                SizedBox(height: 16),
                ScheduleCard(
                  day: 'Sun',
                  date: '09',
                  tripTime: 'Afternoon trip: Start (2:00 PM) - End (4:00 PM)',
                  onSeeTripPressed: () {
                    Navigator.pushNamed(context, '/afternoonTrip');
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

class ScheduleCard extends StatelessWidget {
  final String day;
  final String date;
  final String tripTime;
  final VoidCallback onSeeTripPressed;

  const ScheduleCard({
    Key? key,
    required this.day,
    required this.date,
    required this.tripTime,
    required this.onSeeTripPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.orange[300],
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                day,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),
              Text(
                date,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                tripTime,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          TextButton(
            onPressed: onSeeTripPressed,
            child: Text('See my trip'),
          ),
        ],
      ),
    );
  }
}
