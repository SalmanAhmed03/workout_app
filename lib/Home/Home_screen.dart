import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:workout_app/Backend/reminder.dart';
import 'package:workout_app/Home/excersie/e1.dart';
import 'package:workout_app/Home/tips.dart';

import 'weekly_goals.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Blue Part (Custom AppBar)
            Container(
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                ),
              ),
              padding: const EdgeInsets.only(
                left: 30,
                top: 30,
                right: 30,
                bottom: 20,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          // Add your onPressed logic here
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ReminderScreen(
                                  ),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.access_alarm_outlined,
                          color: Colors.white,
                          size: 31,
                        ), // Use an appropriate icon from Icons class
                      ),
                      IconButton(
                        onPressed: () {
                          // Add your onPressed logic here
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TipsScreen(),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.tips_and_updates_outlined,
                          color: Colors.white,
                          size: 31,
                        ), // Use an appropriate icon from Icons class
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        'images/logo.png',
                        fit: BoxFit.cover,
                        width: 80,
                        height: 80,
                      ), // Add a comma here
                      const SizedBox(
                        width: 20,
                      ),
                      const Text(
                        'DeskPanda',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: const [
                            Text(
                              '5',
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Workouts ',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: const [
                            Text(
                              '250',
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Kcal',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: const [
                            Text(
                              '120',
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Minutes',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  WeeklyGoalTracker(
                    completedDays: 3, // Update with the completed days
                  ),
                ],
              ),
            ),

            // White Part (Content Area)
            Container(
              color: Colors.white,
              padding:
                  EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 30),
              child: Center(
                child: Column(
                  children: [
                    Row(
                      children: const [
                        Text(
                          '7x4 Challenge',
                          style: TextStyle(fontSize: 24, color: Colors.black),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    _buildContentProgress('Full Body', '7x4', 80, '3 Days Left',
                        () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyExerciseScreen(),
                        ),
                      );
                    }, 'images/1.jpg'),
                    const SizedBox(height: 15),
                    _buildContentProgress('Lower Body', '7x4', 0,
                        '30 Days Left', () {}, 'images/4.jpg'),
                    // Add more containers or content widgets as needed
                    const SizedBox(height: 25),
                    Row(
                      children: const [
                        Text(
                          'BEGINNER',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),

                    /////////////////beginner/////////////////
                    _buildContentProgress1(
                      'ABS Beginner',
                      Icons.bolt,
                      'images/1.jpg',
                      () {},
                    ),
                    const SizedBox(height: 15),
                    _buildContentProgress1(
                        'Chest Beginner', Icons.bolt, 'images/1.png', () {}),
                    const SizedBox(height: 15),
                    _buildContentProgress1(
                        'Arm Beginner', Icons.bolt, 'images/3.jpg', () {}),
                    const SizedBox(height: 15),
                    _buildContentProgress1(
                        'Legs Beginner', Icons.bolt, 'images/4.jpg', () {}),
                    const SizedBox(height: 15),
                    _buildContentProgress1('Shoulder & Back Beginner',
                        Icons.bolt, 'images/2.jpg', () {}),
                    const SizedBox(height: 25),
                    Row(
                      children: const [
                        Text(
                          'Intermediate',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContentProgress(
    String title,
    String subtitle,
    int percentage,
    String daysLeft,
    VoidCallback onPressed,
    String
        backgroundImageAsset, // Add a parameter for the background image asset path
  ) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blueGrey,
          borderRadius: BorderRadius.circular(10.0),
          image: DecorationImage(
            image: AssetImage(
                backgroundImageAsset), // Pass the asset image path here
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$percentage%',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                Text(
                  daysLeft, // Replace with the actual days text
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              value: percentage / 100.0,
              backgroundColor: Colors.white,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContentProgress1(
    String title,
    IconData iconData,
    String imageAsset, // Add a parameter for the image asset path
    VoidCallback onPressed,
  ) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blueGrey,
          borderRadius: BorderRadius.circular(10.0),
          image: DecorationImage(
            image: AssetImage(imageAsset), // Pass the asset image path here
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Icon(
                  iconData, // Use the provided IconData for the icon
                  color: Colors.blue,
                  size: 24,
                ),
                Icon(
                  iconData, // Use the provided IconData for the icon
                  color: Colors.white,
                  size: 24,
                ),
                Icon(
                  iconData, // Use the provided IconData for the icon
                  color: Colors.white,
                  size: 24,
                ),
                SizedBox(width: 10), // Add spacing between icons and image
              ],
            ),
          ],
        ),
      ),
    );
  }
}
