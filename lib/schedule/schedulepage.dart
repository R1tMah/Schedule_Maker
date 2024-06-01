import 'package:flutter/material.dart';
import 'package:ran_app/homepage/name_input.dart';
import 'package:ran_app/schedule/taskpage.dart';
import 'package:time_planner/time_planner.dart';



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
              padding: EdgeInsets.all(1.0),
              child: Center(
                child: Text( 'Hello, ' + name + ', Schedule Page',style: TextStyle(color: Colors.white),)
              )
            )
          ),
          Expanded(
            child:TimePlanner(
              // time will be start at this hour on table
              startHour: 6,
              // time will be end at this hour on table
              endHour: 23,
              // each header is a column and a day
              headers: [
                TimePlannerTitle(
                  date: "3/10/2021",
                  title: "sunday",
                ),
              ],
              // List of task will be show on the time planner
            ),
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