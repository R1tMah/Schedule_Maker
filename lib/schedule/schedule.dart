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

Pseudocode for Interleaved Practice

Variables:

Iterate through all of the study tasks, choose 3 tasks
Variable for working method (25/50/90)
Make a list of the 3 tasks (miniList)
Map (task -> int) fullMapMap for if task is done
Map (task → int) listMap for if task is done within 3 tasks in list
Int variable called subtasktime
if(working method is 25)... (choose the time for each one)
Variable currtime // for the current time
Variable breaktime for the length of the break

Helper Functions:
checkIfAllTasksAreDone(Map) → returns 0/1 depending if theyre all done
checkIfAnyTasksAreDone(Map) → returns the task thats done

While(checkIfAllTasksAreDone != 0) {
	for(i < working method/subtasktime) {
		Task doneTask = checkIfAnyTasksAreDone(
		if(checkIfAnyTasksAreDone != null){

}
	if(checkiftimefits(DateTimeRange(currtime, currtime + subtasktime)) {
	Add a new task to the map at currtime that is subtasktime minutes long
	This task is named
Update currtime
	} //if statement
} //for loop

}

Add a break


 */