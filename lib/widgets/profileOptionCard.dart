import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:raqeeb/services/firebase_functions_service.dart';
import 'package:raqeeb/screens/admins/addDriver.dart';

class ProfileOptionCard extends StatefulWidget {
  final String title;
  final IconData icon;

  const ProfileOptionCard({
    required this.title,
    required this.icon,
    Key? key,
  }) : super(key: key);

  @override
  _ProfileOptionCardState createState() => _ProfileOptionCardState();
}

class _ProfileOptionCardState extends State<ProfileOptionCard> {
  bool _isExpanded = false; // To manage the expanded state
  String? _selectedDriver; // To store the selected driver ID
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseFunctionsService firebaseFunctionsService =
      FirebaseFunctionsService();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 252, 196, 113),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            // Main Header Row
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        widget.icon,
                        size: 40,
                        color: const Color.fromARGB(255, 201, 129, 36),
                      ),
                      const SizedBox(width: 15), // Space between icon and title
                      Text(
                        widget.title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: AnimatedRotation(
                      turns: _isExpanded ? 0.25 : 0,
                      duration: const Duration(milliseconds: 300),
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black54,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        _isExpanded = !_isExpanded;
                      });
                    },
                  ),
                ],
              ),
            ),

            // Expanded Content
            if (_isExpanded)
              Column(
                children: [
                  ListTile(
                    title: const Text(
                      "Add Driver",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    leading: const Icon(Icons.add, color: Colors.green),
                    onTap: () {
                      // Navigate to Add Driver Screen
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const AddDriverScreen();
                      }));
                    },
                  ),
                  ListTile(
                    title: const Text(
                      "Delete Driver",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    leading: const Icon(Icons.delete, color: Colors.red),
                    onTap: () {
                      setState(() {
                        _selectedDriver = null;
                      });
                    },
                  ),
                  if (_selectedDriver == null)
                    StreamBuilder<QuerySnapshot>(
                      stream: _firestore
                          .collection('Users/2J4DFh6Gxi9vNAmip0iA/Drivers')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        }
                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return const Text("No drivers available to delete.");
                        }

                        final drivers = snapshot.data!.docs;

                        return DropdownButton<String>(
                          hint: const Text("Select a driver to delete"),
                          value: _selectedDriver,
                          onChanged: (String? value) {
                            setState(() {
                              _selectedDriver = value;
                            });
                          },
                          items: drivers.map((driver) {
                            final driverData =
                                driver.data() as Map<String, dynamic>;
                            return DropdownMenuItem<String>(
                              value: driver.id,
                              child: Text(driverData['fullName'] ?? 'Unknown'),
                            );
                          }).toList(),
                        );
                      },
                    ),
                  if (_selectedDriver != null)
                    ElevatedButton(
                      onPressed: () {
                        _deleteDriver(_selectedDriver!);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red, // Background color
                      ),
                      child: const Text("Delete Driver"),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _deleteDriver(String driverId) async {
    try {
      // Fetch the driver document to get the email
      DocumentSnapshot driverDoc = await _firestore
          .doc('Users/2J4DFh6Gxi9vNAmip0iA/Drivers/$driverId')
          .get();

      if (!driverDoc.exists) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Driver not found')),
        );
        return;
      }

      // Extract email from driver document
      // Extract email from the driver document
      Map<String, dynamic> driverData =
          driverDoc.data() as Map<String, dynamic>;
      String email = driverData['email'];

      // Call the Cloud Function to delete the driver account
      await firebaseFunctionsService.deleteDriverAccountByEmail(email);

      // Delete the driver document from Firestore
      await _firestore
          .doc('Users/2J4DFh6Gxi9vNAmip0iA/Drivers/$driverId')
          .delete();

      setState(() {
        _selectedDriver = null;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Driver deleted successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete driver: $e')),
      );
    }
  }
}
