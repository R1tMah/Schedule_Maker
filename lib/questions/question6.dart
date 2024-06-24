import 'package:flutter/material.dart';
import 'package:ran_app/questions/question7.dart';

var answer6 = '';

class SixthQuestion extends StatefulWidget {
  @override
  SixthQuestionState createState() => SixthQuestionState();
}

class SixthQuestionState extends State<SixthQuestion> {
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
                child: Text(
                  "Are you often preoccupied with 'what-if' scenarios or potential negative outcomes?",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
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
                    answer6 = 'Very Often';
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
                    answer6 = 'Often';
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
                    answer6 = 'Sometimes';
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
                    answer6 = 'Not Often';
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
                    answer6 = 'Rarely';
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
