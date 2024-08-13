import 'dart:convert';

import 'package:flutter/material.dart';
import 'databaseService.dart';
import 'package:ran_app/schedule/task.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DatabaseTest(),
    );
  }
}

class DatabaseTest extends StatefulWidget {
  @override
  _DatabaseTestState createState() => _DatabaseTestState();
}

class _DatabaseTestState extends State<DatabaseTest> {
  final DatabaseService _dbService = DatabaseService.instance;
  String _retrievedData = '';
  final TextEditingController _stringController = TextEditingController();
  final TextEditingController _intController = TextEditingController();
  final TextEditingController _retrieveIntController = TextEditingController();

  Map<Task, DateTimeRange> taskTimeMap = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Database Test'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _stringController,
              decoration: InputDecoration(
                labelText: 'Enter String',
              ),
            ),
            TextField(
              controller: _intController,
              decoration: InputDecoration(
                labelText: 'Enter Int',
              ),
              keyboardType: TextInputType.number, // Use here, outside the InputDecoration
            ),
            ElevatedButton(
              onPressed: _addData,
              child: Text('Add Data'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _retrieveIntController,
              decoration: InputDecoration(
                labelText: 'Enter Int to Retrieve String',
              ),
              keyboardType: TextInputType.number, // Use here as well
            ),
            ElevatedButton(
              onPressed: _getData,
              child: Text('Get Data'),
            ),
            SizedBox(height: 20),
            Text(
              _retrievedData,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  void _addData() async {
    /*
    String inputString = _stringController.text;
    int inputInt = int.parse(_intController.text);

    await _dbService.addSchedule(inputInt, inputString);

    setState(() {
      _retrievedData = 'Data added: $inputInt -> $inputString';
    });
     */
    initMap1();
    int month = DateTime.now().month;
    int day = DateTime.now().day;
    int year = DateTime.now().year;

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

    String stringDate = "${strMonth}${strDay}${year}";
    int intDate = int.parse(stringDate);
    String content = jsonEncode(taskTimeMap, toEncodable: (value) {
      if (value is Task) {
        return jsonEncode(value);
      } else if (value is DateTimeRange){
        return value.toString();
      } else {
        return 'test';
      }
    });
    await _dbService.addSchedule(intDate, content);

    setState(() {
      _retrievedData = 'Data added: $intDate -> $content';
    });
  }

  void _getData() async {
    /*
    int inputInt = int.parse(_retrieveIntController.text);

    String? data = await _dbService.getSchedule(inputInt);

    setState(() {
      _retrievedData = data != null ? 'Retrieved data: $data' : 'No data found for $inputInt';
    });
    */
    Map<Task, DateTimeRange> retrievedMap = {};
    int inputInt = int.parse(_retrieveIntController.text);
    String? data = await _dbService.getSchedule(inputInt);
    if(data != null) {
      retrievedMap = jsonDecode(data);
    }
    setState(() {
      _retrievedData = data != null ? 'Retrieved data: $retrievedMap' : 'No data found for $inputInt';
    });
  }

  void initMap1() {
    taskTimeMap = {};
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
    DateTime currTime = DateTime.now();
    for(int i = 0; i < tasks.length; i++) {
      taskTimeMap[tasks[i]] = DateTimeRange(start: currTime, end: currTime.add(Duration(minutes: tasks[i].duration)));
      currTime.add(Duration(minutes: tasks[i].duration));
    }
  }
}
