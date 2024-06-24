import 'package:flutter/material.dart';
import 'package:ran_app/questions/question6.dart';

var answer5 = '';

class FifthQuestion extends StatefulWidget {
  @override
  FifthQuestionState createState() => FifthQuestionState();
}

class FifthQuestionState extends State<FifthQuestion> {
  double _currentSliderValue = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Question 5'),
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
                  "How easily on a scale of 1-10 do you get bored when engaging in repetitive or monotonous activities?",
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
          Slider(
            value: _currentSliderValue,
            min: 1,
            max: 10,
            divisions: 9,
            label: _currentSliderValue.round().toString(),
            onChanged: (double value) {
              setState(() {
                _currentSliderValue = value;
              });
            },
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: ElevatedButton(
                child: Text('Done'),
                onPressed: () {
                  setState(() {
                    answer5 = _currentSliderValue.toString();
                  });
                  _navigateToSixthPage(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToSixthPage(BuildContext context) {
    Future.delayed(Duration(milliseconds: 500), () {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => SixthQuestion(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    });
  }
}
