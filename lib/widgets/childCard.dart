import 'package:flutter/material.dart';

class ChildCard extends StatelessWidget {
  final String name;
  final String id;
  final String eta;
  final String imageUrl;
  final bool isCheckedIn;
  final bool isCallEnabled;

  const ChildCard({
    Key? key,
    required this.name,
    required this.id,
    required this.eta,
    required this.imageUrl,
    required this.isCheckedIn,
    required this.isCallEnabled,
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
          borderRadius: BorderRadius.circular(20),
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage(imageUrl),
            radius: 30,
          ),
          title: Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ID No. $id',
                style: const TextStyle(
                  color: Colors.white70,
                ),
              ),
              Text(
                'ETA: $eta',
                style: const TextStyle(
                  color: Colors.white70,
                ),
              ),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isCallEnabled)
                IconButton(
                  icon: const Icon(Icons.call, color: Colors.white),
                  onPressed: () {
                    // Action when call button is pressed
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
