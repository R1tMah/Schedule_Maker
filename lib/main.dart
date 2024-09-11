import 'package:flutter/material.dart';
import 'package:ran_app/homepage/homepage.dart';
import 'package:ran_app/homepage/name_input.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  @override
  void initState() {
    super.initState();
    _checkFirstTime();
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
      home: firstTime ? const NameInputPage() : const MyHomePage(),
    );
  }
}
