import 'package:flutter/material.dart';

import '../Backend/feedback.dart';
import '../Backend/profile_info.dart';
import '../Backend/signup.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.person_add),
            onPressed: () {
              // Handle signup action
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SignupPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: UserProfileInfo(),
          ),
          Expanded(
            flex: 1,
            child: UserFeedbackAndRating(),
          ),
        ],
      ),
    );
  }
}
