import 'package:flutter/material.dart';
import 'package:raqeeb/screens/commons/location_service.dart';
import 'package:raqeeb/screens/driver/DriverMapScreen.dart';
import 'package:raqeeb/screens/commons/face_recognition_service.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class FaceRecognitionService {
  final String esp32Url;
  final String flaskUrl;

  FaceRecognitionService({required this.esp32Url, required this.flaskUrl});

  Future<String?> checkFaceRecognition() async {
    try {
      // Step 1: Capture image from ESP32-CAM
      final esp32Response = await http.get(Uri.parse("$esp32Url/capture"));
      if (esp32Response.statusCode != 200) {
        throw Exception("Failed to capture image from ESP32-CAM");
      }

      // Step 2: Send the captured image to Flask server
      var request = http.MultipartRequest('POST', Uri.parse("$flaskUrl/recognize"));
      request.files.add(http.MultipartFile.fromBytes('image', esp32Response.bodyBytes, filename: 'image.jpg'));

      var response = await request.send();
      var responseData = await response.stream.bytesToString();
      var result = json.decode(responseData);

      // Step 3: Handle the recognition result
      if (result['status'] == 'success' && result['recognized']) {
        return result['person']; // Recognized person's name
      } else {
        return null; // No face recognized
      }
    } catch (e) {
      print("Error in face recognition process: $e");
      return null;
    }
  }
}

class MorningTripScreen extends StatefulWidget {
  @override
  _MorningTripScreenState createState() => _MorningTripScreenState();
}

class _MorningTripScreenState extends State<MorningTripScreen> {
  final FaceRecognitionService _faceRecognitionService = FaceRecognitionService(
    esp32Url: "http://192.168.100.143",  // ESP32-CAM IP
    flaskUrl: "http://127.0.0.1:5000",  // Flask server URL
  );

  Map<String, bool> isStudentOnBoard = {
    "Khaled": false,
    "Deena": true,
    "Basma_Alhajji": false,
    "Azeez": false,
    "Abdullah": true,
  };

  Future<void> startRecognition() async {
    final recognizedPerson = await _faceRecognitionService.checkFaceRecognition();

    if (recognizedPerson != null && isStudentOnBoard.containsKey(recognizedPerson)) {
      setState(() {
        isStudentOnBoard[recognizedPerson] = true;  // Update on-board status
      });
    }
  }

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
                ...isStudentOnBoard.keys.map((name) => studentCard(
                  name: name,
                  id: "GAG17236H",
                  eta: "6:00", // Set appropriate ETA
                  avatar: "assets/images/$name.png",  // Use a filename pattern that matches your assets
                  isOnBoard: isStudentOnBoard[name] ?? false,
                )).toList(),
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
                      onPressed: startRecognition,  // Start the face recognition process
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
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
                        backgroundColor: Colors.red,
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
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
