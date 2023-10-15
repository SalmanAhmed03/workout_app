import 'package:flutter/material.dart';

import 'e2.dart';

class MyExerciseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Exercise Plan"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: List.generate(4, (index) {
            // Simulated completed days for each instance of e1
            int completedDays = index + 1;
      
            return buildE1(weekNumber: index + 1, completedDays: completedDays, context: context);
          }),
        ),
      ),
    );
  }

  Widget buildE1({required int weekNumber, required int completedDays, required BuildContext context}) {
    return GestureDetector(
      onTap: () {
        // Navigate to the next screen when a container is clicked
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => e2(),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.all(16.0), // Add margin for spacing
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.4), // Adjust the opacity
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: e1(weekNumber: weekNumber, completedDays: completedDays),
      ),
    );
  }
}

class e1 extends StatelessWidget {
  final int weekNumber;
  final int completedDays;

  e1({
    required this.weekNumber,
    required this.completedDays,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: [
          // Top Section
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              children: [
                Text(
                  'Weekly $weekNumber',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5.0),
                Text(
                  '$completedDays/7',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
          // Spacing between top section and days
          SizedBox(height: 20.0),
          // Split days into two rows
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              4,
              (index) => Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (index < completedDays) ? Colors.blue : Colors.white,
                  border: Border.all(
                    color: Colors.blue,
                    width: 2.0,
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  (index + 1).toString(),
                  style: TextStyle(
                    color: (index < completedDays) ? Colors.white : Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10.0), // Spacing between the two rows of days
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              3,
              (index) => Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ((index + 4) < completedDays) ? Colors.blue : Colors.white,
                  border: Border.all(
                    color: Colors.blue,
                    width: 2.0,
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  (index + 5).toString(),
                  style: TextStyle(
                    color: ((index + 4) < completedDays) ? Colors.white : Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          // Spacing between the top and bottom sections
          SizedBox(height: 20.0),
          // Add trophy icon to the bottom section
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                (completedDays >= 7) ? Icons.emoji_events : Icons.star,
                color: Colors.yellow,
                size: 40.0,
              ),
            ],
          ),
        ],
      ),
    );
  }
}



