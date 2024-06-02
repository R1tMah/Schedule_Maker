import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'task.dart';
import 'package:ran_app/homepage/homepage.dart'; // Modify as needed
import 'package:ran_app/keys.dart';
import 'package:ran_app/schedule/schedulepage.dart';

class StudyMethodPage extends StatefulWidget {
  final List<Task> selectedTasks;
  final Map<Task, String> selectedMethods;
  final Map<Task, String> taskDescriptions;

  const StudyMethodPage({
    Key? key,
    required this.selectedTasks,
    required this.selectedMethods,
    required this.taskDescriptions,
  }) : super(key: key);

  @override
  _StudyMethodPageState createState() => _StudyMethodPageState();
}

class _StudyMethodPageState extends State<StudyMethodPage> {
  late Future<List<String>> studyMethods;

  @override
  void initState() {
    super.initState();
    studyMethods = fetchStudyMethods();
  }

  Future<List<String>> fetchStudyMethods() async {
    List<String> methods = [];
    for (var task in widget.selectedTasks) {
      final response = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $OPEN_AI_KEY'
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": [
            {
              "role": "user",
              "content": "Task: ${task.label}\n"
                  "Study Method: ${widget.selectedMethods[task]}\n"
                  "Description: ${widget.taskDescriptions[task]}\n\n"
                  "Provide a detailed study method for this task."
            }
          ],
          "max_tokens": 250,
          "temperature": 0,
          "top_p": 1,
        }),
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        methods.add(responseBody['choices'][0]['message']['content']);
      } else {
        throw Exception('Failed to load response');
      }
    }
    return methods;
  }

  void navigateToFinalPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ScheduleHomePageState()), // Modify as needed
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Study Methods"),
      ),
      body: FutureBuilder<List<String>>(
        future: studyMethods,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final methods = snapshot.data!;
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.selectedTasks.length,
                    itemBuilder: (context, index) {
                      final task = widget.selectedTasks[index];
                      final method = methods[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  task.label,
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10.0),
                                Text('Task Type: ${widget.selectedMethods[task]}'),
                                SizedBox(height: 10.0),
                                Text('Description: ${widget.taskDescriptions[task]}'),
                                SizedBox(height: 10.0),
                                Text('Suggested Study Method: $method'),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    child: Text('Done'),
                    onPressed: navigateToFinalPage,
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}