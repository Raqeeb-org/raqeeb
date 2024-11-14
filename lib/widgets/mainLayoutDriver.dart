import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth
import 'package:raqeeb/screens/driver/driverHomePage.dart';
import 'package:raqeeb/screens/driver/driverProfile.dart';

class MainLayoutDriver extends StatefulWidget {
  final int initialIndex;

  const MainLayoutDriver({Key? key, this.initialIndex = 1}) : super(key: key);
  @override
  MainLayoutState createState() => MainLayoutState();
}

class MainLayoutState extends State<MainLayoutDriver> {
  late int _selectedIndex;
  String _userName = '';

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;

    // Get the user's email and extract the name part
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null && user.email != null) {
      _userName = user.email!.split('@')[0];
    }
  }

  // List of pages with username passed to DriverHomePage
  List<Widget> get _pages => <Widget>[
        DriverHomePage(userName: _userName), // Page 0
        DriverHomePage(userName: _userName), // Page 1
        DriverProfilePage(), // Page 2
      ];

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
                  icon: Icon(Icons.directions_bus),
                  label: 'Track',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle),
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
