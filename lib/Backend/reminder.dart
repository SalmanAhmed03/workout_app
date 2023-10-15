import 'dart:core';



import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class ReminderScreen extends StatefulWidget {
  @override
  _ReminderScreenState createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime selectedDateTime = DateTime.now();
  bool isDaily = false;

  bool isEditing = true;

  @override
  void initState() {
    super.initState();
    tz.initializeTimeZones();

    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }
Future<void> scheduleReminder(bool isDaily, DateTime scheduledTime) async {
  var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
    'daily_notification',
    'Daily Reminder',
    importance: Importance.max,
    priority: Priority.high,
    channelShowBadge: true,
    enableVibration: true,
    playSound: true,
    
  );
TimeOfDay selectedTime = TimeOfDay.now();

  // Create a TZDateTime by combining the selectedDate and selectedTime
  var scheduledDateTime = tz.TZDateTime(
    tz.local, 
    scheduledTime.year, 
    scheduledTime.month, 
    scheduledTime.day, 
    selectedTime.hour, 
    selectedTime.minute
  );

  await flutterLocalNotificationsPlugin.zonedSchedule(
    0,
    nameController.text, // Reminder Name
    descriptionController.text, // Reminder Description
    scheduledDateTime,
    NotificationDetails(
      android: androidPlatformChannelSpecifics,
    ),
    androidAllowWhileIdle: true,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
    matchDateTimeComponents: DateTimeComponents.time,
    payload: 'Custom_Sound',
  );

  // If it's a daily reminder, schedule the next day's reminder
  if (isDaily) {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      nameController.text, // Reminder Name
      descriptionController.text, // Reminder Description
      scheduledDateTime.add(const Duration(days: 1)),
      NotificationDetails(
        android: androidPlatformChannelSpecifics,
      ),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: 'Custom_Sound',
    );
  }

  // Show the alert dialog when the reminder is set
  await _showReminderAlertDialog();
}

Future<void> _showReminderAlertDialog() async {
  return showDialog<void>(
    context: context, // Use the context from the widget tree
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Reminder Set'),
        content: Text('Your reminder has been set successfully.'),
        actions: <Widget>[
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

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDateTime = await showDatePicker(
      context: context,
      initialDate: selectedDateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDateTime != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(selectedDateTime),
      );
      if (pickedTime != null) {
        setState(() {
          selectedDateTime = DateTime(
            pickedDateTime.year,
            pickedDateTime.month,
            pickedDateTime.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isEditing = false;
        });
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Set Reminder'),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'images/logo.png',
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  const Text(
                    'Hello',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'Set a Reminder',
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isEditing = true;
                      });
                    },
                    child: IgnorePointer(
                      ignoring: !isEditing,
                      child: TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: 'Reminder Name',
                          enabled: isEditing,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isEditing = false;
                      },
                    );},
                    child: IgnorePointer(
                      ignoring: !isEditing,
                      child: TextField(
                        controller: descriptionController,
                        decoration: InputDecoration(
                          labelText: 'Reminder Description',
                          enabled: isEditing,
                        ),
                      ),
                    ),
                  ),
  
                  ElevatedButton(
                    onPressed: () => _selectDateTime(context),
                    child: const Text('Select Date and Time'),
                  ),
                  SizedBox(height: 20,),
                  Text(
                    "${selectedDateTime.toLocal()}".split(' ')[0],
                    style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${TimeOfDay.fromDateTime(selectedDateTime).format(context)}",
                    style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                 const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                     const Text('Daily Reminder'),
                      Switch(
                        value: isDaily,
                        onChanged: (value) {
                          setState(() {
                            isDaily = value;
                          });
                        },
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () => scheduleReminder(isDaily, selectedDateTime),
                    child: Text('Set Reminder'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
