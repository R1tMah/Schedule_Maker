import 'package:flutter/material.dart';
import 'package:ran_app/homepage/name_input.dart';
import 'package:ran_app/schedule/taskpage.dart';
import 'package:time_planner/time_planner.dart';
import 'package:intl/intl.dart';
import 'package:ran_app/schedule/schedule.dart';
import 'package:ran_app/schedule/task.dart';
import 'dart:convert';
import 'package:ran_app/databaseService.dart';
import 'package:ran_app/settings/change_work_page.dart';
import 'package:ran_app/questions/endpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

late Schedule schedule;
DateTime lastScheduleDate = DateTime.now();

class ScheduleHomePageState extends StatefulWidget {
  final List<Task> tasks; // Receive the list of tasks from previous page

  ScheduleHomePageState({required this.tasks});
  @override
  SchedulePage createState() => SchedulePage();
}

class SchedulePage extends State<ScheduleHomePageState> {
  List<TimePlannerTask> finaltasks = [];
  late SharedPreferences prefs;
  late SharedPreferences TimePrefs;

  @override
  void initState() {
    super.initState();
    _initializeSchedulePage();
  }

  Future<void> _initializeSchedulePage() async {
    prefs = await SharedPreferences.getInstance();
    TimePrefs = await SharedPreferences.getInstance();
    if(TimePrefs.getString('selectedSplit') == null){
      TimePrefs.setString('selectedSplit', "30");
    }
    schedule = Schedule(
      scheduleDate: DateTime.now(),
      studyMethod: prefs.getString('selectedWork') ?? 'Interleaved Practice',
      workingtime: int.parse(TimePrefs.getString('selectedSplit')!.substring(0, 2)),
    );

    _initializeSchedule();

    _populateTimePlannerTasks();
    _checkAndResetSchedule();
  }

  String printInfo(Task task) {
    DateTime? start = schedule.taskTimeMap[task]?.start;
    DateTime? end = schedule.taskTimeMap[task]?.end;
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
      int? hour = schedule.taskTimeMap[currTask]?.start.hour;
      int? minutes = schedule.taskTimeMap[currTask]?.start.minute;

      // Get the formatted start and end time in 12-hour format with AM/PM
      String startTime =
      DateFormat('h:mm a').format(schedule.taskTimeMap[currTask]!.start);
      String endTime =
      DateFormat('h:mm a').format(schedule.taskTimeMap[currTask]!.end);

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
          // Modify the child widget to include task name and time
          child: Column(
            children: [
              Text(
                '${currTask.getLabel()}',
                style: TextStyle(color: Colors.grey[350], fontSize: 12),
              ),
              Text(
                '$startTime - $endTime', // Display the time next to the task name in 12-hour format
                style: TextStyle(color: Colors.grey[350], fontSize: 10),
              ),
            ],
          ),
        ),
      );
    });
  }

  void _populateTimePlannerTasks() {
    schedule.scheduleTime();
    schedule.taskTimeMap.forEach((task, timeSlot) {
      print("Adding ${task.getLabel()} to the final tasks.");
      _addTaskTimeObject(context, task);
    });
  }

  void _initializeSchedule() {
    schedule.setTasks(taskList);
    schedule.initializeTasks();
  }

  void _checkAndResetSchedule() {
    DateTime now = DateTime.now();
    if (now.day != lastScheduleDate.day ||
        now.month != lastScheduleDate.month ||
        now.year != lastScheduleDate.year) {
      // Reset the schedule
      _resetSchedule();
    }
    lastScheduleDate = now;
  }

  // Method to reset the schedule
  void _resetSchedule() async {
    final DatabaseService _dbService = DatabaseService.instance;

    int month = lastScheduleDate.month;
    int day = lastScheduleDate.day;
    int year = lastScheduleDate.year;

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
    int intDate = int.parse(stringDate);

    print("This is what pp is in the task tim map right now. \n");
    for (Task t in schedule.taskTimeMap.keys) {
      print("Task " + t.getLabel() + " is scheduled for ${schedule.taskTimeMap[t]}\n");
    }
    print("_________________________________________________________________________\n");

    String content = jsonEncode(mapToJson(schedule.taskTimeMap));
    await _dbService.deleteSchedule(intDate);
    await _dbService.addSchedule(intDate, content);

    setState(() {
      finaltasks.clear();
      taskList.clear(); // Clear the current tasks
      schedule = Schedule(
        scheduleDate: DateTime.now(),
        studyMethod: 'Interleaved Practice',
        workingtime: 60,
      );
    });
  }

  Map<String, String> dateTimeRangeToJson(DateTimeRange range) {
    return {
      'start': range.start.toIso8601String(),
      'end': range.end.toIso8601String(),
    };
  }

  Map<String, dynamic> mapToJson(Map<Task, DateTimeRange> map) {
    return map.map((task, dateTimeRange) =>
        MapEntry(jsonEncode(task.toJson()), dateTimeRangeToJson(dateTimeRange)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                cellHeight: 150,
                cellWidth: 340,
                dividerColor: Colors.black,
                showScrollBar: true,
                horizontalTaskPadding: 5,
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              tasks: finaltasks,
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
        ],
      ),
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
