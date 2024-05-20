import 'package:flutter/material.dart';
import 'package:ran_app/homepage/name_input.dart';
import 'package:ran_app/schedule/taskpage.dart';


class ScheduleHomePageState extends StatefulWidget {
  @override
  SchedulePage createState() => SchedulePage();
}// A State created by StatefulWidget to be displayed on screen.


class SchedulePage extends  State<ScheduleHomePageState>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget> [
          Expanded(
            flex: 5,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Center(
                child: Text( 'Hello, ' + name + ' pp, Schedule Page',style: TextStyle(color: Colors.white),)
              )
            )
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: ElevatedButton(
                child: Text('Enter Tasks'),
                onPressed: () {
                    setState(() {
                      _navigateToTaskPage(context);
                    });
                },
              ),
            ),
          ),
        ]
      )
    );
  }
  void _navigateToTaskPage(BuildContext context) {
    Future.delayed(Duration(milliseconds: 500), () {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => TaskPage(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    });
  }
}