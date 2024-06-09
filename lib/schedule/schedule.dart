import 'package:flutter/material.dart';
import 'package:ran_app/schedule/task.dart';
import 'package:ran_app/schedule/taskpage.dart';
import 'package:time_range/time_range.dart';



class Schedule {
  Schedule({
    this.scheduleDate,
    this.studyMethod = '',
    this.workingMethod = '',
    this.taskTimeMap,
  });

  DateTime? scheduleDate;
  String studyMethod;
  String workingMethod;
  List<Task> currTaskList = [];

  Map<Task, TimeRange>? taskTimeMap;

  void initializeList(List<Task> taskList) {
    currTaskList.addAll(taskList);
  }

  Task? findEasyTask(){
    for(int i = 0; i < currTaskList.length; i++){
      if(currTaskList[i].difficultyOfTask == 'Easy'){
        return currTaskList[i];
      }
    }
    return null;
  }
  Task? findMediumTask(){
    for(int i = 0; i < currTaskList.length; i++){
      if(currTaskList[i].difficultyOfTask == 'Medium'){
        return currTaskList[i];
      }
    }
    return null;
  }
  Task? findHardTask(){
    for(int i = 0; i < currTaskList.length; i++){
      if(currTaskList[i].difficultyOfTask == 'Hard'){
        return currTaskList[i];
      }
    }
    return null;
  }
  int StringToInt(String time){
    int newTime = int.parse(time);
    return newTime;
  }
  void setFixedTasks(){
    for(int i = 0; i < currTaskList.length; i++){
      if(currTaskList[i].preferredTimeOfTask == 'Fixed Time'){
        taskTimeMap?[currTaskList[i]] = new TimeRange(
          titlePadding: 20,
          textStyle: TextStyle(fontWeight: FontWeight.normal, color: Colors.black87),
          activeTextStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          backgroundColor: Colors.transparent,
          firstTime: TimeOfDay(hour: 14, minute: 30),
          lastTime: TimeOfDay(hour: 20, minute: 00),
          timeStep: 10,
          timeBlock: 30, onRangeCompleted: (range) => print(range),
        );
      }
    }

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