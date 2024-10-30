import 'package:flutter/material.dart';
import 'package:raqeeb/screens/parent/p_contact.dart'; // Contact screen
import 'package:raqeeb/screens/parent/status.dart'; // Status screen
import 'package:raqeeb/screens/parent/parentHomepage.dart'; // Home screen
import 'package:raqeeb/screens/parent/parentProfile.dart'; // Profile screen

class MainLayoutParent extends StatefulWidget {
  final int initialIndex;

  const MainLayoutParent({Key? key, this.initialIndex = 2}) : super(key: key);

  @override
  MainLayoutState createState() => MainLayoutState();
}

class MainLayoutState extends State<MainLayoutParent> {
  late int _selectedIndex;

  static List<Widget> _pages = <Widget>[
    ContactScreen(), // Page 0 (Contact page)
    StatusScreen(), // Page 1 (Status page)
    ParentHomepage(), // Page 2 (Home page)
    ProfileScreen() // Page 3 (Profile page)
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // This ensures the body content stretches fully
          Container(
            color: const Color.fromRGBO(
                172, 230, 238, 100), // Light blue background color
            child: _pages[
                _selectedIndex], // Display the page based on selected index
          ),
          Positioned(
            bottom: 0, // Pin the navigation bar to the bottom
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: BottomNavigationBar(
                    backgroundColor: Colors.white,
                    items: const <BottomNavigationBarItem>[
                      BottomNavigationBarItem(
                        icon: Icon(Icons.contact_page), // Contact icon
                        label: 'Contact',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(
                            Icons.directions_bus), // Status icon (or bus icon)
                        label: 'Status',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.home), // Home icon
                        label: 'Home',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.account_circle), // Profile icon
                        label: 'Profile',
                      ),
                    ],
                    currentIndex: _selectedIndex,
                    selectedItemColor: Colors.orange,
                    unselectedItemColor: Colors.grey,
                    onTap: onItemTapped,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
