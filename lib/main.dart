import 'package:flutter/material.dart';
import 'package:raqeeb/screens/commons/login.dart'; // Ensure this is the correct path

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
