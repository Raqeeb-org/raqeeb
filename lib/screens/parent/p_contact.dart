import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


void main() {
  runApp(MaterialApp(
    home: ContactPage(),
  ));
}

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final Color customColor = const Color(0xFFFCC471); // Define the custom color

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Contact',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: customColor, // Use custom color here
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            const Text(
              'If you need help please contact these numbers',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 20),
            ContactCard(
              role: 'School Administrator',
              name: 'Muhammed Alsheekh',
              phone: '+966547778823',
              imageUrl: 'assets/images/admin1.png', // Admin-specific image
              backgroundColor: customColor,
              onTap: () => makePhoneCall('+966547778823'),
            ),
            const SizedBox(height: 20),
            ContactCard(
              role: 'School Driver',
              name: 'Ahmad Ali',
              phone: '+96678893213',
              imageUrl: 'assets/images/driver1.png', // Driver-specific image
              backgroundColor: customColor,
              onTap: () => makePhoneCall('+96678893213'),
            ),
            const Spacer(),
            Image.asset(
              'assets/helpdesk.png', // Add this image to your assets folder
              height: 150,
            ),
          ],
        ),
      ),
    );
  }
}

class ContactCard extends StatelessWidget {
  final String role;
  final String name;
  final String phone;
  final String imageUrl; // Use this parameter for the image
  final Color backgroundColor;
  final VoidCallback onTap;

  const ContactCard({
    required this.role,
    required this.name,
    required this.phone,
    required this.imageUrl, // Accept dynamic image URL
    required this.backgroundColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(imageUrl), // Use dynamic imageUrl
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  role,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                Text(
                  name,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0), fontSize: 14),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    phone,
                    style: TextStyle(
                      color: const Color.fromARGB(255, 8, 130, 230),
                      fontSize: 14,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.phone,
                color: const Color.fromARGB(255, 8, 130, 230)),
            onPressed: onTap,
          ),
        ],
      ),
    );
  }
}

// Utility function for making phone calls (placed in phone_utils.dart)
void makePhoneCall(String phoneNumber) async {
  final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
  if (await canLaunchUrl(phoneUri)) {
    await launchUrl(phoneUri);
  } else {
    throw 'Could not launch $phoneNumber';
  }
}
