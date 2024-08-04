class Task {
  String title;
  double importanceLevel;

  Task({required this.title, required this.importanceLevel});
}
class TaskManager {
  List<Task> tasks = [];

  void addTask(String title, double importanceLevel) {
    String taskName = title.trim().toLowerCase();
    if (tasks.any((task) => task.title == taskName)) {
      print("Task name already in use");
    } else {
      tasks.add(Task(title: taskName, importanceLevel: importanceLevel));
    }
  }
  void sortTasksByImportance() {
    tasks.sort((a, b) => a.importanceLevel.compareTo(b.importanceLevel));
  }
  List<Task> getTasks() {
    return tasks;
  }
}
