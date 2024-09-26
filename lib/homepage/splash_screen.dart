import 'package:flutter/material.dart';
import 'dart:async'; // For adding a timer to the splash screen

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      // Navigate to home screen after 3 seconds
      Navigator.of(context).pushReplacementNamed('/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green, // Set the background color
      body: Center(
        child: Image.asset('assets/images/diddy.jpeg'), // Your splash image
      ),
    );
  }
}
