import 'package:flutter/material.dart';
import 'package:ran_app/questions/question7.dart';

class SixthQuestion extends StatefulWidget {
  @override
  SixthQuestionState createState() => SixthQuestionState();
}// A State created by StatefulWidget to be displayed on screen.

class SixthQuestionState extends State<SixthQuestion> {
  String? _selectedOption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Question 6'),
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
                child: Text("Are you often preoccupied with 'what-if' scenarios or potential negative outcomes?"),
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
                  _navigateToSeventhPage(context);
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
                  _navigateToSeventhPage(context);
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
                  _navigateToSeventhPage(context);
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
                  _navigateToSeventhPage(context);
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
                  _navigateToSeventhPage(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }



  void _navigateToSeventhPage(BuildContext context) {
    Future.delayed(Duration(milliseconds: 500), () {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => SeventhQuestion(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    });
  }
}