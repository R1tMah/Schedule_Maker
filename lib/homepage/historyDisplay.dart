import 'package:flutter/material.dart';
import 'package:time_planner/time_planner.dart';
import 'package:intl/intl.dart';
import 'package:ran_app/homepage/history.dart';

class HistoryDisplay extends StatefulWidget {
  @override
  HistoryDisplayState createState() => HistoryDisplayState();
}

class HistoryDisplayState extends State<HistoryDisplay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context); // Go back to the previous page
          },
        ),
        backgroundColor: Colors.teal[900], // Customize the app bar color if needed
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 8,
            child: TimePlanner(
              startHour: 0,
              endHour: 23,
              headers: [
                TimePlannerTitle(
                  date: DateFormat('MM-dd-yyyy').format(DateTime.now()),
                  title: DateFormat('EEEE').format(DateTime.now()), /// e.g Thursday,
                ),
              ],
              style: TimePlannerStyle(
                backgroundColor: Colors.white,
                cellHeight: 100,
                cellWidth: 340,
                dividerColor: Colors.black,
                showScrollBar: true,
                horizontalTaskPadding: 5,
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              tasks: finaltasks,
            ),
          ),
        ],
      ),
    );
  }
}