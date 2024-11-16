import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Correct import

class ContactScreen extends StatelessWidget {
  // Helper method to launch a phone call
  void _makePhoneCall(String phoneNumber) async {
    final Uri callUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(callUri)) {
      await launchUrl(callUri);
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0, // Transparent app bar
        title: const Text(
          'Contact',
          style: TextStyle(color: Colors.orange, fontSize: 30, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 10),
            const Text(
              'Need help? please contact these numbers',
              style: TextStyle(fontSize: 16, color: Colors.black54),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // School Administrator Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: const Color(0xFFFFE08D),
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundImage: AssetImage('assets/images/admin1.png'), // Placeholder for admin photo
                    radius: 30,
                  ),
                  title: const Text(
                    'School Administrator',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text('Muhammad Alsheekh'),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          const Text(
                            '+966 567 343 77 81',
                            style: TextStyle(color: Colors.blue),
                          ),
                          const Spacer(),
                          IconButton(
                            icon: const Icon(Icons.phone, color: Colors.blue),
                            onPressed: () => _makePhoneCall('+9665673437781'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // School Driver Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: const Color(0xFFFFE08D),
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundImage: AssetImage('assets/images/driver.png'), // Placeholder for driver photo
                    radius: 30,
                  ),
                  title: const Text(
                    'School Driver',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          const Text('Ahmad Ali'),
                          const Spacer(),
                          Text(
                            'ID No. Dr123SA456',
                            style: TextStyle(color: Colors.grey[600], fontSize: 12),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: <Widget>[
                          const Text(
                            '+966 5123 456 12 78',
                            style: TextStyle(color: Colors.blue),
                          ),
                          const Spacer(),
                          IconButton(
                            icon: const Icon(Icons.phone, color: Colors.blue),
                            onPressed: () => _makePhoneCall('+96651234561278'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                       Text(
                        'Plate No. SA 1 S44',
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Illustration image at the bottom
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.asset(
                'assets/images/call_center.png', // Replace with your illustration
                height: 200,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
