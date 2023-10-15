import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:workout_app/Backend/signup.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? _errorText; // Variable to hold error messages

  Future<void> _signIn() async {
    try {
      final String email = _emailController.text;
      final String password = _passwordController.text;

      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Clear text fields upon successful login
      _emailController.clear();
      _passwordController.clear();

      // Navigate to the next screen or perform any other action
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
        title: Text('Login'),
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
                  'Welcome Back!',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
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
                  onPressed: _signIn,
                  child: Text('Sign In'),
                ),
                SizedBox(height: 10.0),
                TextButton(
                  onPressed: () {
                    // Handle forgot password or other actions
                  },
                  child: Text('Forgot Password?'),
                ),
                TextButton(
                  onPressed: () {
                    // Handle navigate to signup or other actions
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignupPage(),
                      ),
                    );
                  },
                  child: Text('Don\'t have an account? Click here to sign up.'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
