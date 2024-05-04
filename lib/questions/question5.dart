import 'package:flutter/material.dart';
import 'package:ran_app/questions/question6.dart';

class FifthQuestion extends StatefulWidget {
  @override
  FifthQuestionState createState() => FifthQuestionState();
}// A State created by StatefulWidget to be displayed on screen.

class FifthQuestionState extends State<FifthQuestion> {
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
                child: Text("Motivation Question 2"),
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
                  _navigateToSixthPage(context);
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
                  _navigateToSixthPage(context);
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
                  _navigateToSixthPage(context);
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
                  _navigateToSixthPage(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }



  void _navigateToSixthPage(BuildContext context) {
    Future.delayed(Duration(milliseconds: 500), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => SixthQuestion(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    });
  }
}