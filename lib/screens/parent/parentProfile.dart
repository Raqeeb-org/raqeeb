import 'package:flutter/material.dart';
import 'package:raqeeb/widgets/logoutCard.dart';
import 'package:raqeeb/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isExpanded = false; // Control the expansion for the profile card

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 60),
            // Profile Title
            const Text(
              'Profile',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
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
                  color: const Color(0xFFFFE08D),
                  borderRadius: BorderRadius.circular(20),
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
                          backgroundColor: Colors.orange,
                          child: Icon(
                            Icons.person,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                            width: 15), // Space between image and info

                        // Expanded Column for Name and Phone
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Muna Khalaf',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                overflow:
                                    TextOverflow.ellipsis, // Prevents overflow
                              ),
                              Text(
                                '+966 567 343 77 81',
                                style: TextStyle(
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
                      _buildExtraDetail('Email', 'muna@example.com'),
                      _buildExtraDetail('Location', 'Riyadh, Saudi Arabia'),
                    ]
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Change Password Card
            ProfileOptionCard(
              title: 'Change Password',
              icon: Icons.lock_outline,
              onArrowClick: () {},
            ),
            const SizedBox(height: 20),

            // Logout Card

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