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

              // Student Attendance Monitoring
              Text('Student Attendance Monitoring',
                  style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 10),
              const ListTile(
                leading: Icon(Icons.check_circle, color: Colors.green),
                title: Text('Attendance Status'),
                subtitle: Text('View real-time student attendance status.'),
              ),
              const SizedBox(height: 10),
              const ListTile(
                leading: Icon(Icons.history, color: Colors.blue),
                title: Text('Attendance History'),
                subtitle: Text(
                    'Historical records of student boardings and drop-offs.'),
              ),

              // Driver and Bus Management
              const SizedBox(height: 20),
              Text('Driver and Bus Management',
                  style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 10),
              const ListTile(
                leading: Icon(Icons.person, color: Colors.purple),
                title: Text('Driver Profiles'),
                subtitle: Text(
                    'Manage driver information, contact details, and assigned buses.'),
              ),
              const SizedBox(height: 10),
              const ListTile(
                leading: Icon(Icons.bus_alert, color: Colors.orange),
                title: Text('Bus Maintenance Logs'),
                subtitle: Text(
                    'Track bus maintenance schedules and operational status.'),
              ),

              // Reports and Analytics
              const SizedBox(height: 20),
              Text('Reports and Analytics',
                  style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 10),
              const ListTile(
                leading: Icon(Icons.analytics, color: Colors.teal),
                title: Text('Attendance Reports'),
                subtitle: Text('Generate and export attendance reports.'),
              ),
              const SizedBox(height: 10),
              const ListTile(
                leading: Icon(Icons.bar_chart, color: Colors.indigo),
                title: Text('Performance Analytics'),
                subtitle: Text(
                    'Analyze trip efficiency, driver performance, and more.'),
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
