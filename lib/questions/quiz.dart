import 'package:flutter/material.dart';
import 'package:ran_app/questions/endpage.dart';
import 'package:ran_app/questions/question2.dart';
import 'package:ran_app/schedule/schedulepage.dart';
import 'package:ran_app/questions/question11.dart';

var answer1 = '';

class QuizApp extends StatefulWidget {
  @override
  _QuizAppState createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Question 1'),
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
                  "How frequently do you check your phone notifications throughout the day?",
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
                child: Text('Skip to end'),
                onPressed: () {
                  setState(() {
                      selectedWakeUp = DateTime.now();
                  });
                  _navigateToHomePage(context);
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: ElevatedButton(
                child: Text('Very Frequently'),
                onPressed: () {
                  setState(() {
                    answer1 = 'Very Frequently';
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
                child: Text('Frequently'),
                onPressed: () {
                  setState(() {
                    answer1 = 'Frequently';
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
                child: Text('Sometimes'),
                onPressed: () {
                  setState(() {
                    answer1 = 'Sometimes';
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
                child: Text('Not Frequently'),
                onPressed: () {
                  setState(() {
                    answer1 = 'Not Frequently';
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
                child: Text('Rarely'),
                onPressed: () {
                  setState(() {
                    answer1 = 'Rarely';
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

  void _navigateToHomePage(BuildContext context) {
    Future.delayed(Duration(milliseconds: 500), () {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => EndPage(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    });
  }

  void _navigateToSecondPage(BuildContext context) {
    Future.delayed(Duration(milliseconds: 500), () {
      Navigator.push(
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
