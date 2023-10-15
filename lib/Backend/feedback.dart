import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class UserFeedbackAndRating extends StatefulWidget {
  @override
  _UserFeedbackAndRatingState createState() => _UserFeedbackAndRatingState();
}

class _UserFeedbackAndRatingState extends State<UserFeedbackAndRating> {
  double _rating = 0.0; // Initial rating value
  TextEditingController _feedbackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16.0),
      children: [
        Text(
          'Give Us Your Feedback',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10.0),
        TextFormField(
          controller: _feedbackController,
          maxLines: 5,
          decoration: InputDecoration(
            labelText: 'Feedback',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 20.0),
        Text(
          'Rate Us',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10.0),
        RatingBar.builder(
          initialRating: _rating,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemSize: 40.0,
          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            setState(() {
              _rating = rating;
            });
          },
        ),
        SizedBox(height: 20.0),
        ElevatedButton(
          onPressed: () {
            // Handle submitting feedback and rating
            final feedback = _feedbackController.text;
            // Save feedback and rating to your database or perform actions accordingly
            // Reset the feedback field and rating
            _feedbackController.clear();
            setState(() {
              _rating = 0.0;
            });
            // Show a confirmation or thank you message
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Thank You!'),
                  content: Text('Your feedback and rating have been submitted.'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('OK'),
                    ),
                  ],
                );
              },
            );
          },
          child: Text('Submit'),
        ),
        SizedBox(height: 20.0),
        
      ],
    );
  }
}
