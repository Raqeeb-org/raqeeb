import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Raqeeb Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Overview Section
            Text('Overview', style: Theme.of(context).textTheme.headlineSmall),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildInfoCard('Total Active Buses', '5'),
                _buildInfoCard('Total Students', '120'),
                _buildInfoCard('Total Drivers', '15'),
                _buildInfoCard('Today\'s Trips', '10'),
              ],
            ),
            SizedBox(height: 20),

            // Student Attendance Summary
            Text('Student Attendance Summary',
                style: Theme.of(context).textTheme.headlineSmall),
            SizedBox(height: 10),
            _buildAttendanceLog(),
            SizedBox(height: 20),
            _buildStudentStatus(),

            // Driver Performance and Profiles
            SizedBox(height: 20),
            Text('Driver Performance and Profiles',
                style: Theme.of(context).textTheme.headlineSmall),
            SizedBox(height: 10),
            _buildDriverOverview(),
            SizedBox(height: 10),
            _buildDriverPerformanceLogs(),

            // School Management Section
            SizedBox(height: 20),
            Text('School Management',
                style: Theme.of(context).textTheme.headlineSmall),
            SizedBox(height: 10),
            _buildSchoolProfile(),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String count) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Container(
        width: 100,
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(count,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text(title, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  Widget _buildAttendanceLog() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Daily Attendance Log',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ListTile(
          title: Text('Student 1'),
          subtitle: Text('Boarded at 7:30 AM, Exited at 8:15 AM'),
        ),
        ListTile(
          title: Text('Student 2'),
          subtitle: Text('Boarded at 7:45 AM, Exited at 8:20 AM'),
        ),
      ],
    );
  }

  Widget _buildStudentStatus() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Student Status by Trip',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ListTile(
          title: Text('Student 1'),
          subtitle: Text('On board'),
        ),
        ListTile(
          title: Text('Student 2'),
          subtitle: Text('Dropped off'),
        ),
      ],
    );
  }

  Widget _buildDriverOverview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Driver Overview',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ListTile(
          leading:
              CircleAvatar(backgroundImage: AssetImage('assets/driver1.jpg')),
          title: Text('Driver 1'),
          subtitle: Text('Contact: +123456789'),
        ),
        ListTile(
          leading:
              CircleAvatar(backgroundImage: AssetImage('assets/driver2.jpg')),
          title: Text('Driver 2'),
          subtitle: Text('Contact: +987654321'),
        ),
      ],
    );
  }

  Widget _buildDriverPerformanceLogs() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Driver Performance Logs',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ListTile(
          title: Text('Driver 1'),
          subtitle: Text('On time for 95% of trips'),
        ),
        ListTile(
          title: Text('Driver 2'),
          subtitle: Text('On time for 88% of trips'),
        ),
      ],
    );
  }

  Widget _buildSchoolProfile() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('School Profile',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ListTile(
          title: Text('School Name: ABC School'),
          subtitle: Text('Address: 123 School St, City, Country'),
        ),
        ListTile(
          title: Text('Contact Info'),
          subtitle: Text('Email: admin@abcschool.com, Phone: +123456789'),
        ),
      ],
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: DashboardScreen(),
  ));
}
