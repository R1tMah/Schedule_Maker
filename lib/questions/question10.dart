import 'package:flutter/material.dart';
import 'package:ran_app/questions/endpage.dart';

var answer10 = '';

class TenthQuestion extends StatefulWidget {
  @override
  TenthQuestionState createState() => TenthQuestionState();
}// A State created by StatefulWidget to be displayed on screen.

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
                child: Text("Are you easily distracted by external stimuli, such as noise or movement?"),
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
                  _navigateToHomePage(context);
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
                  _navigateToHomePage(context);
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
}
