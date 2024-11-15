import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:raqeeb/widgets/childCard.dart';
import 'package:raqeeb/services/firebase_service.dart';

class MorningBusChildren extends StatelessWidget {
  final String busId;
  final FirebaseService firebaseService = FirebaseService();

  MorningBusChildren({Key? key, required this.busId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("Debug: Fetching children for busId: $busId"); // Debugging output

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 189, 236, 242),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Assigned Children',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 25,
              color: Color.fromARGB(255, 247, 164, 0),
              fontWeight: FontWeight.bold,
            )),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firebaseService.getChildrenForBus(busId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            print("Debug: Error fetching children - ${snapshot.error}");
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            print("Debug: No children found for busId: $busId");
            return const Center(
                child: Text("No children assigned to this bus."));
          }

          final children = snapshot.data!.docs;
          print("Debug: Found ${children.length} children for busId: $busId");

          return ListView.builder(
            itemCount: children.length,
            itemBuilder: (context, index) {
              final child = children[index].data() as Map<String, dynamic>;
              final String gender = child['gender'] ?? 'Unknown';
              print("Debug: Child data, Gender: $gender, Bus: ${child['bus']}");

              return ChildCard(
                name:
                    (child['firstName'] + " " + child['lastName']) ?? 'Unknown',
                id: child['idNum'] ?? 'N/A',
                // chech the child gender and set the image accordingly
                imageUrl: child['gender'] == "Female"
                    ? "assets/images/femaleChild.png"
                    : "assets/images/maleChild.png",
                isCheckedIn: child['isCheckedIn'] ?? false,
                isCallEnabled: true,
              );
            },
          );
        },
      ),
    );
  }
}
