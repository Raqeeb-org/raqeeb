import 'package:flutter/material.dart';
import 'package:raqeeb/widgets/busCard.dart';
import 'package:raqeeb/screens/admins/morningBusChildren.dart';

class SchoolBusesScreen extends StatelessWidget {
  const SchoolBusesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 189, 236, 242),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Morning Trip Buses',
          style: TextStyle(
            color: Color.fromARGB(255, 247, 164, 0),
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: const [
                BusCard(
                  busNumber: '01',
                  driverName: 'Abdullah Hatem',
                  numberOfStudents: 8,
                  destinationPage: MorningBusChildren(),
                ),
                BusCard(
                  busNumber: '02',
                  driverName: 'Abdullah Hatem',
                  numberOfStudents: 8,
                  destinationPage: MorningBusChildren(),
                ),
                BusCard(
                  busNumber: '03',
                  driverName: 'Abdullah Hatem',
                  numberOfStudents: 8,
                  destinationPage: MorningBusChildren(),
                ),
                BusCard(
                  busNumber: '04',
                  driverName: 'Abdullah Hatem',
                  numberOfStudents: 8,
                  destinationPage: MorningBusChildren(),
                ),
              ],
            ),
          ),
          // Bottom navigation bar
        ],
      ),
    );
  }
}
