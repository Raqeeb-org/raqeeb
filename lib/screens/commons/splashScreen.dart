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
    // Check auth state after a delay to simulate a splash screen effect
    Future.delayed(const Duration(seconds: 2), () {
      checkAuthentication();
    });
  }

  // Method to check Firebase authentication state
  void checkAuthentication() async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user == null) {
        // User is not logged in, navigate to login page
        Navigator.pushReplacementNamed(context, '/login');
      } else {
        // User is logged in, check role and navigate accordingly
        String userId = user.uid;
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('Users')
            .doc('2J4DFh6Gxi9vNAmip0iA')
            //.collection()
            //.doc(userId)
            .get();

        if (userDoc.exists) {
          String role = userDoc['role'];

          if (role == 'admin') {
            Navigator.pushReplacementNamed(context, '/admin_home');
          } else if (role == 'driver') {
            Navigator.pushReplacementNamed(context, '/driver_home');
          } else if (role == 'parent') {
            Navigator.pushReplacementNamed(context, '/parent_home');
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      ),
    );
  }
}
