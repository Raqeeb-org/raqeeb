import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Raqeeb Dashboard'),
        backgroundColor: Colors.lightBlue[200],
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Overview Section
              Text('Overview', style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildInfoCard('Total Active Buses', '5', Colors.lightBlue),
                    _buildInfoCard('Total Students', '120', Colors.green),
                    _buildInfoCard('Total Drivers', '8', Colors.orange),
                    _buildInfoCard('Today\'s Trips', '6', Colors.red),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Widgets for Each Section
              _buildSectionCard(
                title: 'Student Attendance Monitoring',
                content: [
                  _buildListItem(
                    icon: Icons.check_circle,
                    color: Colors.green,
                    title: 'Attendance Status',
                    subtitle: 'View real-time student attendance status.',
                  ),
                  _buildListItem(
                    icon: Icons.history,
                    color: Colors.blue,
                    title: 'Attendance History',
                    subtitle:
                        'Historical records of student boardings and drop-offs.',
                  ),
                ],
              ),
              const SizedBox(height: 10),
              _buildSectionCard(
                title: 'Driver and Bus Management',
                content: [
                  _buildListItem(
                    icon: Icons.person,
                    color: Colors.purple,
                    title: 'Driver Profiles',
                    subtitle:
                        'Manage driver information, contact details, and assigned buses.',
                  ),
                  _buildListItem(
                    icon: Icons.bus_alert,
                    color: Colors.orange,
                    title: 'Bus Maintenance Logs',
                    subtitle:
                        'Track bus maintenance schedules and operational status.',
                  ),
                ],
              ),
              const SizedBox(height: 10),
              _buildSectionCard(
                title: 'Reports and Analytics',
                content: [
                  _buildListItem(
                    icon: Icons.analytics,
                    color: Colors.teal,
                    title: 'Attendance Reports',
                    subtitle: 'Generate and export attendance reports.',
                  ),
                  _buildListItem(
                    icon: Icons.bar_chart,
                    color: Colors.indigo,
                    title: 'Performance Analytics',
                    subtitle:
                        'Analyze trip efficiency, driver performance, and more.',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildColoredCard(
      {required String title,
      required String count,
      required Color color,
      required IconData icon}) {
    return Expanded(
      child: Card(
        color: color,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white, size: 40),
              const SizedBox(height: 10),
              Text(
                count,
                style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 10),
              const ListTile(
                leading: Icon(Icons.bar_chart, color: Colors.indigo),
                title: Text('Performance Analytics'),
                subtitle: Text(
                    'Analyze trip efficiency, driver performance, and more.'),
              ),
              const ListTile(
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

  Widget _buildSectionCard({
    required String title,
    required List<Widget> content,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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

  Widget _buildListItem({
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
  }) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }
}