import 'package:flutter/material.dart';
import 'package:ran_app/questions/endpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';


var answer11 = '';
DateTime? selectedWakeUp = DateTime.now();

class EleventhQuestion extends StatefulWidget {
  @override
  EleventhQuestionState createState() => EleventhQuestionState();
}

class EleventhQuestionState extends State<EleventhQuestion> {
  DateTime curr = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Start Time Selection'),
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
                child: Text("When do you want to start your first task?"),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: ElevatedButton(
                onPressed: () async {
                  //final DateTime? selectedTime = await showCupertinoTimePicker(context);
                  selectedWakeUp = await showCupertinoTimePicker(context);
                  if (selectedWakeUp != null) {
                    setState(() {
                      answer11 = DateFormat('hh:mm a').format(selectedWakeUp!);
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
              child: Text(answer11),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: ElevatedButton(
                onPressed: () {
                  _navigateToHomePage(context);
                },
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
              setState(() {
                curr = newDateTime;
              });
              selectedDateTime = newDateTime;
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
