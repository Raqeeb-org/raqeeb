import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:raqeeb/widgets/childCard.dart';

class MorningBusChildren extends StatelessWidget {
  final String busId;

  const MorningBusChildren({Key? key, required this.busId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 189, 236, 242),
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Assigned Children',
              style: TextStyle(
                fontFamily: 'Poppins', //change font later
                fontSize: 25,
                color: Color.fromARGB(255, 247, 164, 0),
                fontWeight: FontWeight.bold,
              )),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Children')
                .where('bus',
                    isEqualTo: FirebaseFirestore.instance
                        .collection('Buses')
                        .doc(busId))
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}"));
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(
                    child: Text("No children assigned to this bus."));
              }

              final children = snapshot.data!.docs;
              print("Retrieved children count: ${children.length}");

              return ListView.builder(
                itemCount: children.length,
                itemBuilder: (context, index) {
                  final child = children[index].data();

                  return ChildCard(
                    name: child['firstName'] + " " + child['lastName'] ??
                        'Unknown Child',
                    id: child['idNum'] ?? 'N/A',
                    imageUrl: child['imageUrl'] ?? 'assets/images/default.jpg',
                    isCheckedIn: child['isCheckedIn'] ?? true,
                    isCallEnabled: child['isCallEnabled'] ?? true,
                  );
                },
              );
            }));
  }
}
