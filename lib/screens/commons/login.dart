import 'package:flutter/material.dart';
import '/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _selectedUserType;

  final List<String> userTypes = ['Drivers', 'Parent', 'Admins'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[100],
      resizeToAvoidBottomInset:
          true, // This will resize when the keyboard opens
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50), // Adds space at the top

              // Title
              Text(
                'Log In',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange[300],
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Log in to your account and rest',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 40),

              // Email TextField
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  labelText: 'Email',
                  prefixIcon: const Icon(Icons.email),
                ),
              ),
              const SizedBox(height: 20),

              // Password TextField
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock),
                ),
              ),
              const SizedBox(height: 20),

              // Dropdown for Type of User
              DropdownButtonFormField<String>(
                value: _selectedUserType,
                hint: const Text('Type of user'),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedUserType = newValue;
                  });
                },
                items: userTypes.map((String type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  prefixIcon: const Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 40),

              // Log In Button
              ElevatedButton(
                onPressed: () async {
                  if (_selectedUserType != null) {
                    String email = _emailController.text.trim();
                    String password = _passwordController.text.trim();
                    String selectedRole = _selectedUserType!;
                    //.toLowerCase(); // Ensure the role is lowercase
                    print('Role: $selectedRole');

                    // Use AuthService to log in and verify role
                    try {
                      AuthService authService = AuthService();
                      bool loginSuccess = await authService.signInAndVerifyRole(
                          email, password, selectedRole);

                      if (loginSuccess) {
                        // Navigate to the corresponding home page based on role
                        switch (selectedRole) {
                          case 'Drivers':
                            Navigator.pushReplacementNamed(
                                context, '/driver_home');
                            break;
                          case 'parent':
                            Navigator.pushReplacementNamed(
                                context, '/parent_home');
                            break;
                          case 'Admins':
                            Navigator.pushReplacementNamed(
                                context, '/admin_home');
                            break;
                        }
                      } else {
                        // Show error if role verification fails
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(
                                  'Role verification failed! Please check your credentials.')),
                        );
                      }
                    } catch (e) {
                      // Handle error and show appropriate message to the user
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Login failed: $e')),
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Please select a valid user type')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange[300],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                ),
                child: const Text(
                  'Log in',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 20),

              // Forgot Password Text
              TextButton(
                onPressed: () {
                  // Forgot password logic
                },
                child: const Text('Forgot my password'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
