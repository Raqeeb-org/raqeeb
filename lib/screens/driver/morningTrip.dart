import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:raqeeb/widgets/childCard.dart';
import 'package:raqeeb/services/firebase_service.dart';
import 'package:raqeeb/screens/driver/DriverMapScreen.dart';
import 'package:url_launcher/url_launcher.dart';

class MorningTripScreen extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseService _firebaseService = FirebaseService();
  final String driverId; // Driver's ID

  MorningTripScreen({Key? key, required this.driverId}) : super(key: key);

  Future<String?> _getBusIdForDriver() async {
    try {
      // Construct the correct driver reference
      DocumentReference driverRef = _firestore
          .collection('Users')
          .doc('2J4DFh6Gxi9vNAmip0iA')
          .collection('Drivers')
          .doc(driverId);

      // Query the bus document based on the driver's reference
      QuerySnapshot snapshot = await _firestore
          .collection('Buses')
          .where('driverID', isEqualTo: driverRef)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final busDoc = snapshot.docs.first;
        print('Bus document data: ${busDoc.data()}'); // Debugging
        return busDoc.id; // Return the bus ID
      } else {
        print('No bus document found for driverID: $driverId');
      }
      return null;
    } catch (e) {
      print('Error retrieving bus: $e');
      return null;
    }
  }

  Future<String?> _getParentPhoneNumber(DocumentReference parentRef) async {
    try {
      DocumentSnapshot parentDoc = await parentRef.get();
      if (parentDoc.exists) {
        return parentDoc[
            'phoneNumber']; // Assuming 'phoneNumber' exists in the parent document
      }
      return null;
    } catch (e) {
      print('Error fetching parent phone number: $e');
      return null;
    }
  }

  void showReportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("School Contact"),
          content: const Text("School number: 0599945789"),
          actions: <Widget>[
            TextButton(
              child: const Text("Call School"),
              onPressed: () async {
                final Uri phoneUri = Uri(scheme: 'tel', path: '0599945789');
                if (await canLaunchUrl(phoneUri)) {
                  await launchUrl(phoneUri); // Launch the phone dialer
                } else {
                  throw 'Could not launch $phoneUri'; // Handle error if launch fails
                }
              },
            ),
            TextButton(
              child: const Text("Close"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[100],
      appBar: AppBar(
        title: const Text("Morning Trip"),
        backgroundColor: Colors.lightBlue[200],
        elevation: 0,
      ),
      body: FutureBuilder<String?>(
        future: _getBusIdForDriver(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('No bus found for this driver.'));
          }

          final String busId = snapshot.data!;
          return Column(
            children: [
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: _firebaseService.getChildrenForBus(busId),
                  builder: (context, childrenSnapshot) {
                    if (childrenSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (childrenSnapshot.hasError) {
                      return Center(
                          child: Text('Error: ${childrenSnapshot.error}'));
                    }
                    if (!childrenSnapshot.hasData ||
                        childrenSnapshot.data!.docs.isEmpty) {
                      return const Center(
                          child: Text('No children found for this bus.'));
                    }

                    final childrenDocs = childrenSnapshot.data!.docs;
                    return ListView.builder(
                      itemCount: childrenDocs.length,
                      itemBuilder: (context, index) {
                        final child = childrenDocs[index];
                        final parentRef =
                            child['parentID']; // Parent reference field

                        return FutureBuilder<String?>(
                          future: _getParentPhoneNumber(parentRef),
                          builder: (context, parentSnapshot) {
                            if (parentSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            if (parentSnapshot.hasError) {
                              return const Text(
                                'Error loading parent phone number',
                                style: TextStyle(color: Colors.red),
                              );
                            }

                            final parentPhoneNumber =
                                parentSnapshot.data ?? 'No Phone Number';

                            return ChildCard(
                              name:
                                  '${child['firstName']} ${child['lastName']}',
                              id: child['idNum'],
                              imageUrl: child['gender'] == "Female"
                                  ? "assets/images/femaleChild.png"
                                  : "assets/images/maleChild.png",
                              isCheckedIn: child['isCheckedIn'] ?? false,
                              parentPhoneNumber: parentPhoneNumber,
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            List<Map<String, dynamic>> studentLocations = [
                              {
                                "name": "Khaled",
                                "latitude": 24.774265,
                                "longitude": 46.738586
                              },
                              {
                                "name": "Deena",
                                "latitude": 24.774965,
                                "longitude": 46.739586
                              },
                              // Add more students as needed
                            ];
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DriverMapScreen(
                                    studentLocations: studentLocations),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 15),
                          ),
                          child: const Text(
                            "Start Trip",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            showReportDialog(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 15),
                          ),
                          child: const Text(
                            "Report",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                        height: 50), // Adds space after buttons for bar
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
