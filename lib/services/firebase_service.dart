// firebase_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Method to get the current admin's ID
  String? getCurrentAdminId() {
    return _auth.currentUser?.uid;
  }

  // Stream to retrieve buses based on the admin ID
  Stream<QuerySnapshot> getBusesForAdmin(String adminId) {
    return _firestore
        .collection('Buses')
        .where('adminID', isEqualTo: adminId)
        .snapshots();
  }

  // Method to retrieve driver data based on driver reference
  Future<DocumentSnapshot> getDriverData(DocumentReference driverRef) {
    return driverRef.get();
  }

  // Stream to retrieve children assigned to a specific bus
  Stream<QuerySnapshot> getChildrenForBus(String busId) {
    return _firestore
        .collection('Children')
        .where('bus', isEqualTo: _firestore.collection('Buses').doc(busId))
        .snapshots();
  }
}
