import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// lib/services/auth_service.dart
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Method to sign in with email and password, and verify role
  Future<bool> signInAndVerifyRole(
      String email, String password, String selectedRole) async {
    try {
      // Sign in the user using Firebase Auth
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Handle successful login
      String? userId = userCredential
          .user?.uid; // If userCredential.user is null, userId will be null.
      print("User ID: $userId"); // will delete later
      if (userId != null) {
        // if the user exists, check if the user exists in the correct subcollection based on their role
        DocumentSnapshot userDoc = await getUserData(selectedRole, userId);
        print("User Data: ${userDoc.data()}"); // will delete later
        if (userDoc.exists) {
          // If the user exists in the correct subcollection, return true
          return true;
        } else {
          // If the user does not exist in the correct subcollection, sign out and return false
          await signOut();
          return false;
        }
      }
      return false;
    } on FirebaseAuthException catch (e) {
      // Handle sign-in errors
      print("Sign in failed: ${e.message}");
      return false;
    }
  }

  // Method to sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Method to observe auth state changes
  Stream<User?> get userStream {
    return _auth.authStateChanges();
  }

  // Method to get user data based on role and userID
  Future<DocumentSnapshot> getUserData(String role, String userID) async {
    // Access the Firestore subcollection for the selected role
    return await _firestore
        .collection('Users')
        .doc('2J4DFh6Gxi9vNAmip0iA')
        .collection(role) // role: 'parents', 'drivers', or 'school_admins'
        .doc(userID)
        .get();
  }
}
