import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:raqeeb/services/auth_service.dart';
import 'package:raqeeb/widgets/change_password_card.dart';
import 'package:raqeeb/widgets/logoutCard.dart';

class DriverProfilePage extends StatefulWidget {
  const DriverProfilePage({super.key});

  @override
  _DriverProfilePageState createState() => _DriverProfilePageState();
}

class _DriverProfilePageState extends State<DriverProfilePage> {
  bool _isExpanded = false;
  bool _isLoading = true; // Add a loading state
  String fullName = '';
  String phoneNum = '';
  String email = '';
  String adminID = '';
  String tripStatus = '';
  String idNo = '';

  @override
  void initState() {
    super.initState();
    fetchDriverData();
  }

  Future<void> fetchDriverData() async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot driverSnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc('2J4DFh6Gxi9vNAmip0iA')
          .collection('Drivers')
          .doc(userId)
          .get();

      if (driverSnapshot.exists) {
        setState(() {
          fullName = driverSnapshot['fullName'] ?? 'N/A';
          phoneNum = driverSnapshot['phoneNum'] ?? 'N/A';
          email = driverSnapshot['email'] ?? 'N/A';
          // school = driverSnapshot['school'] ?? 'N/A';
          tripStatus = driverSnapshot['tripStatus'] ?? 'N/A';
          idNo = driverSnapshot['idNo'] ?? 'N/A';
          _isLoading = false; // Set loading to false after fetching data
        });
      }
    } catch (e) {
      print('Error fetching driver data: $e');
      setState(() {
        _isLoading = false; // Stop loading if there is an error
      });
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
            const SizedBox(height: 50),
            const Text(
              'Profile',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 247, 164, 0),
              ),
            ),
            const SizedBox(height: 20),

            // Show loading indicator or profile card
            _isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
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
                                backgroundColor: Colors.purple,
                                child: Icon(
                                  Icons.person,
                                  size: 40,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      fullName,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      phoneNum,
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
                            //  _buildExtraDetail('Admin ID', adminID),
                            //  _buildExtraDetail('Trip Status', tripStatus),
                            _buildExtraDetail('ID Number', idNo),
                          ]
                        ],
                      ),
                    ),
                  ),

            const ChangePasswordCard(),
            LogoutCard(
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
