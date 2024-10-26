import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher for phone functionality

class MorningTripScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[100],
      appBar: AppBar(
        title: Text("Morning Trip"),
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
                  eta: "6:00",
                  avatar: "assets/images/Khaled-2.png",
                  isOnBoard: false,
                  phoneNumber: "0598765432", // Khaled's phone number
                ),
                studentCard(
                  name: "Deena",
                  id: "GAG17236H",
                  eta: "6:30",
                  avatar: "assets/images/Deena.png",
                  isOnBoard: true,
                  phoneNumber: "0598765433", // Deena's phone number
                ),
                studentCard(
                  name: "Haneen",
                  id: "GAG17236H",
                  eta: "6:45",
                  avatar: "assets/images/Haneen-2.png",
                  isOnBoard: true,
                  phoneNumber: "0598765434", // Haneen's phone number
                ),
                studentCard(
                  name: "Azeez",
                  id: "GAG17236H",
                  eta: "7:15",
                  avatar: "assets/images/Azeez-2.png",
                  isOnBoard: false,
                  phoneNumber: "0598765435", // Azeez's phone number
                ),
                studentCard(
                  name: "Abdullah",
                  id: "GAG17236H",
                  eta: "7:34",
                  avatar: "assets/images/Abdullah.png",
                  isOnBoard: true,
                  isCompleted: true, // Indicates the trip is done
                  phoneNumber: "0598765436", // Abdullah's phone number
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
                      onPressed: () {
                        // Handle Start Trip action
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
                SizedBox(height: 50), // Adds space after buttons for bar
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
    required String phoneNumber, // Add phone number as a required parameter
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
          backgroundImage: AssetImage(avatar), // Load the image from assets
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
                _callFamily(phoneNumber); // Call the predefined number
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

  // Function to make the phone call using url_launcher
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
    home: MorningTripScreen(),
  ));
}
