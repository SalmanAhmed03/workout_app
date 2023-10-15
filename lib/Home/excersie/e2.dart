import 'dart:async';

import 'package:flutter/material.dart';
import 'package:workout_app/Home/Home.dart';

class e2 extends StatefulWidget {
  @override
  _e2State createState() => _e2State();
}

class _e2State extends State<e2> {
  int exerciseIndex = 0;
  bool isBreak = false;
  bool isExerciseStarted = false;
  int breakDuration = 30;
  Timer? breakTimer;
  int breakTimeElapsed = 0; // Track the elapsed time during the break

  List<Map<String, String>> exerciseData = [
    {
      'title': 'Push Up',
      'description': 'This is the description for Exercise 1',
      'imagePath': 'images/ex/1.png',
    },
    {
      'title': 'Bicycle Crunches',
      'description': 'This is the description for Exercise 2',
      'imagePath': 'images/ex/2.png',
    },
    {
      'title': 'Pull up',
      'description': 'This is the description for Exercise 3',
      'imagePath': 'images/ex/3.png',
    },
    {
      'title': 'Runing',
      'description': 'This is the description for Exercise 4',
      'imagePath': 'images/ex/4.png',
    },
    {
      'title': 'Weight lifting',
      'description': 'This is the description for Exercise 5',
      'imagePath': 'images/ex/5.png',
    },
  ];

  void startExercise() {
    setState(() {
      isExerciseStarted = true;
      isBreak = false;
      if (isBreak) {
        startBreakTimer();
      }
    });
  }

  void moveToNextExercise() {
    if (exerciseIndex < exerciseData.length - 1) {
      setState(() {
        exerciseIndex++;
        isBreak = true; // Start a break
        isExerciseStarted = false;
        breakTimeElapsed = 0; // Reset the elapsed time during the break
      });
      startBreakTimer();
    } else {
      // You have completed all exercises
      setState(() {
        exerciseIndex = 0;
        isBreak = false;
        isExerciseStarted = false;
        breakTimeElapsed = 0; // Reset the elapsed time during the break
      });
      showWellDoneMessage();
    }
  }

  void showWellDoneMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Well Done!'),
          content: Text('You have completed all exercises.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                 Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyHomePage(),
                )
              );// Go back to the previous page
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void startBreakTimer() {
    breakTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (breakDuration - breakTimeElapsed == 0) {
        timer.cancel();
        moveToNextExercise();
      } else {
        setState(() {
          breakTimeElapsed++;
        });
      }
    });
  }

  @override
  void dispose() {
    breakTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Exercise Plan"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!isBreak)
              Column(
                children: [
                  Image.asset(
                    exerciseData[exerciseIndex]['imagePath']!,
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    exerciseData[exerciseIndex]['description']!,
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            Text(
              isBreak
                  ? 'Break (${breakDuration - breakTimeElapsed}s)'
                  : isExerciseStarted
                      ? 'Exercise ${exerciseIndex + 1}'
                      : 'Ready to Start',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            if (!isExerciseStarted)
              ElevatedButton(
                onPressed: startExercise,
                child: Text("Start Exercise"),
              ),
            if (isExerciseStarted)
              ElevatedButton(
                onPressed: moveToNextExercise,
                child: Text("Next Exercise"),
              ),
          ],
        ),
      ),
    );
  }
}
