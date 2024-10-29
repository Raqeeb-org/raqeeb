import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:raqeeb/widgets/mainLayoutAdmin.dart';
import 'package:raqeeb/widgets/mainLayoutDriver.dart';
import 'package:raqeeb/widgets/mainLayoutParent.dart';
import 'package:raqeeb/screens/commons/splashScreen.dart';
import 'package:raqeeb/screens/commons/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:raqeeb/screens/commons/forgotPassword.dart';

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
    // Set authentication persistence (local for mobile)
    await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);
  }
  runApp(const RaqeebApp());
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
      home: SplashScreen(), // Set the LoginPage as the home page
      // Adding the routes for navigation
      routes: {
        // Admin's home page route
        '/admin_home': (context) => const MainLayout(),
        // Driver's home page route
        '/driver_home': (context) => const MainLayoutDriver(),
        // Parent's home page route
        '/parent_home': (context) => const MainLayoutParent(),
        // Login page route
        '/login': (context) => LoginPage(),
      },
    );
  }
}
