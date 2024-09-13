import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final ValueNotifier<bool> _dark = ValueNotifier<bool>(true);
  final ValueNotifier<double> _widthFactor = ValueNotifier<double>(1.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _dark.value ? Colors.black : Colors.white,
      appBar: AppBar(
        actions: [
          Switch(
            value: _dark.value,
            onChanged: (value) {
              _dark.value = value;
            },
          ),
          DropdownButton<double>(
            value: _widthFactor.value,
            onChanged: (value) {
              _widthFactor.value = value!;
            },
            items: const [
              DropdownMenuItem<double>(
                value: 0.5,
                child: Text('Size: 50%'),
              ),
              DropdownMenuItem<double>(
                value: 0.75,
                child: Text('Size: 75%'),
              ),
              DropdownMenuItem<double>(
                value: 1.0,
                child: Text('Size: 100%'),
              ),
            ],
          ),
        ],
      ),
      body: Stack(
        children: [
          // Blue background that fills the entire screen
          Container(
            color: const Color(0xFFCCF7FD),
            width: double.infinity,
            height: double.infinity,
          ),
          // Scrollable content to prevent overflow
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 70), // Top padding
                SizedBox(
                  width: MediaQuery.of(context).size.width * _widthFactor.value,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Log In',
                        style: TextStyle(
                          color: Color(0xFFFFB700),
                          fontSize: 64,
                          fontFamily: 'Wendy One',
                        ),
                      ),
                      const Text(
                        'Log in to your account and rest',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'Baloo Bhai 2',
                        ),
                      ),
                      const SizedBox(height: 30),
                      buildTextField('Email'),
                      const SizedBox(height: 15),
                      buildTextField('Password'),
                      const SizedBox(height: 15),
                      buildTextField('Type of user'),
                      const SizedBox(height: 30),
                      buildLoginButton(),
                      const SizedBox(height: 15),
                      const Text(
                        'Forgot my password',
                        style: TextStyle(
                          color: Color(0xFF1083EE),
                          fontSize: 12,
                          fontFamily: 'Aleo',
                        ),
                      ),
                      const SizedBox(height: 50), // Spacing before image
                      Image.asset(
                        "assets/images/bus.png", // Local image
                        fit: BoxFit.cover,
                        height: 250,
                        width: double.infinity,
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTextField(String labelText) {
    return Container(
      width: 323,
      height: 43,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 2, color: Color(0xFFFFB700)),
          borderRadius: BorderRadius.circular(100),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            labelText,
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

  Widget buildLoginButton() {
    return Container(
      width: 323,
      height: 37,
      padding: const EdgeInsets.all(8),
      decoration: ShapeDecoration(
        color: const Color(0xFFFFB700),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 4,
            offset: Offset(0, 5),
            spreadRadius: 0,
          ),
        ],
      ),
      child: const Center(
        child: Text(
          'Log in',
          style: TextStyle(
            color: Color(0xFF19181A),
            fontSize: 16,
            fontFamily: 'Aleo',
          ),
        ),
      ),
    );
  }
}
