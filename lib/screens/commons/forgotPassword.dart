import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFCCF7FD), // Light blue background
      appBar: AppBar(
        backgroundColor:
            Colors.transparent, // Makes the AppBar background transparent
        elevation: 0, // Removes shadow from the AppBar
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black), // Back arrow icon
          onPressed: () {
            Navigator.pop(context); // Navigates back to the previous screen
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Bus image
                Image.asset(
                  'assets/images/Bus.jpg',
                  height: 250,
                ),
                const SizedBox(height: 20),
                // Forgot Password Text
                const Text(
                  'Forgot Password?',
                  style: TextStyle(
                    color: Color(0xFFFFB700),
                    fontSize: 36,
                    fontFamily: 'Wendy One', // Use your own font
                  ),
                ),
                const SizedBox(height: 10),
                // Email text field
                Container(
                  width: 300,
                  height: 45,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(
                      color: Color(0xFFFFB700),
                      width: 2,
                    ),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Email',
                      hintStyle: TextStyle(
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                // Next Button
                ElevatedButton(
                  onPressed: () {
                    // Define action here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFFB700), // Button color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 60,
                      vertical: 12,
                    ),
                  ),
                  child: const Text(
                    'Next',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF19181A), // Text color
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
