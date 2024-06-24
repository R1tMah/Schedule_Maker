import 'package:flutter/material.dart';
import 'package:ran_app/questions/question11.dart';

var answer10 = '';

class TenthQuestion extends StatefulWidget {
  @override
  TenthQuestionState createState() => TenthQuestionState();
}

class TenthQuestionState extends State<TenthQuestion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Question 10'),
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
                  "Are you easily distracted by external stimuli, such as noise or movement?",
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
                    answer10 = 'Yes';
                  });
                  _navigateToEleventhPage(context);
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
                    answer10 = 'No';
                  });
                  _navigateToEleventhPage(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToEleventhPage(BuildContext context) {
    Future.delayed(Duration(milliseconds: 500), () {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => EleventhQuestion(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    });
  }
}
