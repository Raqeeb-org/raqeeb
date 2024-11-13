import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:raqeeb/services/auth_service.dart';
import 'package:raqeeb/widgets/change_password_card.dart'; // Import ChangePasswordCard
import 'package:raqeeb/widgets/logoutCard.dart';

class DriverProfilePage extends StatefulWidget {
  const DriverProfilePage({super.key});

  @override
  _DriverProfilePageState createState() => _DriverProfilePageState();
}

class _DriverProfilePageState extends State<DriverProfilePage> {
  bool _isExpanded = false;

  // Variables to store admin data
  String name = '';
  String phoneNumber = '';
  String email = '';
  String schoolName = '';
  String neighborhood = '';
  String city = '';
  String country = '';
  String studentsNum = '';

  @override
  void initState() {
    super.initState();
    fetchAdminData(); // Fetch the admin data when the widget is initialized
  }

  // Method to fetch the admin's data from Firestore
  Future<void> fetchAdminData() async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot adminSnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc('2J4DFh6Gxi9vNAmip0iA')
          .collection('Drivers')
          .doc(userId)
          .get();

      DocumentReference schoolRef = adminSnapshot['schoolID'];
      DocumentSnapshot schoolSnapshot = await schoolRef.get();

      DocumentReference addressRef = schoolSnapshot['addressID'];
      DocumentSnapshot addressSnapshot = await addressRef.get();

      if (adminSnapshot.exists &&
          schoolSnapshot.exists &&
          addressSnapshot.exists) {
        setState(() {
          name = adminSnapshot['fullName'] ?? 'N/A';
          phoneNumber = adminSnapshot['phoneNumber'] ?? 'N/A';
          email = adminSnapshot['email'];
          schoolName = schoolSnapshot['schoolName'] ?? 'N/A';
          neighborhood = addressSnapshot['neighborhood'] ?? 'N/A';
          city = addressSnapshot['city'] ?? 'N/A';
          country = addressSnapshot['country'] ?? 'N/A';
          studentsNum = adminSnapshot['studentsNum'] ?? 'N/A';
        });
      }
    } catch (e) {
      print('Error fetching admin data: $e');
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
            const SizedBox(height: 20),
            const Text(
              'Profile',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 247, 164, 0),
              ),
            ),
            const SizedBox(height: 20),

            // Expandable Profile Card
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: double.infinity,
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 252, 196, 113),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 35,
                          backgroundImage:
                              AssetImage('assets/images/Dinah.png'),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                name,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                phoneNumber,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.blue,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: AnimatedRotation(
                            turns: _isExpanded ? 0.25 : 0,
                            duration: const Duration(milliseconds: 300),
                            child: const Icon(Icons.arrow_forward_ios,
                                color: Colors.black54),
                          ),
                          onPressed: () {
                            setState(() {
                              _isExpanded = !_isExpanded;
                            });
                          },
                        ),
                      ],
                    ),
                    if (_isExpanded) ...[
                      const SizedBox(height: 20),
                      _buildExtraDetail('Email', email),
                      _buildExtraDetail('School Name', schoolName),
                      _buildExtraDetail('Neighborhood', neighborhood),
                      _buildExtraDetail('City', city),
                      _buildExtraDetail('Country', country),
                    ]
                  ],
                ),
              ),
            ),

            // Replace with ChangePasswordCard
            const ChangePasswordCard(), // Use the ChangePasswordCard widget directly

            // Logout Widget
            ProfileOptionCard(
              title: 'Logout',
              icon: Icons.logout,
              expandable: true,
              message: 'Are you sure you want to logout?',
              onArrowClick: () async {
                AuthService authService = AuthService();
                await authService.signOut();
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
    );
  }

  // Helper widget to build extra details for the profile card
  Widget _buildExtraDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$label:',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
