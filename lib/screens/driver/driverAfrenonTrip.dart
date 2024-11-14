import 'package:flutter/material.dart';
import 'package:raqeeb/screens/commons/location_service.dart';
import 'package:raqeeb/screens/driver/DriverMapScreen.dart'; 
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher for phone functionality

class AfternoonTripScreen extends StatelessWidget {
  final LocationService _locationService = LocationService(); // Initialize LocationService
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[100],
      appBar: AppBar(
        title: Text("Afternoon Trip"),
        backgroundColor: Colors.lightBlue[200],
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(8.0),
              children: [
                studentCard(
                  name: "Khaled",
                  id: "GAG17236H",
                  eta: "2:00 PM",
                  avatar: "assets/images/Khaled-2.png",
                  isOnBoard: false,
                  phoneNumber: "0598765432",
                ),
                studentCard(
                  name: "Deena",
                  id: "GAG17236H",
                  eta: "2:30 PM",
                  avatar: "assets/images/Deena.png",
                  isOnBoard: true,
                  phoneNumber: "0598765433",
                ),
                studentCard(
                  name: "Haneen",
                  id: "GAG17236H",
                  eta: "2:45 PM",
                  avatar: "assets/images/Haneen-2.png",
                  isOnBoard: true,
                  phoneNumber: "0598765434",
                ),
                studentCard(
                  name: "Azeez",
                  id: "GAG17236H",
                  eta: "3:15 PM",
                  avatar: "assets/images/Azeez-2.png",
                  isOnBoard: false,
                  phoneNumber: "0598765435",
                ),
                studentCard(
                  name: "Abdullah",
                  id: "GAG17236H",
                  eta: "3:34 PM",
                  avatar: "assets/images/Abdullah.png",
                  isOnBoard: true,
                  isCompleted: true, // Indicates the trip is done
                  phoneNumber: "0598765436",
                ),
              ],
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
                          {"name": "Basma ", "latitude": 24.774265, "longitude": 46.738586},
                          {"name": "Deena", "latitude": 24.774965, "longitude": 46.739586},
                          {"name": "Haneen", "latitude": 24.77494, "longitude": 46.739597},
                          {"name": "Azeez", "latitude": 24.778965, "longitude": 46.739586},
                          {"name": "Abdullah", "latitude": 24.664965, "longitude": 46.723586},
                          // Add more students as needed
                        ];
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DriverMapScreen(studentLocations: studentLocations),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      ),
                      child: Text(
                        "Start Trip",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        showReportDialog(
                            context); // Call the report dialog here
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      ),
                      child: Text(
                        "Report",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget studentCard({
    required String name,
    required String id,
    required String eta,
    required String avatar,
    required bool isOnBoard,
    required String phoneNumber,
    bool isCompleted = false,
  }) {
    return Card(
      color: isCompleted ? Colors.grey[400] : Colors.orange[300],
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        leading: CircleAvatar(
          radius: 20,
          backgroundImage: AssetImage(avatar),
        ),
        title: Text(
          name,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("ID No. $id"),
            Text("ETA: $eta", style: TextStyle(color: Colors.blue)),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.call, color: Colors.black),
              onPressed: () {
                _callFamily(phoneNumber);
              },
            ),
            Icon(
              isOnBoard ? Icons.check_circle : Icons.radio_button_unchecked,
              color: isOnBoard ? Colors.green : Colors.black,
            ),
          ],
        ),
      ),
    );
  }

  void _callFamily(String phoneNumber) async {
    final Uri phoneUri = Uri(
      scheme: 'tel',
      path: phoneNumber, // Using the provided phone number
    );
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri); // Launch the phone dialer
    } else {
      throw 'Could not launch $phoneUri'; // Handle error if the phone launch fails
    }
  }

  // Method to show the report dialog with school number and call functionality
  void showReportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("School Contact"),
          content: Text("School number: 0599945789"),
          actions: <Widget>[
            TextButton(
              child: Text("Call School"),
              onPressed: () async {
                final Uri phoneUri = Uri(
                    scheme: 'tel',
                    path: '0599945789'); // Create the URI for the phone number
                if (await canLaunchUrl(phoneUri)) {
                  await launchUrl(phoneUri); // Launch the phone dialer
                } else {
                  throw 'Could not launch $phoneUri'; // Handle error if launch fails
                }
              },
            ),
            TextButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: AfternoonTripScreen(),
  ));
}
