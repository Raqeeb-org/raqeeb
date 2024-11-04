import 'package:flutter/material.dart';

// ProfileOptionCard Widget for other profile options
class ProfileOptionCard extends StatefulWidget {
  final String title;
  final IconData icon;
  final VoidCallback onArrowClick;
  final bool expandable;
  // final Widget? expandedContent;
  final String? message; // Optional message for the expanded state

  const ProfileOptionCard({
    required this.title,
    required this.icon,
    required this.onArrowClick,
    this.expandable = false,
    this.message,
    Key? key,
  }) : super(key: key);

  @override
  _ProfileOptionCardState createState() => _ProfileOptionCardState();
}

class _ProfileOptionCardState extends State<ProfileOptionCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Container(
        width: double.infinity,
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        widget.icon,
                        size: 40,
                        color: const Color.fromARGB(255, 201, 129, 36),
                      ),
                      const SizedBox(width: 15), // Space between icon and title
                      Text(
                        widget.title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: AnimatedRotation(
                      turns: _isExpanded ? 0.25 : 0,
                      duration: const Duration(milliseconds: 300),
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.black54,
                      ),
                    ),
                    onPressed: () {
                      if (widget.expandable) {
                        setState(() {
                          _isExpanded = !_isExpanded;
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
            if (_isExpanded && widget.expandable) ...[
              const SizedBox(height: 10),
              if (widget.message != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    widget.message!,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: widget.onArrowClick,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                ),
                child: const Text(
                  'Confirm',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              const SizedBox(height: 10),
            ]
          ],
        ),
      ),
    );
  }
}
