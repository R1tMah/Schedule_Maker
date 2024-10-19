import 'package:flutter/material.dart';
import 'package:ran_app/homepage/homepage.dart';
import 'package:ran_app/questions/quiz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:notification_permissions/notification_permissions.dart';

var notificationPermission = false;

class NameInputPage extends StatefulWidget {
  const NameInputPage({Key? key}) : super(key: key);

  @override
  _NameInputPageState createState() => _NameInputPageState();
}

class _NameInputPageState extends State<NameInputPage> {
  TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _requestNotificationPermission() async {
    // Request the permission
    var permissionStatus = await NotificationPermissions.requestNotificationPermissions();
    if (permissionStatus == PermissionStatus.granted) {
      notificationPermission = true;
      print("Notification permission granted");
    } else {
      print("Notification permission denied");
    }
  }

  Future<void> _setFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('firstTime', false); // Mark that the user has completed the first-time input
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[900],
        title: const Text('Enter Your Name'),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              style: TextStyle(color: Colors.white),
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {

                await _requestNotificationPermission();

                print(notificationPermission);

                await _setFirstTime();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => QuizApp()),
                );
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
