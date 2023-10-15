import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfileInfo extends StatefulWidget {
  @override
  _UserProfileInfoState createState() => _UserProfileInfoState();
}

class _UserProfileInfoState extends State<UserProfileInfo> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  User? _user;
  String? _email;
  bool _isEditing = true;

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    if (_user != null) {
      final userData = await _firestore.collection('users').doc(_user!.uid).get();
      if (userData.exists) {
        setState(() {
          _email = userData['email'];
          _nameController.text = userData['name'];
          _addressController.text = userData['address'];
        });
      }
    }
  }

  Future<void> _saveUserData() async {
    if (_user != null) {
      await _firestore.collection('users').doc(_user!.uid).set({
        'name': _nameController.text,
        'email': _email,
        'address': _addressController.text,
      });
      setState(() {
        _isEditing = false;
      });

      // Show a success dialog
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('Your data has been updated successfully.'),
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: TextEditingController(text: _email ?? ''),
              enabled: false, // Set this to false to disable editing
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
              enabled: _isEditing, // Allow editing based on _isEditing
            ),
            TextField(
              controller: _addressController,
              decoration: InputDecoration(labelText: 'Address'),
              enabled: _isEditing, // Allow editing based on _isEditing
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (_isEditing) {
                  await _saveUserData();
                }
                setState(() {
                  _isEditing = !_isEditing;
                });
              },
              child: Text(_isEditing ? 'Save' : 'Edit'), // Change button text
            ),
          ],
        ),
      ),
    );
  }
}
