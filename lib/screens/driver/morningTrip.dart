import 'package:flutter/material.dart';

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
                ),
                studentCard(
                  name: "Deena",
                  id: "GAG17236H",
                  eta: "6:30",
                  avatar: "assets/images/Deena.png",
                  isOnBoard: true,
                ),
                studentCard(
                  name: "Haneen",
                  id: "GAG17236H",
                  eta: "6:45",
                  avatar: "assets/images/Haneen-2.png",
                  isOnBoard: true,
                ),
                studentCard(
                  name: "Azeez",
                  id: "GAG17236H",
                  eta: "7:15",
                  avatar: "assets/images/Azeez-2.png",
                  isOnBoard: false,
                ),
                studentCard(
                  name: "Abdullah",
                  id: "GAG17236H",
                  eta: "7:34",
                  avatar: "assets/images/Abdullah.png",
                  isOnBoard: true,
                  isCompleted: true, // Indicates the trip is done
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
                        backgroundColor: Colors
                            .green, // Updated from `primary` to `backgroundColor`
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
                        // Handle Report action
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors
                            .red, // Updated from `primary` to `backgroundColor`
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
          // Future widget can be added here after the SizedBox space
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
                // Call button action
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
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MorningTripScreen(),
  ));
}
