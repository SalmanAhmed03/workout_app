import 'package:flutter/material.dart';

class DietPlanScreen extends StatefulWidget {
  DietPlanScreen({Key? key}) : super(key: key);

  @override
  _DietPlanScreenState createState() => _DietPlanScreenState();
}

class _DietPlanScreenState extends State<DietPlanScreen> {
  List<DietItemModel> dietItems = [
    DietItemModel(name: 'Diet 1', description: 'Your description 1'),
    DietItemModel(name: 'Diet 2', description: 'Your description 2'),
    DietItemModel(name: 'Diet 3', description: 'Your description 3'),
    DietItemModel(name: 'Diet 4', description: 'Your description 4'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Diet",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        textTheme: const TextTheme(
          headline6: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            children: List.generate(dietItems.length, (index) {
              return DietItem(
                name: dietItems[index].name,
                description: dietItems[index].description,
              );
            }),
          ),
        ),
      ),
    );
  }
}

class DietItem extends StatefulWidget {
  final String name;
  final String description;

  DietItem({
    required this.name,
    required this.description,
  });

  @override
  _DietItemState createState() => _DietItemState();
}

class _DietItemState extends State<DietItem> {
  bool isChecked = false;
  bool isEditing = false;

  late TextEditingController nameController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.name);
    descriptionController = TextEditingController(text: widget.description);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          // Image Asset
          Expanded(
            child: Image.asset(
              'images/ed/BReakfast.jpg',
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                isEditing
                    ? TextField(
                        controller: nameController,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : Text(
                        nameController.text,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                isEditing
                    ? TextField(
                        controller: descriptionController,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      )
                    : Text(
                        descriptionController.text,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
              ],
            ),
          ),
          Checkbox(
            value: isChecked,
            onChanged: (value) {
              setState(() {
                isChecked = value ?? false;
              });
            },
          ),
          IconButton(
            icon: Icon(isEditing ? Icons.save : Icons.edit),
            onPressed: () {
              setState(() {
                isEditing = !isEditing;
              });
            },
          ),
        ],
      ),
    );
  }
}

class DietItemModel {
  final String name;
  final String description;

  DietItemModel({
    required this.name,
    required this.description,
  });
}
