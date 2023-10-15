import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:workout_app/Backend/login.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? _errorText; // Variable to hold error messages

  Future<void> _signUp() async {
    try {
      final String email = _emailController.text;
      final String password = _passwordController.text;
      final String confirmPassword = _confirmPasswordController.text;

      if (password != confirmPassword) {
        // Passwords don't match
        setState(() {
          _errorText = 'Passwords do not match. Please try again.';
        });
        return;
      }

      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Send email verification
      await userCredential.user?.sendEmailVerification();

      // Add user info to Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user?.uid)
          .set({
        'email': email,
      });

      // Show a success dialog
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Signup Successful'),
            content: Text('You have successfully signed up.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  // Clear text fields upon successful signup
                  _emailController.clear();
                  _passwordController.clear();
                  _confirmPasswordController.clear();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      // Handle errors
      setState(() {
        _errorText = e.toString(); // Set error text to the error message
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Signup'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'images/logo.png',
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
                const Text(
                  'Hello',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'Register to get started',
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
                SizedBox(height: 20.0),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                ),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                TextField(
                  controller: _confirmPasswordController,
                  decoration: InputDecoration(labelText: 'Confirm Password'),
                  obscureText: true,
                ),
                SizedBox(
                    height: 10.0), // Add space between fields and error message
                if (_errorText != null) // Display error message if available
                  Text(
                    _errorText!,
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: _signUp,
                  child: Text('Sign Up'),
                ),
                SizedBox(height: 10.0),
                TextButton(
                  onPressed: () {
                    // Handle already have an account action
                    // You can navigate to the login page or any other appropriate action
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                    );
                  },
                  child:
                      Text('Already have an account? Click here to sign in.'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
