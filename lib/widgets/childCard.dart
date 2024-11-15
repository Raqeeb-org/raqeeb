import 'package:flutter/material.dart';
import 'package:raqeeb/utils/phone_utils.dart';

class ChildCard extends StatelessWidget {
  final String name;
  final String id;
  final String imageUrl;
  final bool isCheckedIn;
  final String parentPhoneNumber;

  const ChildCard({
    Key? key,
    required this.name,
    required this.id,
    required this.imageUrl,
    required this.isCheckedIn,
    required this.parentPhoneNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: isCheckedIn
              ? const Color.fromARGB(255, 252, 196, 113)
              : Colors.grey,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              // Custom-sized CircleAvatar
              CircleAvatar(
                backgroundImage: AssetImage(imageUrl),
                radius: 30,
              ),
              const SizedBox(width: 16), // Add spacing between avatar and text
              // Name and ID Column
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'ID No. $id',
                      style: const TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                    Text(
                      'Status: ${isCheckedIn ? 'Checked In' : 'Not Checked In'}',
                      style: const TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
              // Trailing Icons
              if (parentPhoneNumber.isNotEmpty)
                IconButton(
                  icon: const Icon(Icons.call, color: Colors.white),
                  onPressed: () {
                    makePhoneCall(parentPhoneNumber);
                  },
                ),
              Icon(
                isCheckedIn ? Icons.check_circle : Icons.radio_button_unchecked,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
