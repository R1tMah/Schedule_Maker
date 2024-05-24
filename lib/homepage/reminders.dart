import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Reminder {
  String title;
  DateTime reminderTime;

  Reminder({required this.title, required this.reminderTime});
}

class RemindersPage extends StatefulWidget {
  @override
  _RemindersPageState createState() => _RemindersPageState();
}

class _RemindersPageState extends State<RemindersPage> {
  List<Reminder> reminders = [];

  void _addReminder(String title, DateTime reminderTime) {
    setState(() {
      reminders.add(Reminder(title: title, reminderTime: reminderTime));
    });
  }

  Future<DateTime?> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime != null) {
        return DateTime(pickedDate.year, pickedDate.month, pickedDate.day, pickedTime.hour, pickedTime.minute);
      }
    }
    return null;
  }

  void _showAddReminderDialog() {
    String title = '';
    DateTime? reminderTime;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Reminder'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                onChanged: (value) {
                  title = value;
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  reminderTime = await _selectDateTime(context);
                },
                child: Text('Select Reminder Time'),
              ),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Add'),
              onPressed: () {
                if (title.isNotEmpty && reminderTime != null) {
                  _addReminder(title, reminderTime!);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0.0), // Zero height to remove the white bar
        child: AppBar(
          backgroundColor: Colors.transparent, // Transparent AppBar
          elevation: 0, // No shadow
        ),
      ),
      body: ListView.builder(
        itemCount: reminders.length,
        itemBuilder: (context, index) {
          final reminder = reminders[index];
          return ListTile(
            title: Text(reminder.title),
            subtitle: Text(DateFormat('yyyy-MM-dd – kk:mm').format(reminder.reminderTime)),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddReminderDialog,
        backgroundColor: Colors.white,
        child: Icon(Icons.add, color: Colors.black), // Black add icon for contrast
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: RemindersPage(),
  ));
}
