import 'package:flutter/material.dart';

class ChangePassword extends StatelessWidget {
  final ValueNotifier<bool> _dark = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // This allows the AppBar to be transparent
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Transparent background
        elevation: 0, // Removes the AppBar shadow
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(
                context); // This will navigate back to the previous screen
          },
        ),
      ),
      body: ValueListenableBuilder<bool>(
        valueListenable: _dark,
        builder: (context, isDark, child) {
          return Center(
            child: Container(
              color: const Color(0xFFCCF7FD),
              width: double.infinity,
              height: double.infinity,
              child: const Center(
                // This centers the PasswordResetForm widget
                child: PasswordResetForm(),
              ),
            ),
          );
        },
      ),
    );
  }
}

class PasswordResetForm extends StatelessWidget {
  const PasswordResetForm();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
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
            'Reset your password',
            style: TextStyle(
              color: Color.fromARGB(255, 247, 164, 0),
              fontSize: 30,
              fontFamily: 'Wendy One',
            ),
          ),
          const SizedBox(height: 30),

          // Password fields
          _buildPasswordField(context, 'Current Password'),
          const SizedBox(height: 16),
          _buildTextButton(context, 'Forgot my password'),
          const SizedBox(height: 16),
          _buildPasswordField(context, 'New Password'),
          const SizedBox(height: 16),
          _buildPasswordField(context, 'Repeat New Password'),
          const SizedBox(height: 16),
          _buildPasswordField(context, 'Email'),
          const SizedBox(height: 32),

          // Done button
          _buildDoneButton(context),
          const SizedBox(height: 16),
        ],
      ),
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
          color: Color.fromARGB(255, 242, 199, 90),
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
