// school_buses_screen.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:raqeeb/widgets/busCard.dart';
import 'package:raqeeb/screens/admins/morningBusChildren.dart';
import 'package:raqeeb/services/firebase_service.dart';

class SchoolBusesScreen extends StatelessWidget {
  final FirebaseService firebaseService = FirebaseService();

  SchoolBusesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String? adminId = firebaseService.getCurrentAdminId();

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
      body: StreamBuilder<QuerySnapshot>(
        stream: firebaseService.getBusesForAdmin(adminId),
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
              final String busID = buses[index].id;
              final DocumentReference driverRef = bus['driverID'];

              return FutureBuilder<DocumentSnapshot>(
                future: firebaseService.getDriverData(driverRef),
                builder: (context, driverSnapshot) {
                  if (driverSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (driverSnapshot.hasError) {
                    return Center(
                        child: Text("Error: ${driverSnapshot.error}"));
                  }

                  if (!driverSnapshot.hasData || !driverSnapshot.data!.exists) {
                    return const Center(child: Text("No driver found."));
                  }

                  final driverData =
                      driverSnapshot.data!.data() as Map<String, dynamic>;
                  final String driverName =
                      driverData['fullName'] ?? 'Unknown Driver';

                  // Another futureBuilder to get the number of students
                  return FutureBuilder<int>(
                    future: firebaseService.getStudentCountForBus(busID),
                    builder: (context, studentCountSnapshot) {
                      if (studentCountSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (studentCountSnapshot.hasError) {
                        return Center(
                            child:
                                Text("Error: ${studentCountSnapshot.error}"));
                      }

                      final int numberOfStudents =
                          studentCountSnapshot.data ?? 0;

                      return BusCard(
                        busNumber: bus['busNum'] ?? 'Unknown',
                        driverName: driverName,
                        numberOfStudents: numberOfStudents,
                        destinationPage: MorningBusChildren(busId: busID),
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
