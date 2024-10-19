import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:ran_app/reminders/reminder.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;

class ReminderStorage {
  static const String _keyReminders = 'reminders';
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  ReminderStorage() {
    _initializeNotifications();
  }

  Future<void> _initializeNotifications() async {
    final AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    // Remove the iOS initialization settings if you do not need them
    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      // Remove iOS initialization
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> scheduleNotification(Reminder reminder, int id) async {
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'reminder_channel_id',
      'Reminders',
      channelDescription: 'Channel for Reminder Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );

    final NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      reminder.title,
      'Reminder: ${reminder.title}',
      tz.TZDateTime.from(reminder.reminderTime, tz.local),
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
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

  Future<void> saveReminders(List<Reminder> reminders) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> reminderStrings = reminders.map((reminder) {
      return jsonEncode(reminder.toJson());
    }).toList();
    await prefs.setStringList(_keyReminders, reminderStrings);
  }
}
