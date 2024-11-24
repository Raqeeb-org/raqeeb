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

  /// Fetch parents based on admin ID
  Stream<QuerySnapshot<Map<String, dynamic>>> _getParentsByAdmin(
      String adminId) {
    return FirebaseFirestore.instance
        .collection('Children') // Assuming "Children" is the collection name
        .where('adminId', isEqualTo: adminId)
        .snapshots()
        .asyncMap((childrenSnapshot) async {
      final parentRefs = childrenSnapshot.docs
          .map((doc) => (doc.data()['ParentID'] as DocumentReference).path)
          .toSet();

      final parentSnapshots = await Future.wait(
        parentRefs.map((ref) => FirebaseFirestore.instance.doc(ref).get()),
      );

      final parentData = parentSnapshots.map((snap) {
        return snap.data();
      }).toList();

      return QuerySnapshot(
        docs: parentSnapshots,
        metadata: childrenSnapshot.metadata,
      );
    });
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
                  StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: _getParentsByAdmin(adminId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return const Text('No parents available.');
                      }

                      return DropdownButtonFormField<String>(
                        value: _selectedParent,
                        hint: const Text('Select Parent'),
                        items: snapshot.data!.docs.map((parentDoc) {
                          final parentData = parentDoc.data();
                          final parentName =
                              parentData['name'] ?? 'Unnamed Parent';
                          return DropdownMenuItem<String>(
                            value: parentDoc.id,
                            child: Text(parentName),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedParent = value;
                          });
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Parent',
                        ),
                      );
                    },
                  )
                else
                  Column(
                    children: [
                      // Full Name Field
                      buildTextField('Full Name', _controllers['Full Name']),
                      // Phone No. Field
                      buildTextField('Phone No.', _controllers['Phone No.']),
                      // Email Field
                      buildTextField('Email', _controllers['Email']),
                      // Home Postal Code Field
                      buildTextField(
                          'Home Postal Code', _controllers['Home Postal Code']),
                      buildTextField('Password', _controllers['Password'],
                          isPassword: true),
                      buildTextField(
                          'Repeat Password', _controllers['Repeat Password'],
                          isPassword: true),
                    ],
                  ),

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
            return null;
          },
        ),
      ),
    );
  }
}
