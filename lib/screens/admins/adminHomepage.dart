import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:raqeeb/screens/admins/SchoolBuses.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  AdminHomePageState createState() => AdminHomePageState();
}

class AdminHomePageState extends State<AdminHomePage> {
  // Variable to store the admin's username
  String? username;

  @override
  void initState() {
    super.initState();
    // Fetch the admin username when the widget is initialized
    fetchAdminUsername();
  }

  // Method to fetch the admin's username from Firestore
  Future<void> fetchAdminUsername() async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot adminSnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc('2J4DFh6Gxi9vNAmip0iA') // Assuming the Admins document's ID
          .collection('Admins') // The Admins subcollection
          .doc(userId) // Replace with the actual document ID of the admin
          .get();

      if (adminSnapshot.exists) {
        setState(() {
          username = adminSnapshot['username']; // Retrieve the 'username' field
        });
      }
    } catch (e) {
      print('Error fetching admin username: $e');
    }
  }

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

            // Schedules Title with the admin's username
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text(
                    'Schedules',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 199, 14),
                    ),
                  ),
                  const SizedBox(
                      height: 8), // Add some space between the two texts
                  Text(
                    username != null
                        ? 'Hello, $username'
                        : 'Hello, Admin', // Display the fetched username or a default value
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),

            // Morning Trip Widget
            TripCard(
              title: 'Morning Trips',
              timing: 'Start: 6:00 AM',
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
              timing: 'Start: 12:00 PM',
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
  final String timing;
  final IconData icon;
  final VoidCallback onArrowClick;

  const TripCard({
    required this.title,
    required this.timing,
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
                      const SizedBox(height: 5),
                      Text(
                        timing,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w100,
                          color: Colors.black54,
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
