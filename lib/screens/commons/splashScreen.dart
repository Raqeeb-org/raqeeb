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
      print('User: $user');
      if (user == null) {
        // User is not logged in, navigate to login page
        Navigator.pushReplacementNamed(context, '/login');
      } else {
        // User is logged in, fetch the user's role from Firestore
        String userId = user.uid;

        // Firestore document containing subcollections
        DocumentReference userDoc = FirebaseFirestore.instance
            .collection('Users')
            .doc('2J4DFh6Gxi9vNAmip0iA');

        // Check if user exists in Drivers subcollection
        DocumentSnapshot driverSnapshot =
            await userDoc.collection('Drivers').doc(userId).get();
        if (driverSnapshot.exists) {
          // User is a driver, navigate to driver's home page
          Navigator.pushReplacementNamed(context, '/driver_home');
          return;
        }

        // Check if user exists in Parents subcollection
        DocumentSnapshot parentSnapshot =
            await userDoc.collection('Parents').doc(userId).get();
        if (parentSnapshot.exists) {
          // User is a parent, navigate to parent's home page
          Navigator.pushReplacementNamed(context, '/parent_home');
          return;
        }

        // Check if user exists in Admins subcollection
        DocumentSnapshot adminSnapshot =
            await userDoc.collection('Admins').doc(userId).get();
        if (adminSnapshot.exists) {
          // User is an admin, navigate to admin's home page
          Navigator.pushReplacementNamed(context, '/admin_home');
          return;
        }

        // If the user is not found in any of the subcollections, you can sign them out
        FirebaseAuth.instance.signOut();
        Navigator.pushReplacementNamed(context, '/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[100],
      body: const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      ),
    );
  }
}
