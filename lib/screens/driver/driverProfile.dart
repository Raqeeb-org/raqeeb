import 'package:flutter/material.dart';

class DriverProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'Profile',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Profile Info Section
              Card(
                color: Colors.orange[200],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundImage: AssetImage('assets/images/Dinah.jpg'),
                    radius: 30,
                  ),
                  title: const Text(
                    'Dinah Hani ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  subtitle: const Text(
                    '+966 592366747',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // Handle profile tap
                  },
                ),
              ),
              const SizedBox(height: 20),

              // Change Password Section
              Card(
                color: Colors.orange[200],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ListTile(
                  leading: const Icon(
                    Icons.lock,
                    color: Colors.black,
                    size: 40,
                  ),
                  title: const Text(
                    'Change password',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // Handle change password tap
                  },
                ),
              ),
              const SizedBox(height: 20),

              // Logout Section
              Card(
                color: Colors.orange[200],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ListTile(
                  leading: const Icon(
                    Icons.logout,
                    color: Colors.black,
                    size: 40,
                  ),
                  title: const Text(
                    'Logout',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // Handle logout tap
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
