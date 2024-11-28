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

  // Function to retrieve the list of parents based on the admin ID
  Stream<List<Map<String, dynamic>>> getParentsByAdmin(String adminId) async* {
    final adminRef = _firestore
        .collection('Users')
        .doc('2J4DFh6Gxi9vNAmip0iA')
        .collection('Admins')
        .doc(adminId);

    final query = _firestore
        .collection('Children')
        .where('schoolAdmin', isEqualTo: adminRef);

    await for (final childrenSnapshot in query.snapshots()) {
      final parentRefs = childrenSnapshot.docs.map((doc) {
        return doc.data()['parentID'] as DocumentReference;
      }).toSet();

      final parentSnapshots = await Future.wait(
        parentRefs.map((ref) => ref.get()),
      );

      final parents = parentSnapshots.map((snap) {
        final data = snap.data() as Map<String, dynamic>;
        return {
          'docId': snap.id,
          'fullName': data['fullName'] ?? 'Unnamed Parent',
          'email': data['email'],
          'phoneNumber': data['phoneNumber'],
        };
      }).toList();

      yield parents;
    }
  }

  // Create parent in Firestore and Firebase Authentication
  Future<String> addParentAndCreateAuth({
    required String email,
    required String password,
    required String fullName,
    required String phoneNumber,
    required String adminId,
  }) async {
    try {
      // Create user in Firebase Auth
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String parentId = userCredential.user!.uid;

      // Add parent to Firestore
      await _firestore
          .collection('Users')
          .doc(adminId)
          .collection('Parents')
          .doc(parentId)
          .set({
        'email': email,
        'fullName': fullName,
        'phoneNumber': phoneNumber,
        'role': 'Parent',
      });

      return parentId; // Return parentId to use as reference in child document
    } catch (e) {
      throw Exception('Failed to add parent: $e');
    }
  }

  // Add child to Firestore
  Future<void> addChild({
    required String firstName,
    required String lastName,
    required String midName,
    required String idNum,
    required String gender,
    required String grade,
    required String homePostalCode,
    required String houseLocation,
    required String currentLocation,
    required String busId,
    required String parentId,
    required String adminId,
    required String status,
  }) async {
    try {
      await _firestore.collection('Children').add({
        'firstName': firstName,
        'lastName': lastName,
        'midName': midName,
        'idNum': idNum,
        'gender': gender,
        'grade': grade,
        'homePostalCode': homePostalCode,
        'houseLocation': houseLocation,
        'location': currentLocation,
        'bus': _firestore.doc('/Buses/$busId'),
        'parentID': _firestore.doc('/Users/$adminId/Parents/$parentId'),
        'schoolAdmin': _firestore.doc('/Users/$adminId/Admins/$adminId'),
        'status': status,
      });
    } catch (e) {
      throw Exception('Failed to add child: $e');
    }
  }
}
