import 'package:flutter/material.dart';


import 'Home.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // Simulate a delay of 3 seconds before moving to the main screen
  Future<void> _loadMainScreen() async {
    await Future.delayed(Duration(seconds: 2));
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => MyHomePage(), // Navigate to your main screen
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadMainScreen(); // Start the loading process when the screen is first shown
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'images/load.jpg', // Replace with the path to your loading image
          width: 200,
          height: 200,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
