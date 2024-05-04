import 'package:flutter/material.dart';
import 'package:ran_app/questions/question2.dart';
class QuizApp extends StatefulWidget {
  @override
  _QuizAppState createState() => _QuizAppState();
}// A State created by StatefulWidget to be displayed on screen.

class _QuizAppState extends State<QuizApp> {
  String? _selectedOption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Center(
                child: Text("I spend __ hours on my phone"),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: ElevatedButton(
                child: Text('1-3'),
                onPressed: () {
                  setState(() {
                    _selectedOption = '1-3';
                  });
                  _navigateToSecondPage(context);
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: ElevatedButton(
                child: Text('4-6'),
                onPressed: () {
                  setState(() {
                    _selectedOption = '4-6';
                  });
                  _navigateToSecondPage(context);
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: ElevatedButton(
                child: Text('7-9'),
                onPressed: () {
                  setState(() {
                    _selectedOption = 'High School Student';
                  });
                  _navigateToSecondPage(context);
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: ElevatedButton(
                child: Text('9+'),
                onPressed: () {
                  setState(() {
                    _selectedOption = 'Teacher';
                  });
                  _navigateToSecondPage(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }



  void _navigateToSecondPage(BuildContext context) {
    Future.delayed(Duration(milliseconds: 500), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => SecondQuestion(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    });
  }
}

