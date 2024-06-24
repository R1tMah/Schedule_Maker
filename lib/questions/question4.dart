import 'package:flutter/material.dart';
import 'package:ran_app/questions/question5.dart';

var answer4 = '';

class FourthQuestion extends StatefulWidget {
  @override
  FourthQuestionState createState() => FourthQuestionState();
}

class FourthQuestionState extends State<FourthQuestion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Question 4'),
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
                  "Do you find that your motivation varies depending on the type or nature of the task",
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
                child: Text('Yes'),
                onPressed: () {
                  setState(() {
                    answer4 = 'Yes';
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
                child: Text('No'),
                onPressed: () {
                  setState(() {
                    answer4 = 'No';
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
      Navigator.push(
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
