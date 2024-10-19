import 'package:flutter/material.dart';
import 'package:ran_app/homepage/homepage.dart';
import 'package:ran_app/homepage/name_input.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ran_app/homepage/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool firstTime = true;
  bool _isSplashVisible = true;

  @override
  void initState() {
    super.initState();
    _startSplashScreen();
    _checkFirstTime();
  }

  // Show the splash screen for 3 seconds before proceeding
  Future<void> _startSplashScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    setState(() {
      _isSplashVisible = false; // Hide the splash screen after 3 seconds
    });
  }

  Future<void> _checkFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    bool isFirstTime = prefs.getBool('firstTime') ?? true;

    setState(() {
      firstTime = isFirstTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.teal),
        scaffoldBackgroundColor: Colors.teal[900],
        useMaterial3: true,
      ),
      home: _isSplashVisible
          ? SplashScreen() // Show splash screen if it's visible
          : firstTime
          ? const NameInputPage()
          : const MyHomePage(),
    );
  }
}
