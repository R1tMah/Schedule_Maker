import 'package:flutter/material.dart';
import 'package:ran_app/questions/question9.dart';

class EighthQuestion extends StatefulWidget {
  @override
  EighthQuestionState createState() => EighthQuestionState();
}// A State created by StatefulWidget to be displayed on screen.

class EighthQuestionState extends State<EighthQuestion> {
  String? _selectedOption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Question 8'),
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
                child: Text("Do you find that you are more motivated by external rewards or intrinsic satisfaction?"),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: ElevatedButton(
                child: Text('Intrinsic Satisfaction'),
                onPressed: () {
                  setState(() {
                    _selectedOption = 'Very Frequently';
                  });
                  _navigateToNinthPage(context);
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: ElevatedButton(
                child: Text('Extrinsic Rewards'),
                onPressed: () {
                  setState(() {
                    _selectedOption = 'Frequently';
                  });
                  _navigateToNinthPage(context);
                },
              ),
            ),
          ),

        ],
      ),
    );
  }



  void _navigateToNinthPage(BuildContext context) {
    Future.delayed(Duration(milliseconds: 500), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => NinthQuestion(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    });
  }
}
