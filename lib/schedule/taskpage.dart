import 'package:flutter/material.dart';
import 'package:ran_app/schedule/task.dart';
import 'package:ran_app/schedule/todoinformationpopup.dart';

List<Color> colorList = [];
List<Task> taskList = [];

class TaskPage extends StatefulWidget {
  @override
  TaskPageState createState() => TaskPageState();
}

class TaskPageState extends State<TaskPage> {
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
              itemCount: taskList.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Table(
                    border: TableBorder.all(color: Colors.black),
                    children: [
                      TableRow(
                        decoration: BoxDecoration(
                          color: Colors.blue[100],
                          border: Border.all(
                            width: 1,
                          ),
                        ),
                        children: [
                          Text("Label"),
                          Text('Area'),
                          Text('Duration'),
                          Text('Pref. Time'),
                          Text('Difficulty'),
                        ],
                      ),
                    ],
                  );
                } else {
                  final task = taskList[index - 1];
                  return Table(
                    border: TableBorder.all(color: Colors.black),
                    children: [
                      TableRow(children: [
                        Text(task.label),
                        Text(task.area),
                        Text(task.duration),
                        Text(task.preferredTimeOfTask),
                        Text(task.difficultyOfTask),
                      ]),
                    ],
                  );
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
                    return TodoInformationPopup(titleController: titleController);
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
                  String labelString = taskList.map((task) => task.getLabel()).join(", ");
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
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}