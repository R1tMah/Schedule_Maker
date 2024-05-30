import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'reminder.dart';
import 'reminder_storage.dart';

class RemindersPage extends StatefulWidget {
  @override
  _RemindersPageState createState() => _RemindersPageState();
}

class _RemindersPageState extends State<RemindersPage> {
  List<Reminder> reminders = [];
  final ReminderStorage _storage = ReminderStorage();

  @override
  void initState() {
    super.initState();
    _loadReminders();
  }

  Future<void> _loadReminders() async {
    List<Reminder> loadedReminders = await _storage.loadReminders();
    setState(() {
      reminders = loadedReminders;
    });
  }

  Future<void> _saveReminders() async {
    await _storage.saveReminders(reminders);
  }

  void _addReminder(String title, DateTime reminderTime) async {
    setState(() {
      reminders.add(Reminder(title: title, reminderTime: reminderTime));
    });
    await _saveReminders();
  }

  void _editReminder(int index, String title, DateTime reminderTime) async {
    setState(() {
      reminders[index] = Reminder(title: title, reminderTime: reminderTime);
    });
    await _saveReminders();
  }

  void _deleteReminder(int index) async {
    setState(() {
      reminders.removeAt(index);
    });
    await _saveReminders();
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
    String reminderTimeText = 'No time selected';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
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
                      final DateTime? selectedTime = await _selectDateTime(context);
                      if (selectedTime != null) {
                        setState(() {
                          reminderTime = selectedTime;
                          reminderTimeText = DateFormat('yyyy-MM-dd – kk:mm').format(reminderTime!);
                        });
                      }
                    },
                    child: Text('Select Reminder Time'),
                  ),
                  SizedBox(height: 8),
                  Text(reminderTimeText),
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
      },
    );
  }

  void _showEditReminderDialog(int index) {
    String title = reminders[index].title;
    DateTime? reminderTime = reminders[index].reminderTime;
    String reminderTimeText = DateFormat('yyyy-MM-dd – kk:mm').format(reminderTime);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Edit Reminder'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(labelText: 'Title'),
                    controller: TextEditingController(text: title),
                    onChanged: (value) {
                      title = value;
                    },
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final DateTime? selectedTime = await _selectDateTime(context);
                      if (selectedTime != null) {
                        setState(() {
                          reminderTime = selectedTime;
                          reminderTimeText = DateFormat('yyyy-MM-dd – kk:mm').format(reminderTime!);
                        });
                      }
                    },
                    child: Text('Select Reminder Time'),
                  ),
                  SizedBox(height: 8),
                  Text(reminderTimeText),
                ],
              ),
              actions: <Widget>[
                ElevatedButton(
                  child: Text('Save'),
                  onPressed: () {
                    if (title.isNotEmpty && reminderTime != null) {
                      _editReminder(index, title, reminderTime!);
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showDeleteReminderDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Reminder'),
          content: Text('Are you sure you want to delete this reminder?'),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Delete'),
              onPressed: () {
                _deleteReminder(index);
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
    return Scaffold(
      body: ListView.builder(
        itemCount: reminders.length,
        itemBuilder: (context, index) {
          final reminder = reminders[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              title: Text(reminder.title, style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(DateFormat('yyyy-MM-dd – kk:mm').format(reminder.reminderTime)),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () => _showEditReminderDialog(index),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _showDeleteReminderDialog(index),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddReminderDialog,
        backgroundColor: Colors.white,
        child: Icon(Icons.add, color: Colors.black),
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
