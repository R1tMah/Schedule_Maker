import 'package:flutter/material.dart';
import 'package:ran_app/questions/question3.dart';
class SecondQuestion extends StatefulWidget {
  @override
  SecondQuestionState createState() => SecondQuestionState();
}// A State created by StatefulWidget to be displayed on screen.

class SecondQuestionState extends State<SecondQuestion> {
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
                child: Text("Do you take breaks when you do work"),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: ElevatedButton(
                child: Text('College Student'),
                onPressed: () {
                  setState(() {
                    _selectedOption = 'College Student';
                  });
                  _navigateToThirdPage(context);
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: ElevatedButton(
                child: Text('College Student'),
                onPressed: () {
                  setState(() {
                    _selectedOption = 'College Student';
                  });
                  _navigateToThirdPage(context);
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: ElevatedButton(
                child: Text('High School Student'),
                onPressed: () {
                  setState(() {
                    _selectedOption = 'High School Student';
                  });
                  _navigateToThirdPage(context);
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: ElevatedButton(
                child: Text('Teacher'),
                onPressed: () {
                  setState(() {
                    _selectedOption = 'Teacher';
                  });
                  _navigateToThirdPage(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
  void _navigateToThirdPage(BuildContext context) {
    Future.delayed(Duration(milliseconds: 500), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => ThirdQuestion(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    });
  }
}
