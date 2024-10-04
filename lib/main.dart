import 'package:flutter/material.dart';
import 'package:raqeeb/screens/commons/login.dart';
//import 'package:raqeeb/screens/commons/reset_password.dart';
//import 'package:raqeeb/screens/commons/verification.dart';
//firebase
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';


// ...

/*void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(RaqeebApp());  // Change this to match your class name
}



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
}

class RaqeebApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Connected!'),
      ),
      body: Center(
        child: Text('Firebase is working!'),
      ),
    );
  }
}*/




void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp( // Ensure that MaterialApp is here
      title: 'Firebase Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),  // Your home widget, ensure this is wrapped inside MaterialApp
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold( // Scaffold should be wrapped inside MaterialApp
      appBar: AppBar(
        title: Text('Firebase Connected!'),
      ),
      body: Center(
        child: Text('Firebase is working!'),
      ),
    );
  }
}
