import 'package:flutter/material.dart';

class AddStudentScreen extends StatefulWidget {
  @override
  _AddStudentScreenState createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
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

  @override
  void dispose() {
    _controllers.values.forEach((controller) => controller.dispose());
    super.dispose();
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
                        size: 100,
                        color: Colors.orange,
                      ),
                      Text(
                        'Add Student',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                ),

                // First Name and Last Name Fields Side by Side with Custom Widths
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 175, // Custom width for First Name
                      child: buildTextField(
                          'First Name', _controllers['First Name']),
                    ),
                    const SizedBox(width: 10), // Space between the two fields
                    Container(
                      width: 175, // Custom width for Last Name
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
                    backgroundColor: Colors.orange, // Background color
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40.0, vertical: 15.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Student Added')),
                      );
                    }
                  },
                  child: const Text(
                    'Done',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper function to build text form fields with reduced width and more rounded corners
  Widget buildTextField(String label, TextEditingController? controller,
      {bool isPassword = false}) {
    return Center(
      child: Container(
        width: 350, // Default width for other text boxes
        child: TextFormField(
          controller: controller,
          obscureText: isPassword,
          style: const TextStyle(
              color: Colors.black), // Set input text color to black
          decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(
                color: Color.fromARGB(
                    255, 144, 141, 141)), // Set label text color to black
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.orange, width: 2.0),
              borderRadius: BorderRadius.circular(30.0), // More rounded corners
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.orange),
              borderRadius: BorderRadius.circular(30.0), // More rounded corners
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0), // More rounded corners
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
