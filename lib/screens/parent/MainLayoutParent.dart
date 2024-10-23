import 'package:flutter/material.dart';
import 'package:raqeeb/screens/parent/p_contact.dart'; // Contact screen
import 'package:raqeeb/screens/parent/status.dart';  // Status screen
import 'package:raqeeb/screens/parent/p_home.dart';    // Home screen
import 'package:raqeeb/screens/parent/p_profile.dart'; // Profile screen

class MainLayout extends StatefulWidget {
  final int initialIndex;

  const MainLayout({Key? key, this.initialIndex = 1}) : super(key: key);

  @override
  MainLayoutState createState() => MainLayoutState();
}

class MainLayoutState extends State<MainLayout> {
  late int _selectedIndex;

  static List<Widget> _pages = <Widget>[
    ContactScreen(),   // Page 0 (Contact page)
    StatusScreen(),    // Page 1 (Status page)
    HomeScreen(),      // Page 2 (Home page)
    ProfileScreen()    // Page 3 (Profile page)
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
      body: _pages[_selectedIndex], // Display the page based on selected index
      bottomNavigationBar: Padding(
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
                  icon: Icon(Icons.directions_bus), // Status icon (or bus icon)
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
    );
  }
}
