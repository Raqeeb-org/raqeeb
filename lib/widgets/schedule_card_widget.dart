import 'package:flutter/material.dart';

class ScheduleCardWidget extends StatelessWidget {
  final String day;
  final String date;
  final String tripTime;
  final VoidCallback onSeeTripPressed;

  const ScheduleCardWidget({
    Key? key,
    required this.day,
    required this.date,
    required this.tripTime,
    required this.onSeeTripPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.orange[300],
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                day,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),
              Text(
                date,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                tripTime,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          TextButton(
            onPressed: onSeeTripPressed,
            child: Text('See my trip'),
          ),
        ],
      ),
    );
  }
}
