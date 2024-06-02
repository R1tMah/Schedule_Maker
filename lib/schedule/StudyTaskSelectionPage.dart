import 'package:flutter/material.dart';
import 'task.dart';
import 'package:ran_app/schedule/taskpage.dart';
import 'package:ran_app/schedule/taskinfo.dart';

class StudyTaskSelectionPage extends StatefulWidget {
  @override
  _StudyTaskSelectionPageState createState() => _StudyTaskSelectionPageState();
}

class _StudyTaskSelectionPageState extends State<StudyTaskSelectionPage> {
  List<Task> studyTasks = [];
  List<Task> selectedTasks = [];

  @override
  void initState() {
    super.initState();
    // Filter tasks with area 'Study'
    studyTasks = taskList.where((task) => task.area == 'Study').toList();
  }

  void toggleTaskSelection(Task task) {
    setState(() {
      if (selectedTasks.contains(task)) {
        selectedTasks.remove(task);
      } else {
        selectedTasks.add(task);
      }
    });
  }

  void navigateToNextPage() {
    if(selectedTasks == null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TaskInfo(selectedTasks: selectedTasks),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TaskInfo(selectedTasks: selectedTasks),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Study Tasks',),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              "Select the following study tasks which you would like study methods for:",
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: studyTasks.length,
              itemBuilder: (context, index) {
                final task = studyTasks[index];
                final isSelected = selectedTasks.contains(task);
                return ListTile(
                  title: Text(
                      task.label,
                      style: TextStyle(
                        color: Colors.white,
                      )
                  ),
                  subtitle: Text(
                      'Duration: ${task.duration} minutes',
                      style: TextStyle(
                        color: Colors.white,
                      )
                  ),
                  tileColor: isSelected ? Colors.lightBlueAccent : null,
                  onTap: () => toggleTaskSelection(task),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15.0),
            child: ElevatedButton(
              child: Text('Next'),
              onPressed: navigateToNextPage,
            ),
          ),
        ],
      ),
    );
  }
}