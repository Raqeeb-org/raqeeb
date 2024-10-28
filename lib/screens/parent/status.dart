import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class StatusScreen extends StatefulWidget {
  @override
  _StatusScreenState createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  int currentStatus = 0;

  void updateStatus(int status) {
    setState(() {
      currentStatus = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(172, 230, 238, 100), // Background color as in your image
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 60.0,
            ),
            // Title Section
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Text(
                    'Status',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'You can learn about your children status by tracking this line :)',
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            // Horizontal Timeline Section with dynamic updates
            SizedBox(
              height: 80, // Adjust the height for the timeline
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      // First timeline tile (Picked Up)
                      TimelineTile(
                        axis: TimelineAxis.horizontal,
                        alignment: TimelineAlign.center,
                        isFirst: true,
                        indicatorStyle: IndicatorStyle(
                          width: 10,
                          color: currentStatus >= 0 ? Colors.blue : Colors.grey, // Active or inactive based on status
                          iconStyle: IconStyle(
                            iconData: Icons.circle,
                            color: Colors.white,
                          ),
                        ),
                        beforeLineStyle: const LineStyle(
                          color: Colors.blue,
                          thickness: 6,
                        ),
                        afterLineStyle: LineStyle(
                          color: currentStatus > 0 ? Colors.blue : Colors.grey, // Active or inactive based on status
                          thickness: 6,
                        ),
                        endChild: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Picked Up'),
                        ),
                      ),

                      // Second tile (On the Way)
                      TimelineTile(
                        axis: TimelineAxis.horizontal,
                        alignment: TimelineAlign.center,
                        indicatorStyle: IndicatorStyle(
                          width: 10,
                          color: currentStatus >= 1 ? Colors.orange : Colors.grey, // Active or inactive
                          iconStyle: IconStyle(
                            iconData: Icons.directions_bus,
                            color: Colors.white,
                          ),
                        ),
                        beforeLineStyle: LineStyle(
                          color: currentStatus >= 1 ? Colors.blue : Colors.grey, // Active or inactive
                          thickness: 6,
                        ),
                        afterLineStyle: LineStyle(
                          color: currentStatus > 1 ? Colors.blue : Colors.grey, // Active or inactive
                          thickness: 6,
                        ),
                        endChild: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('On the Way'),
                        ),
                      ),

                      // Third tile (Arrived at School)
                      TimelineTile(
                        axis: TimelineAxis.horizontal,
                        alignment: TimelineAlign.center,
                        indicatorStyle: IndicatorStyle(
                          width: 10,
                          color: currentStatus >= 2 ? Colors.green : Colors.grey, // Active or inactive
                          iconStyle: IconStyle(
                            iconData: Icons.school,
                            color: Colors.white,
                          ),
                        ),
                        beforeLineStyle: LineStyle(
                          color: currentStatus >= 2 ? Colors.blue : Colors.grey, // Active or inactive
                          thickness: 6,
                        ),
                        afterLineStyle: LineStyle(
                          color: currentStatus > 2 ? Colors.blue : Colors.grey, // Active or inactive
                          thickness: 6,
                        ),
                        endChild: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Arrived at School'),
                        ),
                      ),

                      // Fourth timeline tile (Back Home)
                      TimelineTile(
                        axis: TimelineAxis.horizontal,
                        alignment: TimelineAlign.center,
                        isLast: true,
                        indicatorStyle: IndicatorStyle(
                          width: 10,
                          color: currentStatus == 3 ? Colors.red : Colors.grey, // Active or inactive
                          iconStyle: IconStyle(
                            iconData: Icons.home,
                            color: Colors.white,
                          ),
                        ),
                        beforeLineStyle: LineStyle(
                          color: currentStatus == 3 ? Colors.blue : Colors.grey, // Active or inactive
                          thickness: 6,
                        ),
                        endChild: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Back Home'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Map Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Child Location',
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[300],
                    ),
                    child: const Center(
                      child: Text('Map Placeholder'),
                      // Normally, here you'd use a Google Maps or similar widget to display the child's location.
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20), // Add extra spacing to fill screen

            // Trigger buttons to simulate status changes (for testing)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => updateStatus(0),
                  child: const Text('Picked Up'),
                ),
                ElevatedButton(
                  onPressed: () => updateStatus(1),
                  child: const Text('On the Way'),
                ),
                ElevatedButton(
                  onPressed: () => updateStatus(2),
                  child: const Text('Arrived at School'),
                ),
                ElevatedButton(
                  onPressed: () => updateStatus(3),
                  child: const Text('Back Home'),
                ),
              ],
            ),
            const SizedBox(height: 20), // Add extra spacing to ensure the background reaches the bottom
          ],
        ),
      ),
    );
  }
}
