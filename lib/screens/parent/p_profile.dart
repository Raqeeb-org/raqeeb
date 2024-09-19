import 'package:flutter/material.dart';
//import './bottom_navigation_bar.dart';

class  ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0, // Transparent app bar
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.orange,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            // Profile Card
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              color: const Color(0xFFFFE08D),
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.orange, // Use a placeholder avatar color
                  radius: 30,
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                title: const Text(
                  'Muna Khalaf',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                subtitle: const Text(
                  '+966 567 343 77 81',
                  style: TextStyle(color: Colors.blue),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                ),
                onTap: () {
                  // Add navigation or action here
                },
              ),
            ),
            const SizedBox(height: 20),

            // Change Password Card
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              color: const Color(0xFFFFE08D),
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.orange,
                  radius: 30,
                  child: Icon(
                    Icons.lock,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                title: const Text(
                  'Change password',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                ),
                onTap: () {
                  // Add navigation or action here
                },
              ),
            ),
            const SizedBox(height: 20),

            // Logout Card
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              color: const Color(0xFFFFE08D),
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.orange,
                  radius: 30,
                  child: Icon(
                    Icons.logout,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                title: const Text(
                  'Logout',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                ),
                onTap: () {
                  // Add logout logic here
                },
              ),
            ),
          ],
        ),
      ),
      //bottomNavigationBar: CustomBottomNavigationBar(currentIndex: 2),
    );
  }
}
