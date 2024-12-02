import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ParentHomepage extends StatefulWidget {
  @override
  _ParentHomepageState createState() => _ParentHomepageState();
}

class _ParentHomepageState extends State<ParentHomepage> {
  List<bool> _isExpanded = []; // For expanded states
  String _userName = '';
  List<Map<String, dynamic>> _children = []; // To store children data

  @override
  void initState() {
    super.initState();
    _getUserName(); // Fetch the user's name
    _fetchChildrenData(); // Fetch children from Firestore
  }

  // Method to get the user's name from the email
  void _getUserName() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null && user.email != null) {
      setState(() {
        _userName = user.email!.split('@')[0]; // Extract name from email
      });
    }
  }

  // Fetch children data from Firestore
  Future<void> _fetchChildrenData() async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) return;

      // Construct the parent's DocumentReference
      DocumentReference parentRef = FirebaseFirestore.instance
          .collection('Users')
          .doc('2J4DFh6Gxi9vNAmip0iA')
          .collection('Parents')
          .doc(currentUser.uid);

      // Fetch children where parentID matches the parent's reference
      QuerySnapshot childrenSnapshot = await FirebaseFirestore.instance
          .collection('Children') // Collection containing child documents
          .where('parentID', isEqualTo: parentRef) // Match by DocumentReference
          .get();

      // Map the results into a list of children data
      List<Map<String, dynamic>> children = childrenSnapshot.docs.map((doc) {
        return doc.data() as Map<String, dynamic>;
      }).toList();

      // Update the state with fetched children data
      setState(() {
        _children = children;
        _isExpanded =
            List.filled(_children.length, false); // Match expanded states
      });
    } catch (e) {
      print('Error fetching children data: $e');
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
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Center(
            child: Stack(
              children: [
                Image.asset(
                  'assets/images/Schoole.png',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200,
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello, $_userName',
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Text(
                      'MY CHILDREN',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _children.length,
                      itemBuilder: (context, index) {
                        final child = _children[index];
                        final imagePath = child['gender'] == 'Female'
                            ? 'assets/images/femaleChild.png'
                            : 'assets/images/maleChild.png';
                        return _buildChildCard(
                          child['firstName'],
                          child['idNum'].toString(),
                          '0580239855', // Example driver number
                          imagePath, // Dynamically assign image
                          index,
                        );
                      },
                    ),
                  ),
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
                  const Text(
                    'Morning trip: Start (6:15 AM)',
                    style: TextStyle(fontSize: 16),
                  ),
                  const Text(
                    'Afternoon trip: Start (2:05 PM)',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () => _launchCaller(driverNumber),
                    child: Row(
                      children: [
                        const Icon(Icons.phone,
                            color: Color.fromARGB(255, 0, 0, 0)),
                        const SizedBox(width: 8),
                        Text(
                          'Driver: $driverNumber',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 0, 0, 0),
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
