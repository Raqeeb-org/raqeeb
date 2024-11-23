import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileOptionCard extends StatefulWidget {
  final String title;
  final IconData icon;
  final String userType;
  final Widget Function(BuildContext) screenBuilder;
  final Future<void> Function(String userId, BuildContext context)
      deleteLogic; // Custom deletion logic

  const ProfileOptionCard({
    required this.title,
    required this.icon,
    required this.userType,
    required this.screenBuilder,
    required this.deleteLogic,
    Key? key,
  }) : super(key: key);

  @override
  _ProfileOptionCardState createState() => _ProfileOptionCardState();
}

class _ProfileOptionCardState extends State<ProfileOptionCard> {
  bool _isExpanded = false; // To manage the expanded state
  String? _selectedUser; // To store the selected user ID
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final String collectionPath = (widget.userType == 'Drivers')
        ? 'Users/2J4DFh6Gxi9vNAmip0iA/Drivers'
        : 'Children';

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
                      duration: const Duration(milliseconds: 400),
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
                    title: Text(
                      "Add ${widget.userType}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    leading: const Icon(Icons.add, color: Colors.green),
                    onTap: () {
                      // Navigate to Add Driver Screen
                      Navigator.push(context,
                          MaterialPageRoute(builder: widget.screenBuilder));
                    },
                  ),
                  ListTile(
                    title: Text(
                      "Delete ${widget.userType}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    leading: const Icon(Icons.delete, color: Colors.red),
                    onTap: () {
                      setState(() {
                        _selectedUser = null;
                      });
                    },
                  ),
                  if (_selectedUser == null)
                    StreamBuilder<QuerySnapshot>(
                      stream: _firestore.collection(collectionPath).snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        }
                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return Text("No ${widget.userType}s to delete.");
                        }

                        final users = snapshot.data!.docs;

                        return DropdownButton<String>(
                          hint: Text("Select a ${widget.userType} to delete"),
                          value: _selectedUser,
                          onChanged: (String? value) {
                            setState(() {
                              _selectedUser = value;
                            });
                          },
                          items: users.map((user) {
                            final userData =
                                user.data() as Map<String, dynamic>;
                            return DropdownMenuItem<String>(
                              value: user.id,
                              child: Text(((widget.userType == 'Drivers')
                                      ? userData['fullName']
                                      : '${userData['firstName']} ${userData['lastName']}') ??
                                  'Unknown'),
                            );
                          }).toList(),
                        );
                      },
                    ),
                  if (_selectedUser != null)
                    ElevatedButton(
                      onPressed: () async {
                        await widget.deleteLogic(_selectedUser!, context);
                        setState(() {
                          _selectedUser = null;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red, // Background color
                      ),
                      child: Text("Delete ${widget.userType}"),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
