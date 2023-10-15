import 'package:flutter/material.dart';

class WeeklyGoalTracker extends StatelessWidget {
  final int completedDays;

  WeeklyGoalTracker({
    required this.completedDays,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.blue,
          borderRadius: BorderRadius.circular(10.0),),
      child: Column(
        children: [
          // Top Section
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Weekly Goals',
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
          // Bottom Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              7,
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
        ],
      ),
    );
  }
}
