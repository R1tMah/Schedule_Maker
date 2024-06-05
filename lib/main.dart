import 'package:flutter/material.dart';
import 'package:ran_app/homepage/homepage.dart';
import 'package:ran_app/homepage/name_input.dart';

/*
COMMENTS FOR CHANGE:
ADDED A QUESTION FOR THE QUIZ BUT NEED TO FIGURE OUT HOW TO STORE THE DIFFERENT
QUESTIONS WITHIN THE APP AND NEED TO FIND A WAY TO CHANGE THE SCREEN AND SEE IF QUESTIONS ARE RIGHT
*/
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  //Color myPrimaryColor = Colors.blue; // Define a primary color swatch
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(// Define a primary color swatch
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.teal),
        scaffoldBackgroundColor: Colors.teal[900],
        useMaterial3: true,
      ),
      home: firstTime == 1 ? const NameInputPage() : const MyHomePage(),
    );
  }
}


















