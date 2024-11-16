import 'package:flutter/material.dart';
import 'package:raqeeb/utils/phone_utils.dart';

class BusCard extends StatelessWidget {
  final String busNumber;
  final String driverName;
  final int numberOfStudents;
  final String driverPhoneNumber;
  final Widget destinationPage; // Add destination page for navigation

  const BusCard({
    Key? key,
    required this.busNumber,
    required this.driverName,
    required this.numberOfStudents,
    required this.driverPhoneNumber,
    required this.destinationPage, // Required to pass destination page
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 252, 196, 113),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            // Left side for Bus number
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Bus',
                      style: TextStyle(
                        fontSize: 22,
                        color: Color.fromARGB(255, 201, 129, 36),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      busNumber,
                      style: const TextStyle(
                        fontSize: 30,
                        color: Color.fromARGB(255, 201, 129, 36),
                        fontWeight: FontWeight.bold,
                        //color: Color.fromARGB(255, 201, 129, 36),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Vertical Divider
            Container(
              width: 1,
              height: 60,
              color: Colors.black54,
            ),
            // Right side for Driver details
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Driver: $driverName',
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Number of Students: $numberOfStudents',
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color.fromARGB(230, 0, 0, 0),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Phone Icon
            IconButton(
              icon: const Icon(
                Icons.phone,
                color: Colors.green,
              ),
              onPressed: () => makePhoneCall(driverPhoneNumber),
            ),
            // Arrow Icon
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black54,
                ),
                onPressed: () {
                  // Navigate to the passed destination page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => destinationPage),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
