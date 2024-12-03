import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> resetPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFCCF7FD), // Light blue background
      appBar: AppBar(
        backgroundColor:
            Colors.transparent, // Makes the AppBar background transparent
        elevation: 0, // Removes shadow from the AppBar
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Colors.black), // Back arrow icon
          onPressed: () {
            Navigator.pop(context); // Navigates back to the previous screen
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.start, // Aligns items at the top
            crossAxisAlignment:
                CrossAxisAlignment.center, // Centers items horizontally
            children: [
              const SizedBox(height: 20), // Add spacing from AppBar

              // Logo image centered at the top
              Center(
                child: Image.asset(
                  'assets/images/Raqeeb-r.png',
                  height: 200, // Adjust the height as needed
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 30), // Space below the image

              // Forgot Password Text
              const Text(
                'Forgot Password?',
                style: TextStyle(
                  color: Color(0xFFFFB700),
                  fontSize: 36,
                  fontFamily: 'Wendy One', // Use your own font
                ),
                textAlign: TextAlign.center,
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
                    color: const Color(0xFFFFB700),
                    width: 2,
                  ),
                ),
                child: TextField(
                  controller: emailController, // Connects the controller
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

              // Send Button with Email Icon
              ElevatedButton(
                onPressed: () async {
                  if (emailController.text.isNotEmpty) {
                    try {
                      String email = emailController.text.trim();
                      await resetPassword(email);

                      // Show the same message for registered and unregistered emails
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              "A password reset link has been sent if the email is registered."),
                        ),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("An error occurred. Please try again."),
                        ),
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please enter your email."),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFB700), // Button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 12,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min, // Adjusts to fit content
                  children: [
                    const Icon(
                      Icons.email, // Email icon
                      color: Color(0xFF19181A), // Icon color
                    ),
                    const SizedBox(width: 8), // Spacing between icon and text
                    const Text(
                      'Send',
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF19181A), // Text color
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
