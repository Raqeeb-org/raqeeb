import 'package:flutter/material.dart';

class ExpandableProfileCard extends StatefulWidget {
  final String title;
  final String name;
  final String phoneNumber;
  final String email;
  final String schoolName;
  final String neighborhood;
  final String city;
  final String country;
  final IconData avatarIcon;
  final String avatarImagePath;

  const ExpandableProfileCard({
    Key? key,
    required this.title,
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.schoolName,
    required this.neighborhood,
    required this.city,
    required this.country,
    required this.avatarIcon,
    required this.avatarImagePath,
  }) : super(key: key);

  @override
  _ExpandableProfileCardState createState() => _ExpandableProfileCardState();
}

class _ExpandableProfileCardState extends State<ExpandableProfileCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: double.infinity,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 252, 196, 113),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundImage: AssetImage(widget.avatarImagePath),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        widget.phoneNumber,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.blue,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: AnimatedRotation(
                    turns: _isExpanded ? 0.25 : 0,
                    duration: const Duration(milliseconds: 300),
                    child: const Icon(Icons.arrow_forward_ios,
                        color: Colors.black54),
                  ),
                  onPressed: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
                ),
              ],
            ),
            if (_isExpanded) ...[
              const SizedBox(height: 20),
              _buildDetailRow('Email', widget.email),
              _buildDetailRow('School Name', widget.schoolName),
              _buildDetailRow('Neighborhood', widget.neighborhood),
              _buildDetailRow('City', widget.city),
              _buildDetailRow('Country', widget.country),
            ],
          ],
        ),
      ),
    );
  }

  // Helper method to build a row for each detail
  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$label:',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
