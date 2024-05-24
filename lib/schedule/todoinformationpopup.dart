
import 'package:flutter/material.dart';

String areaDropdownValue= 'Study';
String durationDropdownValue = '15';
String preftimeDropDownValue = 'Morning';
String difficultyDropDownValue = 'Easy';

class TodoInformationPopup extends StatefulWidget {

  final TextEditingController titleController;

  const TodoInformationPopup({Key? key, required this.titleController}) : super(key: key);


  @override
  _TodoInformationPopupState createState() => _TodoInformationPopupState();
}

class _TodoInformationPopupState extends State<TodoInformationPopup> {

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
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Text(
                "please select the Area of the task: ",
              ),
              DropdownButton<String>(
                value: areaDropdownValue,
                isExpanded: true,
                items: <String>[
                  'Study',
                  'Food',
                  'Exercise',
                ].map<DropdownMenuItem<String>>(
                        (String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                onChanged: (String? selectedvalue) {
                   areaDropdownValue = selectedvalue!;
                  this.setState(() {
                     areaDropdownValue= selectedvalue!;
                  });
                  print(areaDropdownValue);
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
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    "Please select the Duration of the task in minutes: ",
                  ),
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
                    ].map<DropdownMenuItem<String>>(
                            (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                    onChanged: (String? selectedvalue) {
                      durationDropdownValue= selectedvalue!;
                      this.setState(() {
                        durationDropdownValue= selectedvalue!;
                      });
                      print(durationDropdownValue);
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
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    "Please select the Duration of the task in minutes: ",
                  ),
                  DropdownButton<String>(
                    value: preftimeDropDownValue,
                    isExpanded: true,
                    items: <String>[
                      'Morning',
                      'Afternoon',
                      'Night',
                      'Late Night',

                    ].map<DropdownMenuItem<String>>(
                            (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                    onChanged: (String? selectedvalue) {
                      preftimeDropDownValue = selectedvalue!;
                      this.setState(() {
                        preftimeDropDownValue= selectedvalue!;
                      });
                      print(preftimeDropDownValue);
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
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    "Please select the Duration of the task in minutes: ",
                  ),
                  DropdownButton<String>(
                    value: difficultyDropDownValue,
                    isExpanded: true,
                    items: <String>[
                      'Easy',
                      'Medium',
                      'Hard',
                    ].map<DropdownMenuItem<String>>(
                            (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                    onChanged: (String? selectedvalue) {
                      difficultyDropDownValue= selectedvalue!;
                      this.setState(() {
                        difficultyDropDownValue= selectedvalue;
                        difficultyDropDownValue= selectedvalue;
                      });
                      print(difficultyDropDownValue);
                    },
                  ),
                ],
              ),
            ),


            const SizedBox(height: 20,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  textStyle: const TextStyle(fontWeight: FontWeight.bold)
              ),
              child: const Text("ADD"),
              onPressed:  () => Navigator. pop(context, false),
            ),
            const SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}