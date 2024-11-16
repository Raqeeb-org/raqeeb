import 'package:flutter/material.dart';
import 'package:raqeeb/screens/commons/login.dart';
//import 'package:raqeeb/screens/commons/reset_password.dart';
//import 'package:raqeeb/screens/commons/verification.dart';
import 'package:firebase_core/firebase_core.dart';

/*void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(RaqeebApp());
}

/*
void main() {
  runApp(RaqeebApp());
}*/

class RaqeebApp extends StatelessWidget {
  const RaqeebApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bus Tracking App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(), // Set the LoginPage as the home page
    );
  }
}*/
import 'package:raqeeb/screens/parent/p_home.dart';    // Home screen
import 'package:flutter/material.dart';
import 'package:raqeeb/screens/parent/MainLayoutParent.dart'; // Import the MainLayout
import 'package:raqeeb/screens/driver/morningTrip.dart';
import 'package:raqeeb/screens/parent/status.dart'; // Import the MainLayout
import 'package:raqeeb/screens/driver/driverAfrenonTrip.dart';
import 'package:raqeeb/screens/admins/adminHomepage.dart';
import 'package:raqeeb/screens/admins/trackBuses.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Hides the debug banner
      title: 'Raqeeb App',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainLayout(), // Set the MainLayout as the initial page
    );
  }
}


