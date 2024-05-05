import 'package:flutter/material.dart';
import 'package:ran_app/questions/question8.dart';

class SeventhQuestion extends StatefulWidget {
  @override
  SeventhQuestionState createState() => SeventhQuestionState();
}// A State created by StatefulWidget to be displayed on screen.

class SeventhQuestionState extends State<SeventhQuestion> {
  String? _selectedOption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Question 7'),
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
                child: Text("How frequently do you experience mind wandering or daydreaming during daily activities"),
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
                    _selectedOption = 'Very Frequently';
                  });
                  _navigateToEighthPage(context);
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
                    _selectedOption = 'Frequently';
                  });
                  _navigateToEighthPage(context);
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
                  _navigateToEighthPage(context);
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
                    _selectedOption = 'Not Frequently';
                  });
                  _navigateToEighthPage(context);
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
                  _navigateToEighthPage(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }



  void _navigateToEighthPage(BuildContext context) {
    Future.delayed(Duration(milliseconds: 500), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => EighthQuestion(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    });
  }
}
