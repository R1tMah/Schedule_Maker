import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'reminder.dart';

class ReminderStorage {
  static const String _keyReminders = 'reminders';

  Future<void> saveReminders(List<Reminder> reminders) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> reminderStrings = reminders.map((reminder) {
      return jsonEncode(reminder.toJson());
    }).toList();
    await prefs.setStringList(_keyReminders, reminderStrings);
  }

  Future<List<Reminder>> loadReminders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? reminderStrings = prefs.getStringList(_keyReminders);
    if (reminderStrings == null) {
      return [];
    }
    return reminderStrings.map((reminderString) {
      Map<String, dynamic> reminderMap = jsonDecode(reminderString);
      return Reminder.fromJson(reminderMap);
    }).toList();
  }
}
