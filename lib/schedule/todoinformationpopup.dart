import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ran_app/questions/question11.dart';

List<String> taskNames = []; // Global list to store task names

// Global variable to store the selected fixed time
DateTime fixedTime = DateTime(DateTime.tuesday);
String finString = '';

String areaDropdownValue = 'Study';
int durationDropdownValue = 15;
String preftimeDropDownValue = 'Morning';
String difficultyDropDownValue = 'Easy';
double importanceLevel = 1.0; // New variable for importance level
DateTime currTime = DateTime.now();

class TodoInformationPopup extends StatefulWidget {
  final TextEditingController titleController;

  const TodoInformationPopup({Key? key, required this.titleController}) : super(key: key);

  @override
  _TodoInformationPopupState createState() => _TodoInformationPopupState();
}

class _TodoInformationPopupState extends State<TodoInformationPopup> {
  int selectedHour = 0;
  int selectedMinute = 0;

  List<Widget> _buildPickerItems(int count) {
    return List<Widget>.generate(
      count,
          (int index) {
        return Center(
          child: Text(index.toString().padLeft(2, '0')),
        );
      },
    );
  }

  Future<DateTime?> _showTimePicker(BuildContext context) async {
    DateTime? selectedDateTime = selectedWakeUp;

    await showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              height: 250,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.time,
                initialDateTime: selectedWakeUp,
                use24hFormat: false,
                onDateTimeChanged: (DateTime newDateTime) {
                  // Only update selectedDateTime if newDateTime is after selectedWakeUp
                  if (newDateTime.isAfter(selectedWakeUp!) || newDateTime.isAtSameMomentAs(selectedWakeUp!)) {
                    selectedDateTime = newDateTime;
                  } else {
                    // Close the bottom sheet
                    Navigator.pop(context);

                    // Show an alert dialog
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Invalid Time"),
                          content: Text("Please select a time after ${selectedWakeUp!.hour}:${selectedWakeUp!.minute}"),
                          actions: <Widget>[
                            TextButton(
                              child: Text("OK"),
                              onPressed: () {
                                Navigator.of(context).pop();
                                // Reopen the time picker with the correct time
                                _showTimePicker(context);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
              ),
            );
          },
        );
      },
    );

    return selectedDateTime;
  }

  void _showDuplicateTaskDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Duplicate Task Name"),
          content: Text("The task name already exists. Please enter a different name."),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.deepPurpleAccent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 20,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10,),
            const Text("Add Task", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 35),),
            const SizedBox(height: 40,),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: TextField(
                controller: widget.titleController,
                decoration: const InputDecoration(
                  labelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                  labelText: "Title",
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Please select the Area of the task: "),
                  DropdownButton<String>(
                    value: areaDropdownValue,
                    isExpanded: true,
                    items: <String>[
                      'Study',
                      'Food',
                      'Exercise',
                      'Other',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? selectedvalue) {
                      setState(() {
                        areaDropdownValue = selectedvalue!;

                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Please select the Duration of the task in minutes: "),
                  DropdownButton<int>(
                    value: durationDropdownValue,
                    isExpanded: true,
                    items: <int>[
                      15,
                      30,
                      45,
                      60,
                      75,
                      90,
                      105,
                      120,
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (int? selectedvalue) {
                      setState(() {
                        durationDropdownValue = selectedvalue!;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Please select the Difficulty of the task: "),
                  DropdownButton<String>(
                    value: difficultyDropDownValue,
                    isExpanded: true,
                    items: <String>[
                      'Easy',
                      'Medium',
                      'Hard',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? selectedvalue) {
                      setState(() {
                        difficultyDropDownValue = selectedvalue!;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Please select the preferred time of the task: "),
                  DropdownButton<String>(
                    value: preftimeDropDownValue,
                    isExpanded: true,
                    items: <String>[
                      'Morning',
                      'Afternoon',
                      'Night',
                      'Late Night',
                      'Anytime',
                      'Fixed Time',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? selectedvalue) {
                      setState(() {
                        preftimeDropDownValue = selectedvalue!;
                      });
                    },
                  ),
                  if (preftimeDropDownValue == 'Fixed Time') ...[
                    const SizedBox(height: 20,),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        textStyle: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onPressed: () async {
                        final DateTime? selectedTime = await _showTimePicker(context);
                        if (selectedTime != null) {
                          setState(() {
                            finString = DateFormat('hh:mm a').format(selectedTime);
                          });
                        }
                      },
                      child: const Text(
                        "Select Time",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      "Selected Time: ${finString}",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Please select the Importance level of the task (1 is most important, 5 is least important): "),
                  Slider(
                    value: importanceLevel,
                    min: 1,
                    max: 5,
                    divisions: 4,
                    label: importanceLevel.round().toString(),
                    onChanged: (double value) {
                      setState(() {
                        importanceLevel = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                textStyle: const TextStyle(fontWeight: FontWeight.bold),
              ),
              child: const Text("ADD"),
              onPressed: () {
                String taskName = widget.titleController.text.trim().toLowerCase();
                if (taskNames.contains(taskName)) {
                  _showDuplicateTaskDialog();
                } else {
                  taskNames.add(taskName);
                  if (preftimeDropDownValue == 'Fixed Time' && fixedTime != null) {
                    print("Selected Fixed Time: $fixedTime");
                  }
                  print("Selected Importance Level: $importanceLevel"); // Print the importance level
                  Navigator.of(context).pop();
                }
              },
            ),
            const SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}

