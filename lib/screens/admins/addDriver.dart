import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddDriverScreen extends StatefulWidget {
  const AddDriverScreen({super.key});

  @override
  _AddDriverScreenState createState() => _AddDriverScreenState();
}

class _AddDriverScreenState extends State<AddDriverScreen> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> _controllers = {
    'First Name': TextEditingController(),
    'Last Name': TextEditingController(),
    'ID No.': TextEditingController(),
    'Phone No.': TextEditingController(),
    'Email': TextEditingController(),
    'Password': TextEditingController(),
    'Repeat Password': TextEditingController(),
  };

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _addDriver() async {
    if (!_formKey.currentState!.validate()) return;

    final String firstName = _controllers['First Name']!.text.trim();
    final String lastName = _controllers['Last Name']!.text.trim();
    final String idNo = _controllers['ID No.']!.text.trim();
    final String phoneNo = _controllers['Phone No.']!.text.trim();
    final String email = _controllers['Email']!.text.trim();
    final String password = _controllers['Password']!.text.trim();
    final String repeatPassword = _controllers['Repeat Password']!.text.trim();

    // Check if passwords match
    if (password != repeatPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords do not match")),
      );
      return;
    }

    try {
      // Create user in Firebase Authentication
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final String userId = userCredential.user!.uid;

      // Add driver information to Firestore
      await _firestore
          .collection('Users/2J4DFh6Gxi9vNAmip0iA/Drivers')
          .doc(userId)
          .set({
        'email': email,
        'fullName': '$firstName $lastName',
        'phoneNum': phoneNo,
        'username': email.split('@')[0],
        'idNo': idNo,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Driver added successfully")),
      );

      // Clear input fields
      _formKey.currentState!.reset();
      for (var controller in _controllers.values) {
        controller.clear();
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to add driver: ${e.message}")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An error occurred: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFACE6EE), // Baby blue background color
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Avatar and Title Section
                const Padding(
                  padding: EdgeInsets.only(bottom: 20.0),
                  child: Column(
                    children: [
                      Icon(
                        Icons.account_circle,
                        size: 80,
                        color: Color.fromARGB(255, 247, 164, 0),
                      ),
                      Text(
                        'Add Driver',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 247, 164, 0),
                        ),
                      ),
                    ],
                  ),
                ),

                // First Name and Last Name Fields Side by Side
                Row(
                  children: [
                    Expanded(
                      child: buildTextField(
                          'First Name', _controllers['First Name']),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: buildTextField(
                          'Last Name', _controllers['Last Name']),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // ID No. Field
                buildTextField('ID No.', _controllers['ID No.']),
                const SizedBox(height: 10),

                // Phone No. Field
                buildTextField('Phone No.', _controllers['Phone No.']),
                const SizedBox(height: 10),

                // Email Field
                buildTextField('Email', _controllers['Email']),
                const SizedBox(height: 10),

                // Password Field
                buildTextField('Password', _controllers['Password'],
                    isPassword: true),
                const SizedBox(height: 10),

                // Repeat Password Field
                buildTextField(
                    'Repeat Password', _controllers['Repeat Password'],
                    isPassword: true),
                const SizedBox(height: 20),

                // Submit Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(
                        255, 247, 164, 0), // Background color
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40.0, vertical: 15.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  onPressed: _addDriver,
                  child: const Text(
                    'Done',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper function to build text form fields
  Widget buildTextField(String label, TextEditingController? controller,
      {bool isPassword = false}) {
    return Center(
      child: SizedBox(
        width: double.infinity,
        child: TextFormField(
          controller: controller,
          obscureText: isPassword,
          style: const TextStyle(
              color: Colors.black), // Set input text color to black
          decoration: InputDecoration(
            labelText: label,
            labelStyle:
                const TextStyle(color: Color.fromARGB(255, 144, 141, 141)),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                  color: Color.fromARGB(255, 247, 164, 0), width: 2.0),
              borderRadius: BorderRadius.circular(30.0), // Rounded corners
            ),
            enabledBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: Color.fromARGB(255, 247, 164, 0)),
              borderRadius: BorderRadius.circular(30.0), // Rounded corners
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0), // Rounded corners
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter $label';
            }
            return null;
          },
        ),
      ),
    );
  }
}
