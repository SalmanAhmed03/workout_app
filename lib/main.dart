import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Backend/signup.dart';
import 'Home/Home.dart';
import 'Home/splash_screen.dart';
import 'firebase_options.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp.key()); // Corrected constructor name
}

class MyApp extends StatefulWidget {
  const MyApp.key(); // Corrected constructor name

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            initialRoute: '/',
            routes: {
             '/signup/': (context) => SignupPage(),
            },
            home: SplashScreen(),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
