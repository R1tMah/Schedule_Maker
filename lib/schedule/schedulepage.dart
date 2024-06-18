import 'package:flutter/material.dart';
import 'package:ran_app/homepage/name_input.dart';
import 'package:ran_app/schedule/taskpage.dart';
import 'package:time_planner/time_planner.dart';
import 'package:intl/intl.dart';


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
          crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget> [

          Expanded(
            flex: 8,
            child:TimePlanner(
              // time will be start at this hour on table
              startHour: 0,
              // time will be end at this hour on table
              endHour: 23,
              // each header is a column and a day
              headers: [
                TimePlannerTitle(
                  date: DateFormat('MM-dd-yyyy').format(DateTime.now()),
                  title: DateFormat('EEEE').format(DateTime.now()), /// e.g Thursday,
                ),
              ],
              style: TimePlannerStyle(
                backgroundColor: Colors.white,
                // default value for height is 80
                cellHeight: 60,
                // default value for width is 90
                cellWidth: 200,

                dividerColor: Colors.black,
                showScrollBar: true,
                horizontalTaskPadding: 5,
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              // List of task will be show on the time planner
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(20.0),
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