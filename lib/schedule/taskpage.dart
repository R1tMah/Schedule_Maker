import 'package:flutter/material.dart';
import 'package:ran_app/schedule/schedule.dart';
import 'package:ran_app/schedule/task.dart';

class TaskPage extends StatefulWidget {
  @override
  TaskPageState createState() => TaskPageState();
}// A State created by StatefulWidget to be displayed on screen.

class TaskPageState extends State<TaskPage> {
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
                    Text('Task 1'),
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


}
