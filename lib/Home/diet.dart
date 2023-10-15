import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:workout_app/Home/diet_plan.dart';

class Dietscreen extends StatelessWidget {
  const Dietscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Diet Plan",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0, // Set the elevation to 0 to remove shadow
        // You can also set other properties like text color, icon color, etc. as needed.
        iconTheme: const IconThemeData(
            color: Colors.black), // Example: Set icon color to black
        textTheme: const TextTheme(
          headline6: TextStyle(
            color: Colors.black, // Example: Set title text color to black
            fontSize: 20, // Example: Set title text size
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              _buildContentProgress1('Empolyee Diet ', Icons.food_bank_outlined,
                  'images/ed/Afternoon Snack.jpg', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DietPlanScreen(),
                  ),
                );
              }),
              const SizedBox(
                height: 20,
              ),
              _buildContentProgress1(
                  'Student Diet ', Icons.food_bank_outlined, 'images/sd/f.jpg',
                  () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DietPlanScreen(),
                  ),
                );
              }),
              const SizedBox(
                height: 20,
              ),
              _buildContentProgress1('Regular Diet ', Icons.food_bank_outlined,
                  'images/sd/DINNER.jpg', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DietPlanScreen(),
                  ),
                );
              }),
              const SizedBox(
                height: 20,
              ),
              _buildContentProgress1('Lunch Diet ', Icons.food_bank_outlined,
                  'images/sd/lUNCH.jpg', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DietPlanScreen(),
                  ),
                );
              }),
              const SizedBox(
                height: 20,
              ),
              _buildContentProgress1('Morning Diet ', Icons.food_bank_outlined,
                  'images/sd/mORNING SCNAK.jpg', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DietPlanScreen(),
                  ),
                );
              }),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
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
                style: TextStyle(fontSize: 24, color: Colors.black),
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
                color: Colors.black,
                size: 24,
              ),
              Icon(
                iconData, // Use the provided IconData for the icon
                color: Colors.black,
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
