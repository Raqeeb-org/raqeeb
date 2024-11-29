import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:raqeeb/services/firebase_service.dart';

class AddParentScreen extends StatefulWidget {
  @override
  _AddParentScreenState createState() => _AddParentScreenState();
}

class _AddParentScreenState extends State<AddParentScreen> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> _controllers = {
    'First Name': TextEditingController(),
    'Middle Name': TextEditingController(),
    'Last Name': TextEditingController(),
    'ID No.': TextEditingController(),
    'Full Name': TextEditingController(),
    'Phone No.': TextEditingController(),
    'Email': TextEditingController(),
    'Home Postal Code': TextEditingController(),
    'Password': TextEditingController(),
    'Repeat Password': TextEditingController(),
  };

  final FirebaseService _firebaseService = FirebaseService();
  String _selectedGender = '';
  String? _selectedBus; // To store the selected bus
  String? _selectedGrade; // To store the selected grade
  String? _selectedParent;
  bool _isParentExisting = false; // Tracks whether the parent exists

  @override
  void dispose() {
    _controllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String? adminId = _firebaseService.getCurrentAdminId();

    if (adminId == null) {
      return const Scaffold(
        body: Center(child: Text("No user is logged in")),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFACE6EE),
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
                      Divider(
                        color: Color.fromARGB(255, 169, 165, 165),
                        thickness: 1,
                        indent: 40,
                        endIndent: 40,
                      ),
                    ],
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.only(left: 45.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Student Info:',
                          style: TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 169, 165, 165))),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                // First Name and Middle Name Fields Side by Side
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 175,
                      child: buildTextField(
                          'First Name', _controllers['First Name']),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      width: 175,
                      child: buildTextField(
                          'Middle Name', _controllers['Middle Name']),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Last Name Field
                buildTextField('Last Name', _controllers['Last Name']),
                const SizedBox(height: 10),

                // ID No. Field
                buildTextField('ID No.', _controllers['ID No.']),
                const SizedBox(height: 10),

                // Gender Selection Row
                Padding(
                  padding: const EdgeInsets.only(left: 45.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        'Gender: ',
                        style: TextStyle(fontSize: 16),
                      ),
                      Row(
                        children: [
                          Radio<String>(
                            value: 'Male',
                            groupValue: _selectedGender,
                            onChanged: (value) {
                              setState(() {
                                _selectedGender = value!;
                              });
                            },
                          ),
                          const Text('Male'),
                        ],
                      ),
                      Row(
                        children: [
                          Radio<String>(
                            value: 'Female',
                            groupValue: _selectedGender,
                            onChanged: (value) {
                              setState(() {
                                _selectedGender = value!;
                              });
                            },
                          ),
                          const Text('Female'),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                // Bus Selection Dropdown and Child Grade Dropdown
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 175,
                      child: StreamBuilder<QuerySnapshot>(
                        stream: _firebaseService.getBusesForAdmin(adminId),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          }
                          if (!snapshot.hasData ||
                              snapshot.data!.docs.isEmpty) {
                            return const Text(
                                'No buses available for this admin.');
                          }

                          // Extract bus names or IDs
                          final buses = snapshot.data!.docs;

                          return DropdownButtonFormField<String>(
                            value: _selectedBus,
                            hint: const Text('Assign a bus'),
                            items: buses.map((bus) {
                              final busData =
                                  bus.data() as Map<String, dynamic>;
                              final busName =
                                  busData['busNum'] ?? 'Unnamed Bus';
                              return DropdownMenuItem<String>(
                                value: bus.id,
                                child: Text(busName),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedBus = value;
                              });
                            },
                            decoration: InputDecoration(
                              labelText: 'Bus',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            validator: (value) =>
                                value == null ? 'Please select a bus' : null,
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      width: 175,
                      child: DropdownButtonFormField<String>(
                        value: _selectedGrade,
                        hint: const Text('Select Grade'),
                        items: List.generate(6, (index) {
                          final grade = 'Grade ${index + 1}';
                          return DropdownMenuItem<String>(
                            value: grade,
                            child: Text(grade),
                          );
                        }),
                        onChanged: (value) {
                          setState(() {
                            _selectedGrade = value!;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Grade',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        validator: (value) =>
                            value == null ? 'Please select a grade' : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Add a divider between the ID No. and Phone No. fields
                const Divider(
                  color: Color.fromARGB(255, 169, 165, 165),
                  thickness: 1,
                  indent: 40,
                  endIndent: 40,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 45.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Parent Info:',
                          style: TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 169, 165, 165))),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Parent Selection Dropdown
                Row(
                  children: [
                    Checkbox(
                      value: _isParentExisting,
                      onChanged: (value) {
                        setState(() {
                          _isParentExisting = value!;
                        });
                      },
                    ),
                    const Text('Parent Already Exists'),
                  ],
                ),
                const SizedBox(height: 10),

                if (_isParentExisting)
                  StreamBuilder<List<Map<String, dynamic>>>(
                    stream: _firebaseService.getParentsByAdmin(adminId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.hasError) {
                        return const Text('Error loading parents.');
                      }

                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Text('No parents available.');
                      }

                      final parents = snapshot.data!;
                      print('Final Parents for Dropdown: $parents');

                      return DropdownButtonFormField<String>(
                        value: _selectedParent,
                        hint: const Text('Select Parent'),
                        items: parents.map((parentData) {
                          final parentDocId = parentData['docId'];
                          //final parentId = parentRef.id;
                          final parentName =
                              parentData['fullName'] ?? 'Unnamed Parent';

                          return DropdownMenuItem<String>(
                            value: parentDocId,
                            child: Text(parentName),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedParent = value;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Parent',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      );
                    },
                  )
                else
                  Column(
                    children: [
                      // Full Name Field
                      buildTextField('Full Name', _controllers['Full Name']),
                      const SizedBox(height: 10),
                      // Phone No. Field
                      buildTextField('Phone No.', _controllers['Phone No.']),
                      const SizedBox(height: 10),
                      // Email Field
                      buildTextField('Email', _controllers['Email']),
                      const SizedBox(height: 10),
                      // Home Postal Code Field
                      buildTextField(
                          'Home Postal Code', _controllers['Home Postal Code']),
                      const SizedBox(height: 10),
                      buildTextField('Password', _controllers['Password'],
                          isPassword: true),
                      const SizedBox(height: 10),
                      buildTextField(
                          'Repeat Password', _controllers['Repeat Password'],
                          isPassword: true),
                      const SizedBox(height: 10),
                    ],
                  ),

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
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        final adminId = _firebaseService.getCurrentAdminId();
                        if (adminId == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Admin is not logged in')),
                          );
                          return;
                        }

                        // Check if the parent already exists
                        if (_isParentExisting) {
                          if (_selectedParent == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Please select a parent')),
                            );
                            return;
                          }

                          // Add the child with the existing parent reference
                          await _firebaseService.addChild(
                            firstName: _controllers['First Name']!.text,
                            lastName: _controllers['Last Name']!.text,
                            midName: _controllers['Middle Name']!.text,
                            idNum: _controllers['ID No.']!.text,
                            gender: _selectedGender,
                            grade: _selectedGrade!,
                            homePostalCode:
                                _controllers['Home Postal Code']!.text,
                            houseLocation:
                                '[LAT, LNG]', // Replace with actual coordinates
                            currentLocation: "",
                            busId: _selectedBus!,
                            parentId:
                                _selectedParent!, // Use selected parent's ID
                            adminId: adminId,
                            status: "",
                          );
                        } else {
                          // Parent does not exist; create parent and add child
                          final String parentId =
                              await _firebaseService.addParentAndCreateAuth(
                            email: _controllers['Email']!.text,
                            password: _controllers['Password']!.text,
                            fullName: _controllers['Full Name']!.text,
                            phoneNumber: _controllers['Phone No.']!.text,
                            adminId: adminId,
                          );

                          // Add child with the newly created parent
                          await _firebaseService.addChild(
                            firstName: _controllers['First Name']!.text,
                            lastName: _controllers['Last Name']!.text,
                            midName: _controllers['Middle Name']!.text,
                            idNum: _controllers['ID No.']!.text,
                            gender: _selectedGender,
                            grade: _selectedGrade!,
                            homePostalCode:
                                _controllers['Home Postal Code']!.text,
                            houseLocation:
                                '[LAT, LNG]', // Replace with actual coordinates
                            currentLocation: "",
                            busId: _selectedBus!,
                            parentId: parentId,
                            adminId: adminId,
                            status: "",
                          );
                        }

                        // Show success message
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Student added successfully')),
                        );

                        // Reset form
                        _formKey.currentState!.reset();
                        setState(() {
                          _selectedGender = '';
                          _selectedBus = null;
                          _selectedGrade = null;
                          _selectedParent = null;
                          _isParentExisting = false;
                        });
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error: $e')),
                        );
                      }
                    }
                  },
                  child: const Text(
                    'Done',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController? controller,
      {bool isPassword = false}) {
    return Center(
      child: Container(
        width: 350,
        child: TextFormField(
          maxLength: 40,
          controller: controller,
          obscureText: isPassword,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            labelText: label,
            labelStyle:
                const TextStyle(color: Color.fromARGB(255, 144, 141, 141)),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.orange, width: 2.0),
              borderRadius: BorderRadius.circular(30.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.orange),
              borderRadius: BorderRadius.circular(30.0),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter $label';
            }

            // Example: Validate email format
            if (label == 'Email' &&
                !RegExp(r"^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$")
                    .hasMatch(value)) {
              return 'Please enter a valid email';
            }

            // Example: Validate phone number
            if (label == 'Phone No.' && !RegExp(r'^\d{10}$').hasMatch(value)) {
              return 'Please enter a valid 10-digit phone number';
            }

            // Example: Validate ID number (numeric only)
            if (label == 'ID No.' && !RegExp(r'^\d+$').hasMatch(value)) {
              return 'ID must be numeric';
            }

            // Example: Validate password strength
            if (label == 'Password' &&
                !RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$')
                    .hasMatch(value)) {
              return 'Password must be at least 8 characters long and include letters and numbers';
            }

            // Example: Validate postal code (numeric and fixed length = 5 digits)
            if (label == 'Home Postal Code' &&
                !RegExp(r'\d{5}$').hasMatch(value)) {
              return 'Please enter a valid postal code';
            }

            return null; // If validation passes
          },
        ),
      ),
    );
  }
}
