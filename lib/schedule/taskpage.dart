import 'package:flutter/material.dart';
import 'package:ran_app/schedule/task.dart';
import 'package:ran_app/schedule/todoinformationpopup.dart';
import 'package:ran_app/schedule/StudyTaskSelectionPage.dart';


List<Color> colorList = [];
List<Task> taskList = [];

class TaskPage extends StatefulWidget {
  @override
  TaskPageState createState() => TaskPageState();
}

class TaskPageState extends State<TaskPage> {
  //variables
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
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: ListTile(
                      title: Text(task.label,
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text('Area: ' +
                          task.area +
                          '\nDuration: ' +
                          task.duration + '\nDifficulty: ' + task.difficultyOfTask + '\nPreferred Time: ' + task.preferredTimeOfTask),
                      trailing: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => _showEditReminderDialog(index),
                      ),
                    ),
                  );
                }
                else if(taskList.isEmpty){
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
                    background: currentTask.chooseBackGround(colorList),
                  );

                  setState(() {
                    taskList.add(currentTask);
                    titleController.clear();
                  });

                  Widget okButton = TextButton(
                    child: Text("OK"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  );
                  String labelString =
                      taskList.map((task) => task.getLabel()).join(", ");
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
        background: currentTask.chooseBackGround(colorList),
      );

      setState(() {
        taskList[index] = currTask;
        titleController.clear();
      });

      Widget okButton = TextButton(
        child: Text("OK"),
        onPressed: () {
          Navigator.pop(context);
        },
      );
      AlertDialog alert = AlertDialog(
        title: Text("Tasks Saved"),
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
