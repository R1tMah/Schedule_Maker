import 'package:flutter/material.dart';
import 'package:ran_app/questions/question5.dart';

class FourthQuestion extends StatefulWidget {
  @override
  FourthQuestionState createState() => FourthQuestionState();
}// A State created by StatefulWidget to be displayed on screen.

class FourthQuestionState extends State<FourthQuestion> {
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
                child: Text("Motivation Question 1"),
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
                  _navigateToFifthPage(context);
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
                  _navigateToFifthPage(context);
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
                  _navigateToFifthPage(context);
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
                  _navigateToFifthPage(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }



  void _navigateToFifthPage(BuildContext context) {
    Future.delayed(Duration(milliseconds: 500), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => FifthQuestion(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    });
  }
}
