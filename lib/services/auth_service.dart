import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// lib/services/auth_service.dart
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Method to sign in with email and password
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Handle successful login
      String? userId = userCredential
          .user?.uid; // If userCredential.user is null, userId will be null.
      print("User ID: $userId");

      if (userId != null) {
        // You can retrieve user data after successful login
        String role = await getUserRole(
            userId); // Example: getting the role from Firestore
        DocumentSnapshot userData = await getUserData(role, userId);
        print("User Data: ${userData.data()}");
      }
    } on FirebaseAuthException catch (e) {
      // Handle sign-in errors
      print(e.message);
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
    return await _firestore
        .collection('users')
        .doc(userID)
        .collection(role) // role: 'parents', 'drivers', or 'school_admins'
        .doc(userID)
        .get();
  }

  // Optionally: Method to retrieve user role (if stored in Firestore)
  Future<String> getUserRole(String userID) async {
    DocumentSnapshot snapshot =
        await _firestore.collection('users').doc(userID).get();
    return snapshot[
        'role']; // Make sure to store the role in Firestore for each user
  }
}
