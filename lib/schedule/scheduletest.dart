import 'package:flutter/material.dart';
import 'package:ran_app/schedule/schedule.dart';
import 'package:ran_app/schedule/task.dart';
import 'package:time_planner/time_planner.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:ran_app/databaseService.dart';

void main() {
  runApp(MyApp());
}

DateTime lastScheduleDate = DateTime.now().subtract(Duration(days: 1));
List<Task> tasks = [];

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ScheduleTestPage(),
    );
  }
}

class ScheduleTestPage extends StatefulWidget {
  @override
  _ScheduleTestPageState createState() => _ScheduleTestPageState();
}

class _ScheduleTestPageState extends State<ScheduleTestPage> {
  List<TimePlannerTask> finaltasks = [];


  Schedule schedule = Schedule(
    scheduleDate: DateTime.now(),
    studyMethod: 'Interleaved Practice',
    workingtime: 60,
  );

  @override
  void initState() {
    super.initState();
    _initializeSchedule();
    schedule.scheduleTime();
    _checkAndResetSchedule();
    schedule.taskTimeMap.forEach((task, timeSlot) {
      print("adding " + "${task.getLabel()} to the final tasks right now");
      _addTaskTimeObject(context, task);
    });
  }


  void _addTaskTimeObject(BuildContext context, Task currTask) {

    setState(() {
      int? hour = schedule.taskTimeMap[currTask]?.start.hour;
      int? minutes = schedule.taskTimeMap[currTask]?.start.minute;
      finaltasks.add(
        TimePlannerTask(
          color: Colors.red,
          dateTime: TimePlannerDateTime(
            day: 0,
            hour: hour!,
            minutes: minutes!,),
          minutesDuration:  currTask.duration,
          daysDuration: 1,
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('You click on time planner object')));
          },
          child: Text(
            '${currTask.getLabel()}',
            style: TextStyle(color: Colors.grey[350], fontSize: 12),
          ),
        ),
      );
    });
  }
  void _initializeSchedule() {
    tasks = [
      Task(
        area: 'Other',
        label: 'Go to the Gym',
        duration: 120,
        difficultyOfTask: 'Easy',
        importanceLevel: 3,
      ),
      Task(
        area: 'Other',
        label: 'Get Groceries',
        duration: 120,
        difficultyOfTask: 'Easy',
        importanceLevel: 3,
      ),
      Task(
        area: 'Other',
        label: 'Do drugs',
        duration: 120,
        difficultyOfTask: 'Easy',
        importanceLevel: 3,
      ),
      Task(
        area: 'Other',
        label: 'Go for a run',
        duration: 30,
        difficultyOfTask: 'Easy',
        importanceLevel: 3,
      ),
      Task(
        area: 'Study',
        label: 'Math',
        duration: 90,
        difficultyOfTask: 'Easy',
        importanceLevel: 1,
      ),
      Task(
        area: 'Study',
        label: 'stuff',
        duration: 30,
        difficultyOfTask: 'Easy',
        importanceLevel: 2,
      ),
      Task(
        area: 'Study',
        label: 'Science',
        duration: 120,
        difficultyOfTask: 'Medium',
        importanceLevel: 3,
      ),
      Task(
        area: 'Study',
        label: 'Email',
        duration: 30,
        difficultyOfTask: 'Easy',
        importanceLevel: 4,
      ),
      Task(
        area: 'Study',
        label: 'King',
        duration: 15,
        difficultyOfTask: 'Easy',
        importanceLevel: 5,
      ),
      Task(
        area: 'Study',
        label: 'Project',
        duration: 15,
        difficultyOfTask: 'Hard',
        importanceLevel: 2,
      ),
      Task(
        area: 'Study',
        label: 'Meeting',
        duration: 75,
        fixedTime: DateTime.now().add(const Duration(minutes: 240)),
        difficultyOfTask: 'Hard',
        importanceLevel: 3,
      ),

    ];
    schedule.setTasks(tasks);
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
      tasks.clear();// Clear the current tasks
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
                child: ListView(
                  children: schedule.taskTimeMap.entries.map((entry) {
                    Task task = entry.key;
                    DateTimeRange dateTimeRange = entry.value;
                    return Card(
                      child: ListTile(
                        title: Text(task.getLabel()),
                        subtitle: Text(
                            'Scheduled from ${DateFormat('hh:mm a').format(dateTimeRange.start)} to ${DateFormat('hh:mm a').format(dateTimeRange.end)}'),
                      ),
                    );
                  }).toList(),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: ElevatedButton(
                    child: Text('Enter Tasks'),
                    onPressed: () {
                      setState(() {});
                    },
                  ),
                ),
              ),
            ]
            /*
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

                      });
                    },
                  ),
                ),


              ),

            ]

             */
        )
    );
  }
}
