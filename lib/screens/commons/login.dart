import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _selectedUserType;

  final List<String> userTypes = ['Driver', 'Parent', 'School Administrator'];

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
                    String selectedRole = _selectedUserType!
                        .toLowerCase(); // Ensure the role is lowercase

                    // Use AuthService to log in and verify role
                    try {
                      AuthService authService = AuthService();
                      bool loginSuccess = await authService.signInAndVerifyRole(
                          email, password, selectedRole);

                      if (loginSuccess) {
                        // Navigate to the corresponding home page based on role
                        switch (selectedRole) {
                          case 'driver':
                            Navigator.pushReplacementNamed(
                                context, '/driver_home');
                            break;
                          case 'parent':
                            Navigator.pushReplacementNamed(
                                context, '/parent_home');
                            break;
                          case 'school administrator':
                            Navigator.pushReplacementNamed(
                                context, '/admin_home');
                            break;
                        }
                      } else {
                        // Show error if role verification fails
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
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

// Login function
Future<void> loginUser(
    String email, String password, String selectedRole) async {
  try {
    // Sign in user using Firebase Auth
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Get user ID
    String userId = userCredential.user!.uid;

    // Fetch user details from Firestore based on role
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection(selectedRole)
        .doc(userId)
        .get();

    // Extract user data (this will vary based on your structure)
    Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
    print("User Data: $userData");

    // Navigate to the appropriate screen (you need to implement this)
    // e.g. navigateToRoleScreen(userData, selectedRole);
  } catch (e) {
    print("Login failed: $e");
    // Handle error (e.g., show error message to the user)
  }
}
