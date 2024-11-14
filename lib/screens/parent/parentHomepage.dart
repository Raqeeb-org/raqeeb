import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth

void main() {
  runApp(MaterialApp(
    home: ParentHomepage(),
  ));
}

class ParentHomepage extends StatefulWidget {
  @override
  _ParentHomepageState createState() => _ParentHomepageState();
}

class _ParentHomepageState extends State<ParentHomepage> {
  List<bool> _isExpanded = [false, false];
  String _userName = '';

  @override
  void initState() {
    super.initState();
    _getUserName(); // Call to get the user's name
  }

  // Method to get the user's name from the email
  void _getUserName() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null && user.email != null) {
      setState(() {
        _userName = user.email!.split('@')[0]; // Extract name part of the email
      });
    }
  }

  void _launchCaller(String number) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: number);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      throw 'Could not launch $number';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Image.asset(
                'assets/images/header.png',
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200,
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello, $_userName',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'MY CHILDREN',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                  SizedBox(height: 16),
                  _buildChildCard('Abdullah', 'GAGJT236H', '0555555555',
                      'assets/images/abdullah.png', 0),
                  _buildChildCard('Azeez', 'GAGJT236H', '0555555555',
                      'assets/images/Azeez-2.png', 1),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChildCard(String name, String id, String driverNumber,
      String imagePath, int index) {
    return Card(
      color: Colors.amber,
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(imagePath),
            ),
            title: Text(name),
            subtitle: Text('ID No. $id'),
            trailing: Icon(
                _isExpanded[index] ? Icons.expand_less : Icons.expand_more),
            onTap: () {
              setState(() {
                _isExpanded[index] = !_isExpanded[index];
              });
            },
          ),
          if (_isExpanded[index])
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Morning trip: Start (6:15 AM)',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Afternoon trip: Start (2:05 PM)',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  GestureDetector(
                    onTap: () => _launchCaller(driverNumber),
                    child: Row(
                      children: [
                        Icon(Icons.phone,
                            color: const Color.fromARGB(255, 0, 0, 0)),
                        SizedBox(width: 8),
                        Text(
                          'Driver: $driverNumber',
                          style: TextStyle(
                            fontSize: 16,
                            color: const Color.fromARGB(255, 0, 0, 0),
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
