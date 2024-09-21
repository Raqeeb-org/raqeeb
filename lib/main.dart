import 'package:flutter/material.dart';
import 'package:raqeeb/screens/commons/login.dart';
//import 'package:raqeeb/screens/commons/reset_password.dart';
//import 'package:raqeeb/screens/commons/verification.dart';

void main() {
  runApp(RaqeebApp());
}

class RaqeebApp extends StatelessWidget {
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
}
