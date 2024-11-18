import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Raqeeb Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Overview Section
              Text('Overview',
                  style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildInfoCard('Total Active Buses', '5'),
                  _buildInfoCard('Total Students', '120'),
                  _buildInfoCard('Total Drivers', '8'),
                  _buildInfoCard('Today\'s Trips', '6'),
                ],
              ),
              const SizedBox(height: 20),

              // Student Attendance Summary
              Text('Student Attendance Summary',
                  style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 10),
              const ListTile(
                leading: Icon(Icons.access_time, color: Colors.blue),
                title: Text('Daily Attendance Log'),
                subtitle: Text(
                    'Summary of student boardings and exits with timestamps.'),
              ),
              const SizedBox(height: 10),
              const ListTile(
                leading: Icon(Icons.list, color: Colors.green),
                title: Text('Student Status by Trip'),
                subtitle:
                    Text('Detailed view of each student’s boarding status.'),
              ),

              // Driver Performance and Profiles
              const SizedBox(height: 20),
              Text('Driver Performance and Profiles',
                  style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 10),
              const ListTile(
                leading: CircleAvatar(
                    backgroundImage:
                        NetworkImage('https://via.placeholder.com/150')),
                title: Text('Driver Overview'),
                subtitle: Text(
                    'List of all drivers with photos and contact information.'),
              ),
              const SizedBox(height: 10),
              const ListTile(
                leading: Icon(Icons.assessment, color: Colors.orange),
                title: Text('Driver Performance Logs'),
                subtitle: Text(
                    'View each driver’s trip history and punctuality records.'),
              ),

              // School Management Section
              const SizedBox(height: 20),
              Text('School Management',
                  style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 10),
              ListTile(
                leading: Icon(Icons.school, color: Colors.purple),
                title: Text('School Profile Overview'),
                subtitle:
                    Text('Address, contact details, and admin information.'),
              ),
            ],
          ),
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
}
