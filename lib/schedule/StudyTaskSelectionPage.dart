import 'package:flutter/material.dart';
import 'task.dart';
import 'package:ran_app/schedule/taskpage.dart';

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
    // Implement the navigation to the next page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NextPage(selectedTasks: selectedTasks),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Study Tasks'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              "Select the following study tasks which you would like study methods for:",
              style: TextStyle(fontSize: 18.0),
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
                  title: Text(task.label),
                  subtitle: Text('Duration: ${task.duration} mins'),
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
              onPressed: selectedTasks.isEmpty ? null : navigateToNextPage,
            ),
          ),
        ],
      ),
    );
  }
}

class NextPage extends StatelessWidget {
  final List<Task> selectedTasks;

  const NextPage({Key? key, required this.selectedTasks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Next Page'),
      ),
      body: Center(
        child: Text('Selected Tasks: ${selectedTasks.map((task) => task.label).join(', ')}'),
      ),
    );
  }
}
