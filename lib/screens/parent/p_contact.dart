import 'package:flutter/material.dart';
import 'package:raqeeb/utils/phone_utils.dart';

void main() {
  runApp(ContactPage());
}

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final Color customColor = Color(0xFFFCC471); // Define the custom color

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
                imageUrl:
                    'https://via.placeholder.com/100', // Replace with actual image URL
                backgroundColor: customColor, // Set card color
                onTap: () => makePhoneCall('+966547778823'),
              ),
              const SizedBox(height: 20),
              ContactCard(
                role: 'School Driver',
                name: 'Ahmad Ali',
                phone: '+96678893213',
                imageUrl:
                    'https://via.placeholder.com/100', // Replace with actual image URL
                backgroundColor: customColor, // Set card color
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
      ),
    );
  }
}

class ContactCard extends StatelessWidget {
  final String role;
  final String name;
  final String phone;
  final String imageUrl;
  final Color backgroundColor;
  final VoidCallback onTap;

  const ContactCard({
    required this.role,
    required this.name,
    required this.phone,
    required this.imageUrl,
    required this.backgroundColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: backgroundColor, // Apply custom color
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(imageUrl),
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
                      color: Colors.blue[200],
                      fontSize: 14,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.phone, color: Colors.blue[200]),
            onPressed: onTap,
          ),
        ],
      ),
    );
  }
}
