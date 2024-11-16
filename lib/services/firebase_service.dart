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

  // Method to count the number of students assigned to a bus
  Future<int> getStudentCountForBus(String busId) async {
    final QuerySnapshot childrenSnapshot = await _firestore
        .collection('Children')
        .where('bus', isEqualTo: _firestore.collection('Buses').doc(busId))
        .get();
    return childrenSnapshot.docs.length;
  }

// Not used yet
  Future<DocumentSnapshot> getParentDocument(String parentId) async {
    return await FirebaseFirestore.instance
        .collection('Users')
        .doc(parentId)
        .get();
  }

  Future<DocumentSnapshot> getParentData(DocumentReference parentRef) async {
    return await parentRef.get();
  }

  // Method to update the child's check-in status (NOT USED YET)
  Future<void> updateChildCheckInStatus(
      String childId, bool isCheckedIn) async {
    await _firestore.collection('Children').doc(childId).update({
      'isCheckedIn': isCheckedIn,
    });
  }
}
