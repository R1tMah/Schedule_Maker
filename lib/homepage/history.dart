import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:convert';
import 'package:ran_app/databaseService.dart';
import 'package:ran_app/schedule/task.dart';
import 'package:time_planner/time_planner.dart';
import 'package:ran_app/homepage/historyDisplay.dart';
import 'package:intl/intl.dart';

List<TimePlannerTask> finaltasks = [];
Map<Task, DateTimeRange> retrievedMap = {};

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFE6D4B9), // Beige color
              Color(0xFF004D40), // Dark teal color
            ],
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButton<CalendarFormat>(
                value: _calendarFormat,
                items: [
                  DropdownMenuItem(
                    child: Text('Month'),
                    value: CalendarFormat.month,
                  ),
                  DropdownMenuItem(
                    child: Text('Two Weeks'),
                    value: CalendarFormat.twoWeeks,
                  ),
                  DropdownMenuItem(
                    child: Text('Week'),
                    value: CalendarFormat.week,
                  ),
                ],
                onChanged: (format) {
                  setState(() {
                    _calendarFormat = format!;
                  });
                },
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TableCalendar(
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  focusedDay: _focusedDay,
                  calendarFormat: _calendarFormat,
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay =
                          focusedDay; // update `_focusedDay` here as well
                    });
                    _getData(_selectedDay);
                  },
                  onPageChanged: (focusedDay) {
                    _focusedDay = focusedDay;
                  },
                  calendarStyle: CalendarStyle(
                    defaultTextStyle: TextStyle(color: Colors.black87),
                    // Default day text color
                    weekendTextStyle: TextStyle(color: Colors.black87),
                    // Weekend day text color
                    selectedTextStyle: TextStyle(color: Colors.black),
                    // Selected day text color
                    todayTextStyle: TextStyle(color: Colors.black),
                    // Today's day text color
                    todayDecoration: BoxDecoration(
                      color: Colors.white, // Background color for today
                      shape: BoxShape.circle,
                    ),
                    selectedDecoration: BoxDecoration(
                      color: Colors.blue, // Background color for selected day
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.blue, width: 2),
                    ),
                  ),
                  headerStyle: HeaderStyle(
                    titleTextStyle: TextStyle(
                        color: Colors.black, fontSize: 16),
                    leftChevronIcon: Icon(
                      Icons.chevron_left,
                      color: Colors.black,
                    ),
                    rightChevronIcon: Icon(
                      Icons.chevron_right,
                      color: Colors.black,
                    ),
                    formatButtonVisible: false, // Hide the default format button
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  DateTimeRange dateTimeRangeFromJson(Map<String, String> json) {
    return DateTimeRange(
      start: DateTime.parse(json['start']!),
      end: DateTime.parse(json['end']!),
    );
  }

  void _getData(DateTime date) async {
    finaltasks = [];
    retrievedMap = {};
    final DatabaseService _dbService = DatabaseService.instance;

    int month = date.month;
    int day = date.day;
    int year = date.year;

    String strMonth = '';
    if (month < 10) {
      strMonth = '0${month}';
    } else {
      strMonth = '${month}';
    }

    String strDay = '';
    if (day < 10) {
      strDay = '0${day}';
    } else {
      strDay = '${day}';
    }

    String stringDate = "${year}${strMonth}${strDay}";


    int inputInt = int.parse(stringDate);
    String? data = await _dbService.getSchedule(inputInt);
    if (data != null) {
      if (data != 'No data found for provided date') {
        Map<String, dynamic> jsonMap = jsonDecode(data);
        retrievedMap = jsonMap.map((taskJsonString, dateTimeRangeJson) {
          Map<String, dynamic> taskJson = jsonDecode(taskJsonString);
          Task task = Task.fromJson(taskJson);
          DateTimeRange range = dateTimeRangeFromJson(
              Map<String, String>.from(dateTimeRangeJson));
          return MapEntry(task, range);
        });
      } else {
        print("No schedule found");
        return;
      }
    }

    print("This is what is in the task tim map right now. \n");
    for (Task t in retrievedMap.keys) {
      print("Task " + t.getLabel() + " is scheduled for ${retrievedMap[t]}\n");
    }
    print(
        "_________________________________________________________________________\n");

    retrievedMap.forEach((task, timeSlot) {
      _addTaskTimeObject(context, task);
    });

    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => HistoryDisplay(),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
    );
  }

  void _addTaskTimeObject(BuildContext context, Task currTask) {
    Color color;
    if (currTask.getLabel() == "Break") {
      color = Colors.blue;
    } else if (currTask.getArea() == "Study") {
      color = Colors.green;
    } else if (currTask.getArea() == "Food") {
      color = Colors.yellow;
    } else {
      color = Colors.red;
    }

    setState(() {
      int? hour = retrievedMap[currTask]?.start.hour;
      int? minutes = retrievedMap[currTask]?.start.minute;

      // Get the formatted start and end time in 12-hour format with AM/PM
      String startTime =
      DateFormat('h:mm a').format(retrievedMap[currTask]!.start);
      String endTime =
      DateFormat('h:mm a').format(retrievedMap[currTask]!.end);

      finaltasks.add(
        TimePlannerTask(
          color: color,
          dateTime: TimePlannerDateTime(
            day: 0,
            hour: hour!,
            minutes: minutes!,
          ),
          minutesDuration: currTask.duration,
          daysDuration: 1,
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(printInfo(currTask)),
            ));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  '${currTask.getLabel()}',
                  style: TextStyle(
                    color: Colors.grey[350],
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              SizedBox(width: 4), // Space between task name and time
              Flexible(
                child: Text(
                  '$startTime - $endTime',
                  style: TextStyle(
                    color: Colors.grey[350],
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.right,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  String printInfo(Task task) {
    DateTime? start = retrievedMap[task]?.start;
    DateTime? end = retrievedMap[task]?.end;
    if (task.getLabel() != "Break") {
      return "Task " +
          task.getLabel() +
          ": " +
          DateFormat('h:mm a').format(start!) +
          "-" +
          DateFormat('h:mm a').format(end!);
    } else {
      return "Break from" +
          ": " +
          DateFormat('h:mm a').format(start!) +
          "-" +
          DateFormat('h:mm a').format(end!);
    }
  }
}
