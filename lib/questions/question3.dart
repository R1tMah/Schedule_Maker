import 'package:flutter/material.dart';
import 'package:ran_app/questions/question4.dart';

var answer3 = '';

class ThirdQuestion extends StatefulWidget {
  @override
  ThirdQuestionState createState() => ThirdQuestionState();
}// A State created by StatefulWidget to be displayed on screen.

class ThirdQuestionState extends State<ThirdQuestion> {
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
                    answer3 = 'Very Often';
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
                    answer3 = 'Often';
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
                    answer3 = 'Sometimes';
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
                    answer3 = 'Not Often';
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
                    answer3 = 'Rarely';
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
      Navigator.push(
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
