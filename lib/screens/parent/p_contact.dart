import 'package:flutter/material.dart';

class ContactScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0, // Transparent app bar
        title: const Text(
          'Contact',
          style: TextStyle(color: Colors.orange, fontSize: 26, fontWeight: FontWeight.bold),
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
                child: const ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/admin_photo.png'), // Placeholder for admin photo
                    radius: 30,
                  ),
                  title: Text(
                    'School Administrator',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Muhammad Alsheekh'),
                      SizedBox(height: 5),
                      Text(
                        '+966 567 343 77 81',
                        style: TextStyle(color: Colors.blue),
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
                  leading:const CircleAvatar(
                    backgroundImage: AssetImage('assets/images/driver_photo.png'), // Placeholder for driver photo
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
                          Spacer(),
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
                          Text(
                            'Bus No. 123',
                            style: TextStyle(color: Colors.grey[600], fontSize: 12),
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
                'assets/images/call_center.png', // Replace with your illustration image
                height: 200,
              ),
            ),
          ],
        ),
      ),
     // bottomNavigationBar: CustomBottomNavigationBar(currentIndex: 0), // Bottom navigation bar
    );
  }
}
