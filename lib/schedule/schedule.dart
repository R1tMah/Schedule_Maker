import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ran_app/schedule/task.dart';
import 'package:ran_app/schedule/taskpage.dart';
import 'package:time_range/time_range.dart';
import 'package:ran_app/questions/question11.dart';
import 'package:ran_app/questions/endpage.dart';


var work = (((response.split(', '))[0]).split('-'))[0];
var rest = (((((response.split(', '))[0]).split('-'))[1]).split(' '))[0];
var workingMethod = (response.split(', '))[1];

class Schedule {
  Schedule({
    this.scheduleDate,
    this.studyMethod = '',
    this.workingtime = 0,
  });

  DateTime? scheduleDate;
  String studyMethod;
  String? workingMethod;
  List<Task> currTaskList = [];

  List<Task> currStudyTaskList = [];

  List<Task> easyTasks = [];
  List<Task> mediumTasks = [];
  List<Task> hardTasks = [];
  List<Task> othertasks = [];
  int workingtime;
  var breaktime = 10;
  var remainingTime = 0;
  DateTime currTime = selectedWakeUp!;
  var sessionCounter = 0;
  Task currTask = Task();
  var max = 0;

  Task newTask = Task();
  Map<Task, double> subSessionsNeededMap = {};
  List<Task> rotationList = []; //length of the list is workingtime/subtask
  var subtasktime;

  //adds tasks to currTaskList
  void setTasks(List<Task> taskList){
    for(int i = 0; i < taskList.length; i++){
      currTaskList.add(taskList[i]);
      print(currTaskList[i].getLabel());
    }
  }

  void initializeTasks(){
    //instantiate workingtime
    remainingTime = workingtime;
    //adds the study and other tasks
    for(int i = 0; i < currTaskList.length; i++) {
      print("This is the area of the" + (i + 1).toString() + "th task: " +
          currTaskList[i].area);
      if (currTaskList[i].isFixedTime() == false){
        if (currTaskList[i].area == 'Study') {
          currStudyTaskList.add(currTaskList[i]);
        }
        else {
          othertasks.add(currTaskList[i]);
        }
      }
    }
    // adding tasks to their respective difficulties
    for (int i = 0; i < currStudyTaskList.length; i++) {
      if (currStudyTaskList[i].difficultyOfTask == 'Easy') {
        easyTasks.add(currStudyTaskList[i]);
        print("This is the last easy task: " + easyTasks[easyTasks.length - 1].getLabel());
      }

      else if(currStudyTaskList[i].difficultyOfTask == 'Medium'){
        mediumTasks.add(currStudyTaskList[i]);
        print("This is the last medium task: " + mediumTasks[mediumTasks.length - 1].getLabel());

      }
      else{
        hardTasks.add(currStudyTaskList[i]);
        print("This is the last hard task: " + hardTasks[hardTasks.length - 1].getLabel());
      }
      print("_____________________________________________________");
    }




    //for subtasktime and breaktime
    if(workingtime == 30){
      breaktime = 10;
      subtasktime = 15;
      max = 3;
    }
    else if(workingtime == 60){
      breaktime = 20;
      subtasktime = 15;
      max = 3;
    }
    else if(workingtime == 90){
      breaktime = 30;
      subtasktime = 30;
      max = 2;
    }
    for(int i = 0; i < currStudyTaskList.length; i++){
      sessionsNeededMap[currStudyTaskList[i]] = (currStudyTaskList[i].duration).toDouble();
    }
    for(int i = 0; i < currStudyTaskList.length; i++){
      subSessionsNeededMap[currStudyTaskList[i]] = (currStudyTaskList[i].duration)/subtasktime;
    }
    if(currStudyTaskList.length >= workingtime / subtasktime) {
      int k = 0;
      while (k < workingtime / subtasktime) {
        rotationList.add(currStudyTaskList[k]);
        k++;
      }
    }
    else{
      int k = 0;
      while(k < currStudyTaskList.length){
        rotationList.add(currStudyTaskList[k]);
        k++;
      }
    }




  }



  Map<Task, DateTimeRange> taskTimeMap = {};
  Map<Task, double> sessionsNeededMap = {};


  Task? findHardTask() {
    for (int i = 0; i < currStudyTaskList.length; i++) {
      if (currStudyTaskList[i].difficultyOfTask == 'Hard') {
        return currStudyTaskList[i];
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
      print("task ${task.getLabel()} is fixed: ${task.isFixedTime()}");
      if (task.isFixedTime()) {
        taskTimeMap[task] = DateTimeRange(start: task.fixedTime!, end: task.fixedTime!.add(Duration(minutes: task.duration)));
      }
    }
  }


  int _checkIfTimeFits(DateTimeRange newRange){
    for (DateTimeRange time in taskTimeMap.values) {
      DateTime start = newRange.start;
      DateTime end = newRange.end;

      // Check if newRange overlaps with an existing range in any way
      if ((start.isBefore(time.end) && end.isAfter(time.start)) ||
          (start.isBefore(time.end) && start.isAfter(time.start)) ||
          (end.isBefore(time.end) && end.isAfter(time.start)) ||
          (start.isAtSameMomentAs(time.start) ||
              end.isAtSameMomentAs(time.end))) {
        print("Overlap detected");
        return 1;
      }
    }
    return 0;
  }
  void findNextAvailableTime(){
    while(_checkIfTimeFits(DateTimeRange(start: currTime, end: currTime.add(Duration(minutes: (workingtime + breaktime))))) == 1){
      currTime = currTime.add(const Duration(minutes: 15));
    }
  }
  bool TimeAfterTwelve(){
    if(currTime.isAfter(DateTime(DateTime.now().day, 23, 59))){
      return true;
    }
    return false;
  }

  void addToTaskTimeMap(int duration){
    Task newTask =  Task(
      area: currTask.area,
      label: currTask.label,
      duration: duration,
      preferredTimeOfTask: currTask.preferredTimeOfTask,
      difficultyOfTask:  currTask.difficultyOfTask,
      fixedTime: currTask.fixedTime,
      importanceLevel: currTask.importanceLevel,
    );
    taskTimeMap[newTask] = DateTimeRange(start: currTime, end: currTime.add(Duration(minutes: duration)));
  }

  void printTaskList(List<Task> taskList){
    for(int i = 0; i < taskList.length; i++){
      print(taskList[i].getLabel());
    }
  }

  void printSessionsMap(){
    print("This is what is in the sessions map right now. \n");
    for(Task t in sessionsNeededMap.keys){
      print("Task " + t.getLabel() + " has ${sessionsNeededMap[t]} sessions left. \n" );
    }
    print("_________________________________________________________________________\n");
  }

  void printSubSessionsMap(){
    print("This is what is in the sub sessions map right now. \n");
    for(Task t in subSessionsNeededMap.keys){
      print("Task " + t.getLabel() + " has ${subSessionsNeededMap[t]} sessions left. \n" );
    }
    print("_________________________________________________________________________\n");
  }

  void printTaskTimeMap(){
    print("This is what is in the task tim map right now. \n");
    for(Task t in taskTimeMap.keys){
      print("Task " + t.getLabel() + " is scheduled for ${taskTimeMap[t]}\n" );
    }
    print("_________________________________________________________________________\n");
  }
  //add
  void scheduleTimesBasedOnList(List<Task> taskList){
    while(taskList.isNotEmpty){

      int breakValue = 0;

      printSessionsMap();
      printTaskList(taskList);
      currTask = taskList[0];
      print("Max: ${max}");
      print("Session Counter ${sessionCounter}");
      print("The current time is \n ${currTime}");
      print("The current task I am looking at is ${currTask.label}");
      print("This value is less than 1: ${sessionsNeededMap[currTask]! <  1.0}");
      print("The amount of time left in the current session is ${remainingTime}");
      print("The amount of sessions that ${currTask.label} has left is ${sessionsNeededMap[currTask]}");
      print("___________________________________________");
      if(sessionCounter == max){
        if(othertasks.isEmpty){
          print("The other tasks are empty");
          currTime = currTime.add(Duration(minutes: workingtime));
          sessionCounter = 0;
        }
        else if(_checkIfTimeFits(DateTimeRange(start: currTime, end: currTime.add(Duration(minutes: othertasks[0].duration)))) == 0 ) {
          currTask = othertasks[0];
          print("Changed the current task to ${currTask.getLabel()} for now because we have hit the session counter and this tasks fits into the schedule : ${currTime.add(Duration(minutes: othertasks[0].duration)).isAfter(DateTime(2024, 8, 1, 7, 45))}");
          addToTaskTimeMap(currTask.duration);
          currTime = currTime.add(Duration(minutes: currTask.duration));
          othertasks.removeAt(0);
          sessionCounter = 0;
        }else{
          currTime = currTime.add(Duration(minutes: 15));
        }
      }
      else if(_checkIfTimeFits(DateTimeRange(start: currTime, end: currTime.add(Duration(minutes:remainingTime + breaktime)))) == 0){
        if(sessionsNeededMap[currTask]! <=  workingtime || remainingTime != workingtime){
          print("Hey the session amount for the current task (${currTask.getLabel()}) is less than 1 or we're in the middle of a session right now.");

          while((sessionsNeededMap[currTask]!) <= remainingTime){

            remainingTime -= (sessionsNeededMap[currTask]!).toInt();
            print("This is the time remaining in the session:  $remainingTime");

            addToTaskTimeMap((sessionsNeededMap[currTask]!).toInt());
            taskList.removeAt(0);
            currTime = currTime.add(Duration(minutes: (sessionsNeededMap[currTask]!).toInt()));
            sessionsNeededMap.remove(currTask);
            print("\nThe task list contains ${taskList.length} values now\n");
            print("The task list is empty: ${taskList.isEmpty}");
            if(taskList.isEmpty){
              breakValue = 1;
              break;
            }
            else {
              currTask = taskList[0];
              print("The new current task is " + currTask.getLabel());
            }
          }
          if(breakValue == 1){
            break;
          }
          if(remainingTime <= 0){
            remainingTime = workingtime;
            print("I changed the remaining time back to the workingtime");
          }
          else if((sessionsNeededMap[currTask]!) > remainingTime){
            print("The current task ${currTask.getLabel()} has more than $remainingTime minutes left.");
            addToTaskTimeMap(remainingTime);
            currTime = currTime.add(Duration(minutes: remainingTime));
            sessionsNeededMap.update(currTask, (value) => value - remainingTime);
            remainingTime -= (sessionsNeededMap[currTask]!).toInt();
            remainingTime = workingtime;
          }
          print("Added the break");
          currTask = Task(label: "Break");
          addToTaskTimeMap(breaktime);
          currTime = currTime.add(Duration(minutes: breaktime));
        }
        else {
          sessionsNeededMap.update(currTask, (value) => value - workingtime);
          addToTaskTimeMap(workingtime);
          currTime = currTime.add(Duration(minutes: workingtime));
          currTask = Task(label: "Break");
          addToTaskTimeMap(breaktime);
          currTime = currTime.add(Duration(minutes: breaktime));
        }
        sessionCounter+=1;
      }
      else {
        findNextAvailableTime();
      }

    }


  }

  void interleavedPractice(){

    while(currStudyTaskList.isNotEmpty){

      printTaskTimeMap();
      printSubSessionsMap();
      printTaskList(currStudyTaskList);

      print("Here is the rotation list:");
      for(int i = 0; i < rotationList.length; i++) {
        print(rotationList[i].label);
      }

      currTask = currStudyTaskList[0];

      print("Max: ${max}");
      print("Session Counter ${sessionCounter}");
      print("The current time is \n ${currTime}");
      print("The current task I am looking at is ${currTask.label}");
      print("This value is less than 1: ${sessionsNeededMap[currTask]! <  1.0}");
      print("The amount of time left in the current session is ${remainingTime}");
      print("The amount of sessions that ${currTask.label} has left is ${sessionsNeededMap[currTask]}");
      print("___________________________________________");
      if(sessionCounter == max){
        if(othertasks.isEmpty){
          print("The other tasks are empty");
          currTime = currTime.add(Duration(minutes: workingtime));
          sessionCounter = 0;
        }
        else if(_checkIfTimeFits(DateTimeRange(start: currTime, end: currTime.add(Duration(minutes: othertasks[0].duration)))) == 0 ) {
          currTask = othertasks[0];
          print("Changed the current task to ${currTask.getLabel()} for now because we have hit the session counter and this tasks fits into the schedule : ${currTime.add(Duration(minutes: othertasks[0].duration)).isAfter(DateTime(2024, 8, 1, 7, 45))}");
          addToTaskTimeMap(currTask.duration);
          currTime = currTime.add(Duration(minutes: currTask.duration));
          othertasks.removeAt(0);
          sessionCounter = 0;
        }else{
          currTime = currTime.add(Duration(minutes: 15));
        }
      }
      else if(_checkIfTimeFits(DateTimeRange(start: currTime, end: currTime.add(Duration(minutes: workingtime + breaktime)))) == 0){
        int count = 0;

        for(int i = 0; i < rotationList.length; i++){
          currTask = rotationList[i];
          print(rotationList[i].label + "needs ${subSessionsNeededMap[rotationList[i]]} subsessions left. ");
          print("inside for loop");
          if((subSessionsNeededMap[rotationList[i]]!) > 1){
            print("inside if");
            addToTaskTimeMap(subtasktime);
            subSessionsNeededMap.update(rotationList[i], (value) => value - 1);
            currTime = currTime.add(Duration(minutes: subtasktime));
          }
          else if((subSessionsNeededMap[rotationList[i]]!) < 1){
            print("inside else if");

            addToTaskTimeMap(15);
            subSessionsNeededMap.remove(rotationList[i]);
            currStudyTaskList.remove(rotationList[i]);
            rotationList.remove(rotationList[i]);
            i--;
            count++;
            print("Incremented Count");
            for(int j = 0; j < currStudyTaskList.length; j++) {
              if(!(rotationList.contains(currStudyTaskList[j]))) {

                rotationList.insert(i, currStudyTaskList[j]);
                subSessionsNeededMap.update(rotationList[i], (value) => value - 0.5);
                addToTaskTimeMap(15);
                count--;
                i++;
                break;
              }
              //account for if there are no more tasks.
            }
            currTime = currTime.add(Duration(minutes: 15));
          }
          else{
            print("inside else");
            addToTaskTimeMap(subtasktime);
            subSessionsNeededMap.remove(rotationList[i]);
            currStudyTaskList.remove(rotationList[i]);
            rotationList.remove(rotationList[i]);
            i--;
            count++;
            print("Incremented Count");
            for(int j = 0; j < currStudyTaskList.length; j++) {
              if(!(rotationList.contains(currStudyTaskList[j]))) {
                i++;
                rotationList.insert(i, currStudyTaskList[j]);
                count--;

                break;
              }
            }
            currTime = currTime.add(Duration(minutes: subtasktime));
          }
        }
        if(rotationList.length < workingtime/subtasktime) {
          print(count);
          int diff = (workingtime/subtasktime).toInt() - rotationList.length - count;
          print("Here is the rotation list:");
          for(int i = 0; i < rotationList.length; i++) {
            print(rotationList[i].label);
          }
          print("Diff ${diff}");
          while(diff != 0) {
            if(rotationList.isEmpty){
              break;
            }
            for(int i = 0; i < rotationList.length; i++) {
              currTask = rotationList[i];
              print(rotationList[i].label);
              print(subSessionsNeededMap[rotationList[i]]);
              print("inside for loop");
              if((subSessionsNeededMap[rotationList[i]]!) > 1){
                print("inside if");
                addToTaskTimeMap(subtasktime);
                subSessionsNeededMap.update(rotationList[i], (value) => value - 1);
                currTime = currTime.add(Duration(minutes: subtasktime));
              }
              else if((subSessionsNeededMap[rotationList[i]]!) < 1){
                print("inside else if");
                addToTaskTimeMap(15);
                subSessionsNeededMap.remove(rotationList[i]);
                currStudyTaskList.remove(rotationList[i]);
                rotationList.remove(rotationList[i]);
                for(int j = 0; j < currStudyTaskList.length; j++) {
                  if(!(rotationList.contains(currStudyTaskList[j]))) {
                    rotationList.insert(i, currStudyTaskList[j]);
                    subSessionsNeededMap.update(rotationList[i], (value) => value - 0.5);
                    addToTaskTimeMap(15);
                    break;
                  }
                }
                currTime = currTime.add(Duration(minutes: 15));
              }
              else{
                print("inside else");
                addToTaskTimeMap(subtasktime);
                subSessionsNeededMap.remove(rotationList[i]);
                currStudyTaskList.remove(rotationList[i]);
                rotationList.remove(rotationList[i]);
                for(int j = 0; j < currStudyTaskList.length; j++) {
                  if(!(rotationList.contains(currStudyTaskList[j]))) {
                    rotationList.insert(i, currStudyTaskList[j]);
                    break;
                  }
                }
                currTime = currTime.add(Duration(minutes: subtasktime));
              }


              diff--;
              if(diff == 0) {
                break;
              }
            }
          }
        }

        currTask = Task(label: "Break");
        addToTaskTimeMap(breaktime);
        currTime = currTime.add(Duration(minutes: breaktime));
        sessionCounter++;
      }
      else{
        currTime = currTime.add(const Duration(minutes: 5));
        findNextAvailableTime();
      }
    }

    printTaskTimeMap();
  }

  void scheduleTime(){
    setFixedTasks();
    if(studyMethod == "Premack"){
      scheduleTimesBasedOnList(easyTasks);
      print("I FINISHED SCHEDULING THE EASY TASKS \n\n\n\n\n");
      scheduleTimesBasedOnList(mediumTasks);
      scheduleTimesBasedOnList(hardTasks);
      while(othertasks.isNotEmpty){
        currTask = othertasks[0];
        addToTaskTimeMap(othertasks[0].duration);
        othertasks.removeAt(0);
        currTime = currTime.add(Duration(minutes: currTask.duration));

      }
      if(currTime.isAfter(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 23, 58))){
        print("There are way too many tasks right now");
      }

    } else if(studyMethod == "Interleaved Practice") {
      interleavedPractice();
      while(othertasks.isNotEmpty){
        currTask = othertasks[0];
        addToTaskTimeMap(othertasks[0].duration);
        othertasks.removeAt(0);
        currTime = currTime.add(Duration(minutes: currTask.duration));
      }
    } else if(studyMethod == "Eat That Frog Technique") {
      scheduleTimesBasedOnList(hardTasks);
      scheduleTimesBasedOnList(mediumTasks);
      scheduleTimesBasedOnList(easyTasks);
      while(othertasks.isNotEmpty){
        currTask = othertasks[0];
        addToTaskTimeMap(othertasks[0].duration);
        othertasks.removeAt(0);
        currTime = currTime.add(Duration(minutes: currTask.duration));
      }
      if(currTime.isAfter(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 23, 58))){
        print("There are way too many tasks right now");
      }
    }else if(studyMethod == "ABCDE method"){
      currStudyTaskList.sort((a, b) => a.importanceLevel.compareTo(b.importanceLevel));
      scheduleTimesBasedOnList(currStudyTaskList);
      while(othertasks.isNotEmpty){
        currTask = othertasks[0];
        addToTaskTimeMap(othertasks[0].duration);
        othertasks.removeAt(0);
        currTime = currTime.add(Duration(minutes: currTask.duration));
      }
    }
  }

}













/*
 sessioncounter = 0
List otherTasks
List studyTask
List easyTasks
List mediumTasks
List hardTasks
Variable for workingtime #50/25/90
Variable for breaktime #20/5/30
Variable currtime = startTime
Task currTask = NULL
Map (task → double) sessionsNeededMap

Variable max = 0
if(workingtime = 50)
	Max = 3
}
else if(working time = 25){
    Max = 5
}
else{
    max = 2
}

#Helper Functions needed
#checkIfAllTasksAreDone(Map) → returns True/False depending if theyre all done
#findNextAvailableTime(DateTime) → finds the next time
#scheduleTasks based on difficulty(difficulty)  -> Function for the whole loop

#initializeVariables working time, breaktime, max based on study techniquies

def scheduleTime(){
    scheduleFixedTimes()
    if(studyMethod == "Premack"){
        while(checkIfAllTaskAreDone){
        	scheduleTimesBasedOnList(easyTasks)
        	scheduleTimesBasedOnList(mediumTasks)
        	scheduleTimesBasedOnList(hardTasks)
        }
    }
    ...etc
}


def scheduleTimesBasedOnList(List taskList){
    while(taskList is not empty){
		currTask = taskList[0]
		if(sessioncounter = max){
			Currtask = othertasks[0]
			Add to tasktimemap (curr.start, curr.end)
			othertasks.remove(0)
			Sessioncounter = 0
		}

		Else if(checkiftimerangefits(currtime, currtime + workingtime + breaktime){
			if(sessionsneededmap(currTask) < 1){
			    Remainingtime = workingtime
		        while(currTask.duration <= remainingtime ){                                                                                                                    z                                         workingtime
			       Remove currtask from map
			       addToTaskTimeMap(currtime, currtime + currTask.duration)
			       taskList.remove(0)
			       currtime = currtime + currTask.duration
			       Remainingtime -= sessionsneededmap(currentTask)* 60
        		   currTask = easyTask[0]
			    }
			    if(remainingtime != 0){
    			    addtoTaskTimeMap(currtime, currtime + remainingTime)
                    addtoTaskTimeMap(currtime + remainingTime, currtime + remainingTime +break)
    	            Currtime = currtime + remainingTime + breaktime
                    Subtract remaingtime/session length from sessionsneededmap for this task
				}
				else{
				    addToTaskTimeMap(curr, curr + break)
				}

			} else {

			    //adds the task to tasktime map
			    //subtracts 1 from the sessions needed map
            }
            Sessioncounter ++;
        }

        Else {
			currTime = findNextAvailableTime(currTime)
		}
	}
}
}

   */



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

/*

Interleaved Psudeocode

List<Task> currStudyTaskList = []; //initialize with study tasks
List<Task> othertasks = []; //initialize with other tasks
var workingtime = 50;
var breaktime = 20;
DateTime currTime = selectedWakeUp!;
var sessionCounter = 0;
Task currTask = Task();
Task newTask = Task();
var max = 0;
Map<Task, DateTimeRange> taskTimeMap = {};
Map<Task, double> subSessionsNeededMap = {};
var sessioncounter = 0;

var subtasktime;
if(workingtime == 30){
    subtasktime = 15;
}
else if(workingtime == 60){
    subtasktime = 15;
}
else if(workingtime == 90){
    subtasktime = 30;
}


List<Task> rotationList; //length of the list is workingtime/subtask
void initializeList(){
    int k = 0;
    while(k < workingtime/subtaskTime){
        rotationList.add(currStudyTaskList[k]);
        k++;
    }
}


void interleavedPractice(){
    while(currStudyTaskList.isNotEmpty){
        currTask = currStudyTaskList[0];
        if(sessioncounter == max){
            if(othertasks.isEmpty){
                currTime.add(Duration(minutes: workingtime));
            }
            else {
              currTask = othertasks[0];
              addToTaskTimeMap(currTask.duration);
              othertasks.removeAt(0);
              sessioncounter = 0;
            }
        }
        else if(_checkIfTimeFits(DateTimeRange(start: currTime, end: currTime.add(Duration(minutes: workingtime + breaktime)))) == 0){
            //this part keeps adding in tasks if there is extra time
            for(int i = 0; i < rotationList.length; i++){
                if(subSessionsNeededMap[rotationList[i]] > 1){
                    addToTaskTimeMap(rotationList[i].duration);
                    subSessionsNeededMap[rotationList[i]] -= 1;
                    currTime.add(Duration(minutes: subTaskTime));
                }
                else if(subSessionsNeededMap[rotationList[i]] < 1){
                    rotationList.remove(rotationList.get(i));
                    rotationList.add(currStudyTaskList[0], i);
                    subSessionsNeededMap[rotationList.get(i)] -= .5;
                    currTask = rotationList.get(i);
                    addToTaskTimeMap(15);
                    currTime.add(Duration(minutes: 15));
                }
                else{
                    addToTaskTimeMap(rotationList[i].duration);
                    subSessionsNeededMap.remove(rotationList.get(i))
                    rotationList.remove(rotationList.get(i));
                }
            }
            addToTaskTimeMap(breaktime);
            sessioncounter++;
        }
        else{
            currTime.add(const Duration(minutes:5));
            findNextAvailableTime();
        }
    }
}
 */