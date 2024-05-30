class Reminder {
  String title;
  DateTime reminderTime;

  Reminder({required this.title, required this.reminderTime});

  Map<String, dynamic> toJson() => {
    'title': title,
    'reminderTime': reminderTime.toIso8601String(),
  };

  static Reminder fromJson(Map<String, dynamic> json) {
    return Reminder(
      title: json['title'],
      reminderTime: DateTime.parse(json['reminderTime']),
    );
  }
}
