import 'package:flutter/material.dart';

class AddDriverScreen extends StatefulWidget {
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

  @override
  void dispose() {
    _controllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Driver')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _controllers['First Name'],
                decoration: const InputDecoration(labelText: 'First Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter First Name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _controllers['Last Name'],
                decoration: const InputDecoration(labelText: 'Last Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Last Name';
                  }
                  return null;
                },
              ),
              // Add more input fields for other details
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Form is valid, proceed with submission
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Driver Added')),
                    );
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
