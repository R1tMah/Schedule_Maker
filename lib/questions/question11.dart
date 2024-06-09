import 'package:flutter/material.dart';
import 'package:ran_app/questions/endpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

var answer11 = '';
var firstTime = 1;
DateTime curr = DateTime.now();
class EleventhQuestion extends StatefulWidget {
  @override
  EleventhQuestionState createState() => EleventhQuestionState();
}// A State created by StatefulWidget to be displayed on screen.

class EleventhQuestionState extends State<EleventhQuestion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Question 11'),
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
                child: Text("When do you want to start your day?"),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child:  ElevatedButton(
                onPressed: () async {
                  final DateTime? selectedTime = await showCupertinoTimePicker(context);
                  if (selectedTime != null) {
                    setState(() {
                      answer11 = DateFormat('hh:mm a').format(selectedTime);
                    });
                  }
                },
                child: Text('Select Reminder Time'),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Text("" + answer11),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child:  ElevatedButton(
                onPressed: (){_navigateToHomePage(context);},
                child: Text('Next'),
              ),
            ),
          ),
        ],
      ),
    );
  }




  Future<DateTime?> showCupertinoTimePicker(BuildContext context) async {
    DateTime? selectedDateTime;
    await showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          height: 250,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.time,
            initialDateTime: curr,
            use24hFormat: false,
            onDateTimeChanged: (DateTime newDateTime) {

              selectedDateTime = newDateTime;
              curr = newDateTime;
            },
          ),
        );
      },
    );
    return selectedDateTime;
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
