import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // To use kIsWeb
import 'dart:io' show Platform; // To check for mobile platforms (iOS/Android)
import 'package:raqeeb/widgets/mainLayout.dart';
import 'package:raqeeb/screens/commons/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase for web
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyAbZ2Jap00L4fdOXBOAEYuHSOp1MpNCxyo",
        authDomain: "raqeeb-c6520.firebaseapp.com",
        projectId: "raqeeb-c6520",
        storageBucket: "raqeeb-c6520.appspot.com",
        messagingSenderId: "479747832887",
        appId: "1:479747832887:web:e59b52cd50e7648c4fd3b2",
      ),
    );
  } else {
    await Firebase.initializeApp();

    // Check if platform is not iOS/Android before setting persistence
    if (!kIsWeb && (Platform.isIOS || Platform.isAndroid)) {
      // setPersistence() is not supported on mobile platforms
      print("Persistence not required for iOS or Android");
    } else {
      // Set authentication persistence for web
      await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);
    }
  }

  runApp(const RaqeebApp());
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
      // Adding the routes for navigation
      routes: {
        '/admin_home': (context) =>
            const MainLayout(), // Driver's home page route
        '/login': (context) => LoginPage(), // Login page route
      },
    );
  }
}
