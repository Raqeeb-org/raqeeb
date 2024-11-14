import 'package:flutter/material.dart';
import 'package:raqeeb/screens/driver/driverHomepage.dart';
import 'package:raqeeb/screens/driver/driverProfile.dart';

class MainLayoutDriver extends StatefulWidget {
  final int initialIndex;

  const MainLayoutDriver({Key? key, this.initialIndex = 1})
      : super(key: key); // Default to 'Home'
  @override
  MainLayoutState createState() => MainLayoutState();
}

class MainLayoutState extends State<MainLayoutDriver> {
  late int _selectedIndex;

  static List<Widget> _pages = <Widget>[
    driverHomePage(), // Page 0
    driverHomePage(), // Page 1 (can be any other homepage if different)
    DriverProfilePage(), // Page 2
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex =
        widget.initialIndex; // Set initial index based on passed value
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
            borderRadius: BorderRadius.circular(30), // Fully rounded corners
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 10,
                offset: const Offset(0, 3), // Changes position of shadow
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
