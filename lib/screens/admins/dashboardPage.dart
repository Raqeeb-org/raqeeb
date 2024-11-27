import 'package:flutter/material.dart';
class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Raqeeb Dashboard'),
        centerTitle: true,
        backgroundColor: Colors.lightBlue[200], // Set the AppBar color to light blue
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
                  _buildInfoCard('Total Active Buses', '5', Colors.lightBlue),
                  _buildInfoCard('Total Students', '120', Colors.green),
                  _buildInfoCard('Total Drivers', '8', Colors.orange),
                  _buildInfoCard('Today\'s Trips', '6', Colors.red),
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
             const  ListTile(
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

  Widget _buildInfoCard(String title, String count, Color color) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1), // Background color with light opacity
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(count,
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: color)), // Text color matches the card color
           const SizedBox(height: 5),
            Text(title,
                textAlign: TextAlign.center,
                style: TextStyle(color: color)), // Text color matches the card
          ],
        ),
      ),
    );
  }
}
