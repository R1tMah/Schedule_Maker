import 'package:flutter/material.dart';
import 'package:ran_app/schedule/schedule.dart';
import 'package:ran_app/schedule/task.dart';

void main() {
  runApp(MyApp());
}

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
  Schedule schedule = Schedule(
    scheduleDate: DateTime.now(),
    studyMethod: 'Premack',
    workingMethod: '60',
  );

  @override
  void initState() {
    super.initState();
    _initializeSchedule();
    schedule.scheduleTime();
  }

  void _initializeSchedule() {
    List<Task> tasks = [
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
        importanceLevel: 1,
      ),
      Task(
        area: 'Study',
        label: 'Science',
        duration: 120,
        difficultyOfTask: 'Medium',
        importanceLevel: 2,
      ),
      Task(
        area: 'Study',
        label: 'Email',
        duration: 30,
        difficultyOfTask: 'Easy',
        importanceLevel: 1,
      ),
      Task(
        area: 'Study',
        label: 'King',
        duration: 15,
        difficultyOfTask: 'Easy',
        importanceLevel: 1,
      ),
      Task(
        area: 'Study',
        label: 'Project',
        duration: 180,
        difficultyOfTask: 'Hard',
        importanceLevel: 3,
      ),
      Task(
        area: 'Study',
        label: 'Meeting',
        duration: 75,
        fixedTime: DateTime.now().add(const Duration(minutes: 250)),
        difficultyOfTask: 'Hard',
        importanceLevel: 3,
      ),

    ];
    schedule.setTasks(tasks);
    schedule.initializeTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Schedule Test'),
      ),
      body: ListView.builder(
        itemCount: schedule.taskTimeMap.keys.length,
        itemBuilder: (context, index) {
          Task task = schedule.taskTimeMap.keys.elementAt(index);
          DateTimeRange timeRange = schedule.taskTimeMap[task]!;
          return ListTile(
            title: Text(task.getLabel()),
            subtitle: Text('${timeRange.start} - ${timeRange.end}'),
          );
        },
      ),
    );
  }
}
