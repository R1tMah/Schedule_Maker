import 'package:flutter/material.dart';
import 'package:ran_app/questions/question10.dart';

class NinthQuestion extends StatefulWidget {
  @override
  NinthQuestionState createState() => NinthQuestionState();
}// A State created by StatefulWidget to be displayed on screen.

class NinthQuestionState extends State<NinthQuestion> {
  String? _selectedOption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Question 9'),
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
                child: Text("Do you often find it difficult to quiet your mind or relax?"),
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
                  _navigateToTenthPage(context);
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
                  _navigateToTenthPage(context);
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
                  _navigateToTenthPage(context);
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
                  _navigateToTenthPage(context);
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
                  _navigateToTenthPage(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }



  void _navigateToTenthPage(BuildContext context) {
    Future.delayed(Duration(milliseconds: 500), () {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => TenthQuestion(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    });
  }
}
