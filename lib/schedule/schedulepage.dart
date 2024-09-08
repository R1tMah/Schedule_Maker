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
}// A State created by StatefulWidget to be displayed on screen.




  class SchedulePage extends  State<ScheduleHomePageState> {
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


      schedule = Schedule(
        scheduleDate: DateTime.now(),
        studyMethod: prefs.getString('selectedWork') ?? 'Interleaved Practice',
        // Add a default value if needed
        workingtime: int.parse(TimePrefs.getString('selectedSplit')!.substring(0, 2)),
      );

      _initializeSchedule();

      /*
    if (schedule.TimeAfterTwelve()) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Invalid Time"),
            content: Text(
                "You have way too many tasks in your schedule right now. Either modify your tasks or change your wakeUpTime"),
            actions: <Widget>[
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
    */

      _populateTimePlannerTasks();
      _checkAndResetSchedule();
    }
  String printInfo(Task task){
    DateTime? start = schedule.taskTimeMap[task]?.start;
    DateTime? end = schedule.taskTimeMap[task]?.end;
    if(task.getLabel() != "Break") {
      return "Task " + task.getLabel() + ": " +
          DateFormat('HH:mm').format(start!) + "-" +
          DateFormat('HH:mm').format(end!);
    }else{
      return  "Break from" + ": " +
          DateFormat('HH:mm').format(start!) + "-" +
          DateFormat('HH:mm').format(end!);
    }
  }
  void _addTaskTimeObject(BuildContext context, Task currTask) {
    Color color;
    if(currTask.getLabel() == "Break"){
      color = Colors.blue;
    }else if(currTask.getArea() == "Study") {
      color = Colors.green;
    }
    else if(currTask.getArea() == "Food"){
      color = Colors.yellow;
    }
    else {
      color = Colors.red;
    }
    setState(() {
      int? hour = schedule.taskTimeMap[currTask]?.start.hour;
      int? minutes = schedule.taskTimeMap[currTask]?.start.minute;
      finaltasks.add(
        TimePlannerTask(
          color: color,
          dateTime: TimePlannerDateTime(
            day: 0,
            hour: hour!,
            minutes: minutes!,),
          minutesDuration:  currTask.duration,
          daysDuration: 1,
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(printInfo(currTask))));
          },
          child: Text(
            '${currTask.getLabel()}',
            style: TextStyle(color: Colors.grey[350], fontSize: 12),
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
    if (now.day != lastScheduleDate.day || now.month != lastScheduleDate.month || now.year != lastScheduleDate.year) {
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
    if(month < 10) {
      strMonth = '0${month}';
    } else {
      strMonth = '${month}';
    }


    String strDay = '';
    if(day < 10) {
      strDay = '0${day}';
    } else {
      strDay = '${day}';
    }


    String stringDate = "${year}${strMonth}${strDay}";
    int intDate = int.parse(stringDate);




    print("This is what pp is in the task tim map right now. \n");
    for(Task t in schedule.taskTimeMap.keys){
      print("Task " + t.getLabel() + " is scheduled for ${schedule.taskTimeMap[t]}\n" );
    }
    print("_________________________________________________________________________\n");




    String content = jsonEncode(mapToJson(schedule.taskTimeMap));
    await _dbService.deleteSchedule(intDate);
    await _dbService.addSchedule(intDate, content);


    setState(() {
      finaltasks.clear();
      taskList.clear();// Clear the current tasks
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
                    cellHeight: 100,
                    // default value for width is 90
                    cellWidth: 500,


                    dividerColor: Colors.black,
                    showScrollBar: true,
                    horizontalTaskPadding: 5,
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                  ),
                  // List of task will be show on the time planner
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
