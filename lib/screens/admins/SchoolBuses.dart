import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:raqeeb/widgets/busCard.dart';
import 'package:raqeeb/screens/admins/morningBusChildren.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SchoolBusesScreen extends StatelessWidget {
  const SchoolBusesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the current admin's ID
    final String? adminId = FirebaseAuth.instance.currentUser
        ?.uid; // Replace with the actual admin ID retrieval logic

    // Check if the user is logged in
    if (adminId == null) {
      return const Scaffold(
        body: Center(child: Text("No user is logged in")),
      );
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 189, 236, 242),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Morning Trip Buses',
          style: TextStyle(
            color: Color.fromARGB(255, 247, 164, 0),
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Buses')
            .where('adminID', isEqualTo: adminId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No buses found for this admin."));
          }

          final buses = snapshot.data!.docs;

          return ListView.builder(
            itemCount: buses.length,
            itemBuilder: (context, index) {
              final bus = buses[index].data() as Map<String, dynamic>;
              return BusCard(
                busNumber: bus['busNum'] ??
                    'Unknown', // Assumes busNumber field exists
                driverName: bus['driverName'] ??
                    'No driver', // Assumes driverName field exists
                numberOfStudents: bus['numberOfStudents'] ??
                    0, // Assumes numberOfStudents field exists
                destinationPage: const MorningBusChildren(),
              );
            },
          );
        },
      ),
    );
  }
}
