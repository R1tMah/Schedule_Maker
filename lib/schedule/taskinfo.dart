import 'package:flutter/material.dart';
import 'task.dart';
import 'package:ran_app/schedule/StudyMethodPage.dart';

class TaskInfo extends StatefulWidget {
  final List<Task> selectedTasks;

  const TaskInfo({Key? key, required this.selectedTasks}) : super(key: key);

  @override
  _TaskInfoState createState() => _TaskInfoState();
}

class _TaskInfoState extends State<TaskInfo> {
  final List<String> studyMethods = ['Memorization', 'Conceptual', 'Arithmetic', 'Oral Task', 'Writing'];
  final Map<Task, String> selectedMethods = {};
  final Map<Task, TextEditingController> descriptionControllers = {};
  bool isNextButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    for (var task in widget.selectedTasks) {
      selectedMethods[task] = studyMethods[0];
      descriptionControllers[task] = TextEditingController();
      descriptionControllers[task]?.addListener(() {
        checkIfAllDescriptionsFilled();
      });
    }
  }

  void checkIfAllDescriptionsFilled() {
    bool allFilled = widget.selectedTasks.every((task) => descriptionControllers[task]?.text.isNotEmpty ?? false);
    setState(() {
      isNextButtonEnabled = allFilled;
    });
  }

  void navigateToStudyMethodPage() {
    Map<Task, String> taskDescriptions = {};
    widget.selectedTasks.forEach((task) {
      taskDescriptions[task] = descriptionControllers[task]!.text;
    });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StudyMethodPage(
          selectedTasks: widget.selectedTasks,
          selectedMethods: selectedMethods,
          taskDescriptions: taskDescriptions,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Information'),
      ),
      body: ListView(
        padding: EdgeInsets.all(15.0),
        children: [
          ...widget.selectedTasks.map((task) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.label,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                DropdownButton<String>(
                  value: selectedMethods[task],
                  items: studyMethods.map((method) {
                    return DropdownMenuItem<String>(
                      value: method,
                      child: Text(
                        method,
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedMethods[task] = value!;
                    });
                  },
                ),
                TextField(
                  style: TextStyle(color: Colors.white),
                  controller: descriptionControllers[task],
                  decoration: InputDecoration(
                    labelText: 'Brief description of task',
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                  maxLines: 3,
                ),
                SizedBox(height: 20.0),
              ],
            );
          }).toList(),
          ElevatedButton(
            child: Text('Next'),
            onPressed: isNextButtonEnabled ? navigateToStudyMethodPage : null,
          ),
        ],
      ),
    );
  }
}
