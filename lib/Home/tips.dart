import 'package:flutter/material.dart';

class TipsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tips'),
      ),
      body: ListView(
        children: [
          _buildTipItem(
            'Correct way to Sit',
            'images/ps/7.png', // Replace with the actual image path
            'This is the first tip description. You can provide some useful information here.',
          ),
          _buildTipItem(
            'Correct Ways to Use a Mobile',
            'images/ps/6.png', // Replace with the actual image path
            'Here is the second tip. Make sure to add informative content for your users.',
          ),
          _buildTipItem(
            'How to Sit in Office',
            'images/ps/8.png', // Replace with the actual image path
            'Here is the second tip. Make sure to add informative content for your users.',
          ),
          _buildTipItem(
            'Correct Ways to sit while using Computer',
            'images/ps/9.png', // Replace with the actual image path
            'Here is the second tip. Make sure to add informative content for your users.',
          ),
          // A
          // Add more tip items as needed
        ],
      ),
    );
  }

  Widget _buildTipItem(String title, String imagePath, String description) {
    return Card(
      margin: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            imagePath,
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

