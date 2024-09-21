import 'package:flutter/material.dart';
import 'package:raqeeb/screens/admins/SchoolBuses.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Banner Section with the image
            Stack(
              children: [
                Image.asset(
                  'assets/images/header.png', // School banner image
                  width: double.infinity,
                  fit: BoxFit.cover,
                  height: 200,
                ),
              ],
            ),

            // Schedules Title
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Schedules',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 255, 199, 14),
                ),
              ),
            ),

            // Morning Trip Widget
            TripCard(
              title: 'Morning Trips',
              icon: Icons.wb_sunny,
              onArrowClick: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SchoolBusesScreen()),
                );
              },
            ),

            // Afternoon Trip Widget
            TripCard(
              title: 'Afternoon Trips',
              icon: Icons.wb_sunny_outlined,
              onArrowClick: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SchoolBusesScreen()),
                );
              },
            ),
          ],
        ),
      ),
      // Add the reusable navigation bar here
    );
  }
}

// TripCard Widget (For Reuse)
class TripCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onArrowClick;

  const TripCard({
    required this.title,
    required this.icon,
    required this.onArrowClick,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Container(
        width: double.infinity, // Ensures it takes full width
        height: 90, // Fixed height to match the design in the image
        decoration: BoxDecoration(
          color: const Color.fromARGB(
              255, 252, 196, 113), // Yellow background color
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3), // Shadow positioning
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Leading Icon and Title
              Row(
                children: [
                  const SizedBox(width: 10),
                  Icon(
                    icon,
                    size: 40,
                    color: const Color.fromARGB(255, 201, 129, 36),
                  ),
                  const SizedBox(width: 10), // Space between icon and title
                  // Vertical Divider
                  Container(
                    width: 1,
                    height: 60,
                    color: Colors.black54,
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              // Arrow Button
              IconButton(
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black54,
                  size: 30,
                ),
                onPressed: onArrowClick,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
