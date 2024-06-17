import 'package:flutter/material.dart';
import 'package:ran_app/schedule/task.dart';
import 'package:ran_app/schedule/todoinformationpopup.dart';
import 'package:ran_app/schedule/StudyTaskSelectionPage.dart';
import 'package:intl/intl.dart';

List<Color> colorList = [];
List<Task> taskList = [];
enum SampleItem { delete, edit }

class TaskPage extends StatefulWidget {
  @override
  TaskPageState createState() => TaskPageState();
}

class TaskPageState extends State<TaskPage> {
  // Variables
  TextEditingController titleController = TextEditingController();
  Task currentTask = Task();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Current Tasks'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text("These are the tasks we have so far: "),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: taskList.length,
              itemBuilder: (context, index) {
                if (taskList.isNotEmpty) {
                  final task = taskList[index];
                  String currString = 'Area: ' +
                      task.area +
                      '\nDuration: ' +
                      task.duration +
                      ' minutes \nDifficulty: ' +
                      task.difficultyOfTask +
                      '\nPreferred Time: ' +
                      task.preferredTimeOfTask +
                      '\nImportance Level: ' +
                      task.importanceLevel.toString();

                  if (task.preferredTimeOfTask == 'Fixed Time' && task.fixedTime != null) {
                    currString += ' (' + finString + ')';
                  }

                  Color taskColor = task.chooseBackGround(colorList);
                  colorList.add(taskColor);
                  print('hi');
                  return Card(
                    color: taskColor, // Will change this, just wanted to see colors
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: ListTile(
                      title: Text(task.label,
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(currString),
                      trailing: PopupMenuButton<String>(
                        itemBuilder: (BuildContext context) {
                          return <PopupMenuEntry<String>>[
                            PopupMenuItem<String>(
                              value: 'option1',
                              child: ListTile(
                                leading: Icon(Icons.delete),
                                title: Text('Delete'),
                              ),
                            ),
                            PopupMenuDivider(),
                            PopupMenuItem<String>(
                              value: 'option2',
                              child: ListTile(
                                leading: Icon(Icons.edit),
                                title: Text('Edit'),
                              ),
                            ),
                          ];
                        },
                        onSelected: (String value) {
                          // Handle the selected option
                          switch (value) {
                            case 'option1':
                              setState(() {
                                taskList.removeAt(index);
                              });
                              break;
                            case 'option2':
                              _showEditReminderDialog(index);
                              break;
                          }
                        },
                      ),
                    ),
                  );
                } else if (taskList.isEmpty) {
                  index--;
                }
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15.0),
            child: ElevatedButton(
              child: Text('Add Task'),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return TodoInformationPopup(
                        titleController: titleController);
                  },
                ).then((value) {
                  currentTask = Task(
                    area: areaDropdownValue,
                    label: titleController.text,
                    duration: durationDropdownValue,
                    preferredTimeOfTask: preftimeDropDownValue,
                    difficultyOfTask: difficultyDropDownValue,
                    fixedTime: fixedTime,
                    background: currentTask.chooseBackGround(colorList),
                    importanceLevel: importanceLevel.round(),
                  );

                  setState(() {
                    taskList.add(currentTask);
                    titleController.clear();
                    fixedTime = DateTime.now();
                  });

                  Widget okButton = TextButton(
                    child: Text("OK"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  );
                  String labelString =
                  taskList.map((task) => task.label).join(", ");
                  AlertDialog alert = AlertDialog(
                    title: Text("Tasks Added"),
                    content: Text(labelString),
                    actions: [
                      okButton,
                    ],
                  );
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return alert;
                    },
                  );
                });
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15.0),
            child: ElevatedButton(
              child: Text('Done with my tasks'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StudyTaskSelectionPage(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showEditReminderDialog(int index) {
    Task currTask = Task();

    showDialog(
      context: context,
      builder: (context) {
        return TodoInformationPopup(titleController: titleController);
      },
    ).then((value) {
      currTask = Task(
        area: areaDropdownValue,
        label: titleController.text,
        duration: durationDropdownValue,
        preferredTimeOfTask: preftimeDropDownValue,
        difficultyOfTask: difficultyDropDownValue,
        fixedTime: fixedTime,
        background: currentTask.chooseBackGround(colorList),
        importanceLevel: importanceLevel.round(),
      );

      setState(() {
        taskList[index] = currTask;
        titleController.clear();
        fixedTime = DateTime.now();
      });

      Widget okButton = TextButton(
        child: Text("OK"),
        onPressed: () {
          Navigator.pop(context);
        },
      );
      AlertDialog alert = AlertDialog(
        title: Text("Tasks Edited"),
        actions: [
          okButton,
        ],
      );
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    });
  }
}
