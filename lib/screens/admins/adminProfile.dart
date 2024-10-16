import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:raqeeb/services/auth_service.dart';
import 'package:raqeeb/screens/commons/changePassword.dart';

class AdminProfilePage extends StatefulWidget {
  const AdminProfilePage({super.key});

  @override
  _AdminProfilePageState createState() => _AdminProfilePageState();
}

class _AdminProfilePageState extends State<AdminProfilePage> {
  bool _isExpanded = false; // Control the expansion

  // Variables to store admin data
  String name = '';
  String phoneNumber = '';
  String email = '';
  // variables to store school data
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
      // Fetching the current admin from the 'Admins' subcollection
      DocumentSnapshot adminSnapshot = await FirebaseFirestore.instance
          .collection('Users') // Main Users collection
          .doc('2J4DFh6Gxi9vNAmip0iA') // Assuming the Admins document's ID
          .collection('Admins') // The Admins subcollection
          .doc(userId) // Replace with the actual document ID of the admin
          .get();

      // Fetch the school document using the schoolID reference from the admin document
      DocumentReference schoolRef =
          adminSnapshot['schoolID']; // schoolID is a DocumentReference
      DocumentSnapshot schoolSnapshot = await schoolRef.get();

      // Fetch the address document using the addressID reference from the school document
      DocumentReference addressRef =
          schoolSnapshot['addressID']; // addressID is a DocumentReference
      DocumentSnapshot addressSnapshot = await addressRef.get();

      if (adminSnapshot.exists &&
          schoolSnapshot.exists &&
          addressSnapshot.exists) {
        setState(() {
          name =
              adminSnapshot['fullName'] ?? 'N/A'; // Retrieve the 'name' field
          phoneNumber = adminSnapshot['phoneNumber'] ??
              'N/A'; // Retrieve the 'phoneNumber' field
          email = adminSnapshot['email']; // Retrieve the 'email' field
          schoolName = schoolSnapshot['schoolName'] ??
              'N/A'; // Retrieve the 'schoolName' field
          neighborhood = addressSnapshot['neighborhood'] ??
              'N/A'; // Retrieve the 'neighborhood' field
          city = addressSnapshot['city'] ?? 'N/A'; // Retrieve the 'city' field
          country = addressSnapshot['country'] ??
              'N/A'; // Retrieve the 'country' field
          // studentsNum = adminSnapshot['studentsNum'] ?? 'N/A'; // Retrieve the 'studentsNum' field
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
            // Profile Title
            const Text(
              'Profile',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 247, 164, 0),
              ),
            ),
            const SizedBox(height: 20),

            // Expandable Profile Card (Name and Image + Extra Details)
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: double.infinity,
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(
                      255, 252, 196, 113), // Yellow background color
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
                        // Profile Image
                        const CircleAvatar(
                          radius: 35, // Circular profile image
                          backgroundImage:
                              AssetImage('assets/images/admin1.png'),
                        ),
                        const SizedBox(
                            width: 15), // Space between image and info

                        // Expanded Column for Name and Phone
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
                                overflow:
                                    TextOverflow.ellipsis, // Prevents overflow
                              ),
                              Text(
                                phoneNumber,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.blue,
                                ),
                                overflow:
                                    TextOverflow.ellipsis, // Prevents overflow
                              ),
                            ],
                          ),
                        ),

                        // Arrow Button
                        IconButton(
                          icon: AnimatedRotation(
                            turns: _isExpanded
                                ? 0.25
                                : 0, // Rotate arrow when expanded
                            duration: const Duration(milliseconds: 300),
                            child: const Icon(Icons.arrow_forward_ios,
                                color: Colors.black54),
                          ),
                          onPressed: () {
                            setState(() {
                              _isExpanded = !_isExpanded; // Toggle expansion
                            });
                          },
                        ),
                      ],
                    ),
                    if (_isExpanded) ...[
                      const SizedBox(
                          height: 20), // Spacing before extra details
                      _buildExtraDetail('Email', email),
                      _buildExtraDetail('School Name', schoolName),
                      _buildExtraDetail('Neighborhood', neighborhood),
                      _buildExtraDetail('City', city),
                      _buildExtraDetail('Country', country),
                      // _buildExtraDetail('Students Num', '50 Student'),
                    ]
                  ],
                ),
              ),
            ),

            // Change Password Widget
            ProfileOptionCard(
              title: 'Change password',
              icon: Icons.lock_outline,
              onArrowClick: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChangePassword()),
                );
              },
            ),

            // Add/Delete Student Widget
            ProfileOptionCard(
              title: 'Add/Delete Student',
              icon: Icons.backpack,
              onArrowClick: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context) => const SomeOtherPage()));
              },
            ),

            // Add/Delete Driver Widget
            ProfileOptionCard(
              title: 'Add/Delete Driver',
              icon: Icons.directions_bus_filled,
              onArrowClick: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context) => const SomeOtherPage()));
              },
            ),

            // Logout Widget
            ProfileOptionCard(
              title: 'Logout',
              icon: Icons.logout,
              expandable: true,
              message: 'Are you sure you want to logout?',
              onArrowClick: () async {
                // Calling the sign-out method from your AuthService
                AuthService authService = AuthService();
                await authService.signOut();

                // Navigate to the login screen
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

// ProfileOptionCard Widget for other profile options
class ProfileOptionCard extends StatefulWidget {
  final String title;
  final IconData icon;
  final VoidCallback onArrowClick;
  final bool expandable;
  // final Widget? expandedContent;
  final String? message; // Optional message for the expanded state

  const ProfileOptionCard({
    required this.title,
    required this.icon,
    required this.onArrowClick,
    this.expandable = false,
    this.message,
    Key? key,
  }) : super(key: key);

  @override
  _ProfileOptionCardState createState() => _ProfileOptionCardState();
}

class _ProfileOptionCardState extends State<ProfileOptionCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Container(
        width: double.infinity,
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        widget.icon,
                        size: 40,
                        color: const Color.fromARGB(255, 201, 129, 36),
                      ),
                      const SizedBox(width: 15), // Space between icon and title
                      Text(
                        widget.title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: AnimatedRotation(
                      turns: _isExpanded ? 0.25 : 0,
                      duration: const Duration(milliseconds: 300),
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black54,
                      ),
                    ),
                    onPressed: () {
                      if (widget.expandable) {
                        setState(() {
                          _isExpanded = !_isExpanded;
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
            if (_isExpanded && widget.expandable) ...[
              const SizedBox(height: 10),
              if (widget.message != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    widget.message!,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: widget.onArrowClick,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                ),
                child: const Text(
                  'Confirm',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              const SizedBox(height: 10),
            ]
          ],
        ),
      ),
    );
  }
}
