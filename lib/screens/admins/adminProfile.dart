import 'package:flutter/material.dart';
import 'package:raqeeb/widgets/mainLayout.dart'; // Import the custom navigation bar

class AdminProfilePage extends StatelessWidget {
  const AdminProfilePage({Key? key}) : super(key: key);

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

            // Profile Card (Name and Image)
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Container(
                width: double.infinity,
                height: 100, // Fixed height for the profile card
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
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      // Profile Image
                      const CircleAvatar(
                        radius: 35, // Circular profile image
                        backgroundImage: AssetImage('assets/images/admin1.png'),
                      ),
                      const SizedBox(width: 15), // Space between image and info

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
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black,
                          size: 30,
                        ),
                        onPressed: () {
                          // Navigate to another page if necessary
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Change Password Widget
            ProfileOptionCard(
              title: 'Change password',
              icon: Icons.lock_outline,
              onArrowClick: () {
                /*Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MorningTripsPage()),
                );*/
              },
            ),

            // Add/Delete Student Widget
            ProfileOptionCard(
              title: 'Add/Delete Student',
              icon: Icons.backpack,
              onArrowClick: () {
                /*Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MorningTripsPage()),
                );*/
              },
            ),

            // Add/Delete Driver Widget
            ProfileOptionCard(
              title: 'Add/Delete Driver',
              icon: Icons.directions_bus_filled,
              onArrowClick: () {
                /*Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MorningTripsPage()),
                );*/
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
}

// ProfileOptionCard Widget for all options except the profile card
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
