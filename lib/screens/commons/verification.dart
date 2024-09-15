import 'package:flutter/material.dart';

class Verification extends StatelessWidget {
  final ValueNotifier<bool> _dark = ValueNotifier<bool>(true);

  Verification({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ValueListenableBuilder<bool>(
        valueListenable: _dark,
        builder: (context, isDark, child) {
          return Scaffold(
            body: Center(
              child: Container(
                color: const Color(0xFFCCF7FD),
                width: double.infinity,
                height: double.infinity,
                child: const Center(
                  // This centers the PasswordResetForm widget
                  child: VerificationForm(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class VerificationForm extends StatelessWidget {
  const VerificationForm();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize:
          MainAxisSize.min, // Ensure the widgets take up minimal space
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Add the image at the top
        Image.asset(
          'assets/images/profile_icon.png', // Path to your image asset
          width: 120, // Adjust size as needed
          height: 120,
        ),

        // Placeholder for user's name
        const Text(
          'John Doe', // Replace with actual user name dynamically
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 20),

        const Text(
          'Enter the 4 Digit Verification Code',
          style: TextStyle(
            color: Color.fromARGB(255, 55, 70, 147),
            fontSize: 25,
            fontFamily: 'Wendy One',
          ),
        ),
        const SizedBox(height: 30),

        // Password fields
        _buildPasswordField(context, 'Code'),
        const SizedBox(height: 16),

        // Done button
        _buildDoneButton(context),
      ],
    );
  }

  Widget _buildPasswordField(BuildContext context, String label) {
    return Container(
      width: 330,
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.black.withOpacity(0.38),
              fontSize: 14,
              fontFamily: 'Aleo',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextButton(BuildContext context, String text) {
    return TextButton(
      onPressed: () {}, // will make it clickable later
      child: Text(
        text,
        style: const TextStyle(
          color: Color.fromARGB(255, 55, 70, 147),
          fontSize: 14,
          fontFamily: 'Aleo',
        ),
      ),
    );
  }

  Widget _buildDoneButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Add your onTap action here
        print('Done button clicked!'); // will modify its functionality later
      },
      child: Container(
        width: 141,
        height: 39,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 242, 199, 90),
          borderRadius: BorderRadius.circular(100),
          boxShadow: const [
            BoxShadow(
              color: Color(0x3F000000),
              blurRadius: 4,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: const Center(
          child: Text(
            'Done',
            style: TextStyle(
              color: Color(0xFF19181A),
              fontSize: 16,
              fontFamily: 'Aleo',
            ),
          ),
        ),
      ),
    );
  }
}
