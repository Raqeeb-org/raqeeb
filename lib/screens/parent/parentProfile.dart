import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:raqeeb/screens/commons/login.dart';
import 'package:raqeeb/widgets/change_password_card.dart';
import 'package:raqeeb/widgets/logoutCard.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isExpanded = false;
  Map<String, dynamic>? parentData;

  @override
  void initState() {
    super.initState();
    _fetchParentInfo();
  }

  Future<void> _fetchParentInfo() async {
    try {
      String? userId = FirebaseAuth.instance.currentUser?.uid;

      if (userId == null) {
        print("No user is signed in.");
        return;
      }

      print("Fetching data for User UID: $userId");

      // Fetch parent data
      final parentSnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc('2J4DFh6Gxi9vNAmip0iA')
          .collection('Parents')
          .doc(userId) // This must match the authenticated user's UID
          .get();

      if (parentSnapshot.exists) {
        setState(() {
          parentData = parentSnapshot.data() as Map<String, dynamic>?;
          print("Fetched Parent Data: $parentData");
        });
      } else {
        print("No Parent document found for UID: $userId");
      }
    } catch (e) {
      print("Error fetching parent data: $e");
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
            const SizedBox(height: 60),
            const Text(
              'Profile',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: double.infinity,
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFCC80),
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
                child: parentData == null
                    ? const Center(
                        child: CircularProgressIndicator(), // Show loading indicator
                      )
                    : parentData!.isEmpty
                        ? const Text("No data available or loading failed.")
                        : Column(
                            children: [
                              Row(
                                children: [
                                  const CircleAvatar(
                                    backgroundImage: AssetImage(
                                        'assets/images/profile_icon.png'),
                                    radius: 30,
                                  ),
                                  const SizedBox(width: 15),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          parentData!['fullName'] ?? 'N/A',
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          parentData!['phoneNumber'] ?? 'N/A',
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
                                _buildExtraDetail('Email', parentData!['email'] ?? 'N/A'),
                              ]
                            ],
                          ),

              ),
            ),
            const SizedBox(height: 20),
            const ChangePasswordCard(),
            const SizedBox(height: 20),
            LogoutCard(
              title: 'Logout',
              icon: Icons.logout,
              onArrowClick: () async {
                try {
                  print("Signing out...");
                  await FirebaseAuth.instance.signOut();
                  print("Sign out successful");
                  Navigator.of(context, rootNavigator: true).pushReplacement(
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                } catch (e) {
                  print("Error during sign out: $e");
                }
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
