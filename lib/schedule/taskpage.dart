import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:ran_app/schedule/schedulepage.dart';
import 'package:ran_app/schedule/task.dart';
import 'package:ran_app/schedule/todoinformationpopup.dart';

class TaskPage extends StatefulWidget {
  @override
  TaskPageState createState() => TaskPageState();
}// A State created by StatefulWidget to be displayed on screen.

class TaskPageState extends State<TaskPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  List<Task> taskList = [];
  Task currentTask = Task();

  String? _selectedOption;
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
          Expanded(
            flex: 0,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Center(
                child: Text("These are the tasks we have so far: "),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(

              padding: EdgeInsets.all(20.0),
              child: Table(
                border: TableBorder.all(color: Colors.black),
                children: [
                  TableRow(children: [
                    Text(_textNameController.text),
                    Text('Cell 2'),
                    Text('Cell 3'),
                    Text('Text 4'),
                  ]),
                  TableRow(children: [
                    Text('Task 4'),
                    Text('Cell 5'),
                    Text('Cell 6'),
                    Text('Cell 6')
                  ])
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: ElevatedButton(
                child: Text('Add Task'),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return TodoInformationPopup(titleController: titleController, descriptionController: descriptionController, durationController: durationController, areaController: areaController,);
                      }
                  ).then((value) {
                    setState(() {
                      if (descriptionController.text == "" || titleController.text == "") {
                      } else {
                        titleController.clear();
                        descriptionController.clear();
                      }
                    });
                  });
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: ElevatedButton(
                child: Text('Done with my tasks'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
  TextEditingController _textNameController = TextEditingController();

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Enter Task Name'),
          content: TextField(
            controller: _textNameController,
            decoration: InputDecoration(hintText: "Text Field in Dialog"),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            ElevatedButton(
              child: Text('OK'),
              onPressed: () {
                setState(() {
                  currentTask.setArea(_textNameController.text);
                });
                print(_textNameController.text);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }



}
