import 'package:flutter/material.dart';
import 'package:ran_app/questions/question4.dart';

class ThirdQuestion extends StatefulWidget {
  @override
  ThirdQuestionState createState() => ThirdQuestionState();
}// A State created by StatefulWidget to be displayed on screen.

class ThirdQuestionState extends State<ThirdQuestion> {
  String? _selectedOption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Question 3'),
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
                child: Text("How often do you find yourself procrastinating"),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: ElevatedButton(
                child: Text('Very Often'),
                onPressed: () {
                  setState(() {
                    _selectedOption = 'Very Often';
                  });
                  _navigateToFourthPage(context);
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: ElevatedButton(
                child: Text('Often'),
                onPressed: () {
                  setState(() {
                    _selectedOption = 'Often';
                  });
                  _navigateToFourthPage(context);
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: ElevatedButton(
                child: Text('Sometimes'),
                onPressed: () {
                  setState(() {
                    _selectedOption = 'Sometimes';
                  });
                  _navigateToFourthPage(context);
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: ElevatedButton(
                child: Text('Not Often'),
                onPressed: () {
                  setState(() {
                    _selectedOption = 'Not Often';
                  });
                  _navigateToFourthPage(context);
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: ElevatedButton(
                child: Text('Rarely'),
                onPressed: () {
                  setState(() {
                    _selectedOption = 'Rarely';
                  });
                  _navigateToFourthPage(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }



  void _navigateToFourthPage(BuildContext context) {
    Future.delayed(Duration(milliseconds: 500), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => FourthQuestion(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    });
  }
}
