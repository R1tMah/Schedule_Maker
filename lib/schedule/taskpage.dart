import 'package:flutter/material.dart';
import 'package:ran_app/schedule/task.dart';
import 'package:ran_app/schedule/todoinformationpopup.dart';
import 'package:ran_app/schedule/StudyTaskSelectionPage.dart';
import 'package:ran_app/questions/endpage.dart';
import 'package:intl/intl.dart';

List<Color> colorList = [];
List<Task> taskList = [];
List<Task> fixedTaskList = [];
enum SampleItem { delete, edit }

String worked = "";
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
                      '\nDuration:'
                      + "${task.duration}" +
                      ' minutes \nDifficulty: ' +
                      task.difficultyOfTask +

                      '\nImportance Level: ' +
                      task.importanceLevel.toString() +
                      '\nFixed Time: ' +
                      task.preferredTimeOfTask;

                  if (task.preferredTimeOfTask == 'Fixed Time' && task.fixedTime != null) {
                    currString += ' (' + DateFormat('hh:mm a').format(task.fixedTime!) + ')';
                  }

                  Color taskColor = Colors.white;
                  colorList.add(taskColor);
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

                  if(currentTask.preferredTimeOfTask == "Fixed Time"){
                    print("Added current Task to fixed Time");
                    fixedTaskList.add(currentTask);
                  }
                  setState(() {
                    if(worked == "Worked") {
                      taskList.add(currentTask);
                    }
                    titleController.clear();
                    taskNames.add(currentTask.label);
                    finString = "";
                    areaDropdownValue = 'Study';
                    durationDropdownValue = 15;
                    preftimeDropDownValue = 'Not Fixed Time';
                    difficultyDropDownValue = 'Easy';
                    importanceLevel = 1.0; // New variable for importance level
                    currTime = DateTime.now();


                  });

                  Widget okButton = TextButton(
                    child: Text("OK"),
                    onPressed: () {
                      Navigator.pop(context);
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
                navigateToNextPage();
              },
            ),
          ),
        ],
      ),
    );
  }

  void navigateToNextPage() {
    bool studyTasks = false;
    for(int i = 0; i < taskList.length; i++){
      if(taskList[i].getArea() == "Study"){
         studyTasks = true;
      }
    }
    if(studyTasks == false) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => EndPage()), // Modify as needed
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => StudyTaskSelectionPage()),
      );
    }
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
        background: Colors.white,
        importanceLevel: importanceLevel.round(),
      );

      setState(() {
        taskList[index] = currTask;
        titleController.clear();
        fixedTime = DateTime(0);
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
