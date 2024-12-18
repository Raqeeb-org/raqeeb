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

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  try {
    if (kIsWeb) {
      // Web platform Firebase initialization
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
      // Mobile platform Firebase initialization
      await Firebase.initializeApp();
    }
  } catch (e) {
    debugPrint("Firebase initialization error: $e");
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
      home: SplashScreen(), // Set the SplashScreen as the home page
      debugShowCheckedModeBanner: false,
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
        // Forgot password page route
        '/forgot_password': (context) => ForgotPasswordPage(),
      },
    );
  }
}
