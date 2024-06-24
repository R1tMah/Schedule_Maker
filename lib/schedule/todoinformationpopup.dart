import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ran_app/questions/question11.dart';

// Global variable to store the selected fixed time
DateTime fixedTime = DateTime(DateTime.tuesday);
String finString = '';

String areaDropdownValue = 'Study';
String durationDropdownValue = '15';
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

  Future<DateTime?> _showTimePicker(BuildContext context) async{
    DateTime? selectedDateTime;
    await showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          height: 250,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.time,
            initialDateTime: selectedWakeUp,
            use24hFormat: false,
            onDateTimeChanged: (DateTime newDateTime) {

              selectedDateTime = newDateTime;
              currTime = newDateTime;
            },
          ),
        );
      },
    );
    return selectedDateTime;
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
                  DropdownButton<String>(
                    value: durationDropdownValue,
                    isExpanded: true,
                    items: <String>[
                      '15',
                      '30',
                      '45',
                      '60',
                      '75',
                      '90',
                      '105',
                      '120',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? selectedvalue) {
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
                      onPressed: () async{
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
                // Do something with the global fixedTime variable if needed
                if (preftimeDropDownValue == 'Fixed Time' && fixedTime != null) {
                  print("Selected Fixed Time: $fixedTime");
                }
                print("Selected Importance Level: $importanceLevel"); // Print the importance level
                Navigator.of(context).pop();
              },
            ),
            const SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}
