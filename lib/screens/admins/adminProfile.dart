import 'package:flutter/material.dart';
import 'package:raqeeb/screens/commons/changePassword.dart';

class AdminProfilePage extends StatefulWidget {
  const AdminProfilePage({super.key});

  @override
  _AdminProfilePageState createState() => _AdminProfilePageState();
}

class _AdminProfilePageState extends State<AdminProfilePage> {
  bool _isExpanded = false; // Control the expansion

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            // Profile Title
            const Text(
              'Profile',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 247, 164, 0),
              ),
            ),
            const SizedBox(height: 20),

            // Expandable Profile Card (Name and Image + Extra Details)
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: double.infinity,
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(
                      255, 252, 196, 113), // Yellow background color
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
                    Row(
                      children: [
                        // Profile Image
                        const CircleAvatar(
                          radius: 35, // Circular profile image
                          backgroundImage:
                              AssetImage('assets/images/admin1.png'),
                        ),
                        const SizedBox(
                            width: 15), // Space between image and info

                        // Expanded Column for Name and Phone
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Muhammad Al-Sheekh',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                overflow:
                                    TextOverflow.ellipsis, // Prevents overflow
                              ),
                              Text(
                                '+966 567 343 77 81',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.blue,
                                ),
                                overflow:
                                    TextOverflow.ellipsis, // Prevents overflow
                              ),
                            ],
                          ),
                        ),

                        // Arrow Button
                        IconButton(
                          icon: AnimatedRotation(
                            turns: _isExpanded
                                ? 0.25
                                : 0, // Rotate arrow when expanded
                            duration: const Duration(milliseconds: 300),
                            child: const Icon(Icons.arrow_forward_ios,
                                color: Colors.black54),
                          ),
                          onPressed: () {
                            setState(() {
                              _isExpanded = !_isExpanded; // Toggle expansion
                            });
                          },
                        ),
                      ],
                    ),
                    if (_isExpanded) ...[
                      const SizedBox(
                          height: 20), // Spacing before extra details
                      _buildExtraDetail('Email', 'admin@example.com'),
                      _buildExtraDetail('School Name', 'Future Vision School'),
                      _buildExtraDetail('Neighborhood', 'Riyadh North'),
                      _buildExtraDetail('City', 'Riyadh'),
                      _buildExtraDetail('Country', 'Saudi Arabia'),
                      _buildExtraDetail('Students Num', '50 Student'),
                    ]
                  ],
                ),
              ),
            ),

            // Change Password Widget
            ProfileOptionCard(
              title: 'Change password',
              icon: Icons.lock_outline,
              onArrowClick: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChangePassword()),
                );
              },
            ),

            // Add/Delete Student Widget
            ProfileOptionCard(
              title: 'Add/Delete Student',
              icon: Icons.backpack,
              onArrowClick: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context) => const SomeOtherPage()));
              },
            ),

            // Add/Delete Driver Widget
            ProfileOptionCard(
              title: 'Add/Delete Driver',
              icon: Icons.directions_bus_filled,
              onArrowClick: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context) => const SomeOtherPage()));
              },
            ),

            // Logout Widget
            ProfileOptionCard(
              title: 'Logout',
              icon: Icons.logout,
              onArrowClick: () {
                // Implement logout functionality here
              },
            ),
          ],
        ),
      ),
    );
  }

  // Helper widget to build extra details for the profile card
  Widget _buildExtraDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$label:',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}

// ProfileOptionCard Widget for other profile options
class ProfileOptionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onArrowClick;

  const ProfileOptionCard({
    required this.title,
    required this.icon,
    required this.onArrowClick,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Container(
        width: double.infinity,
        height: 80, // Fixed height for each option card
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Leading Icon and Title
              Row(
                children: [
                  Icon(
                    icon,
                    size: 40,
                    color: const Color.fromARGB(255, 201, 129, 36),
                  ),
                  const SizedBox(width: 15), // Space between icon and title
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              // Arrow Button
              IconButton(
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black54,
                ),
                onPressed: onArrowClick,
              ),
            ],
          ),
        ),
      ),
    );
  }
}