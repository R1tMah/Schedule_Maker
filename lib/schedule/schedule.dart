import 'package:flutter/material.dart';
import 'package:ran_app/schedule/task.dart';
import 'package:ran_app/schedule/taskpage.dart';
import 'package:time_range/time_range.dart';



class Schedule {
  Schedule({
    this.scheduleDate,
    this.studyMethod = '',
    this.workingMethod = '',
  });

  DateTime? scheduleDate;
  String studyMethod;
  String workingMethod;
  List<Task> currTaskList = [];

  Map<Task, DateTimeRange> taskTimeMap = {};

  void initializeList(List<Task> taskList) {
    currTaskList.addAll(taskList);
  }

  Task? findEasyTask() {
    for (int i = 0; i < currTaskList.length; i++) {
      if (currTaskList[i].difficultyOfTask == 'Easy') {
        return currTaskList[i];
      }
    }
    return null;
  }

  Task? findMediumTask() {
    for (int i = 0; i < currTaskList.length; i++) {
      if (currTaskList[i].difficultyOfTask == 'Medium') {
        return currTaskList[i];
      }
    }
    return null;
  }

  Task? findHardTask() {
    for (int i = 0; i < currTaskList.length; i++) {
      if (currTaskList[i].difficultyOfTask == 'Hard') {
        return currTaskList[i];
      }
    }
    return null;
  }

  int stringToInt(String time) {
    int newTime = int.parse(time);
    return newTime;
  }

  void setFixedTasks() {
    for (var task in currTaskList) {
      if (task.preferredTimeOfTask == 'Fixed Time') {
        taskTimeMap[task] = DateTimeRange(start: task.fixedTime!, end: task.fixedTime!.add(Duration(minutes: stringToInt(task.duration))));
      }
    }
  }
  DateTimeRange chooseTime(Task task){ //schedule function
    return DateTimeRange(start: DateTime.now(), end: DateTime.now());
  }
  void addTaskToMap(Task task){
    DateTimeRange time = chooseTime(task); // finds the range of the task
    taskTimeMap[task] = time;
  }
  int _checkIfTimeFits(DateTimeRange newRange){
    for(DateTimeRange time in taskTimeMap.values){
      DateTime start = newRange.start;
      if (start.isAfter(time.start) && start.isBefore(time.end)) {
        return 1;
      }
      DateTime end = newRange.end;
      if (end.isBefore(time.end) && end.isAfter(time.start)) {
        return 1;
      }
    }
    return 0;
  }
}




//File for the schedule class
/*
Date
Study Method
Working Method
List of Tasks
Map (Each Task) (Time)


need a helper function that finds first easy task, first medium task, and first hard task

need a function that checks to see if a time works

need a function that compares with the 4 working methods

need a function that decides what time to start the day

need a function that puts the fixed tasks in their times

need a function that edits the map of tasks




class DataSource extends CalendarDataSource {
  DataSource(List<Task> source) {
    appointments = source;
  }


  @override
  String getSubject(int index) => appointments[index].label;

  @override
  String getStartTimeZone(int index) => appointments[index].startTimeZone;

  @override
  String getNotes(int index) => appointments[index].description;

  @override
  String getEndTimeZone(int index) => appointments[index].endTimeZone;

  @override
  Color getColor(int index) => appointments[index].background;

  @override
  DateTime getStartTime(int index) => appointments[index].from;

  @override
  DateTime getEndTime(int index) => appointments[index].to;
}

 */