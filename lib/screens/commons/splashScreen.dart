import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      checkAuthentication();
    });
  }

  // Method to check Firebase authentication state
  void checkAuthentication() async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user == null) {
        Navigator.pushReplacementNamed(context, '/login');
      } else {
        String userId = user.uid;

        DocumentReference userDoc = FirebaseFirestore.instance
            .collection('Users')
            .doc('2J4DFh6Gxi9vNAmip0iA');

        DocumentSnapshot driverSnapshot =
            await userDoc.collection('Drivers').doc(userId).get();
        if (driverSnapshot.exists) {
          Navigator.pushReplacementNamed(context, '/driver_home');
          return;
        }

        DocumentSnapshot parentSnapshot =
            await userDoc.collection('Parents').doc(userId).get();
        if (parentSnapshot.exists) {
          Navigator.pushReplacementNamed(context, '/parent_home');
          return;
        }

        DocumentSnapshot adminSnapshot =
            await userDoc.collection('Admins').doc(userId).get();
        if (adminSnapshot.exists) {
          Navigator.pushReplacementNamed(context, '/admin_home');
          return;
        }

        FirebaseAuth.instance.signOut();
        Navigator.pushReplacementNamed(context, '/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[100],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Add the image above the loading spinner
          Center(
            child: Image.asset(
              'assets/images/Raqeeb-r.png',
              width: 300, // Adjust width as needed
              height: 200, // Adjust height as needed
            ),
          ),
          const SizedBox(height: 40), // Space between image and loader
          const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ],
      ),
    );
  }
}
