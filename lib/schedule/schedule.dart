import 'package:flutter/material.dart';
import 'package:ran_app/schedule/task.dart';
import 'package:ran_app/schedule/taskpage.dart';
import 'package:time_range/time_range.dart';
import 'package:ran_app/questions/question11.dart';


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

  List<Task> currStudyTaskList = [];

  List<Task> easyTasks = [];
  List<Task> mediumTasks = [];
  List<Task> hardTasks = [];
  List<Task> othertasks = [];
  var workingtime = 50;
  var breaktime = 20;
  DateTime currTime = selectedWakeUp!;
  var sessionCounter = 0;
  Task currTask = Task();
  var max = 0;

  //adds tasks to currTaskList
  void setTasks(List<Task> taskList){
    for(int i = 0; i < taskList.length; i++){
      currTaskList.add(taskList[i]);
      print(currTaskList[i].getLabel());
    }
  }

  void initializeTasks(){
    //adds the study and other tasks
    for(int i = 0; i < currTaskList.length; i++){
      print("This is the area of the" + (i+1).toString() + "th task: " + currTaskList[i].area);
      if(currTaskList[i].area == 'Study'){
        currStudyTaskList.add(currTaskList[i]);
      }
      else{
        othertasks.add(currTaskList[i]);
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
      }
      else{
        hardTasks.add(currStudyTaskList[i]);
      }
    }
    for(int i = 0; i < easyTasks.length; i++){
      print("This is the " + (i+1).toString() + "easy task: " + easyTasks[i].getLabel());
    }

    for(int i = 0; i < currStudyTaskList.length; i++){
      sessionsNeededMap[currStudyTaskList[i]] = (currStudyTaskList[i].duration)/stringToInt(workingMethod);
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
      if (task.preferredTimeOfTask == 'Fixed Time') {
        taskTimeMap[task] = DateTimeRange(start: task.fixedTime!, end: task.fixedTime!.add(Duration(minutes: task.duration)));
      }
    }
  }


  int _checkIfTimeFits(DateTimeRange newRange){
    if(currTime.hour > 23){
      return 2;
    }
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
  void findNextAvailableTime(){
    while(_checkIfTimeFits(DateTimeRange(start: currTime, end: currTime)) == 1){
      currTime.add(const Duration(minutes: 5));
    }
  }

  void addToTaskTimeMap(int duration){
    Task newTask =  Task(
    area: currTask.area,
    label: currTask.label,
    duration: currTask.duration,
    preferredTimeOfTask: currTask.preferredTimeOfTask,
    difficultyOfTask:  currTask.difficultyOfTask,
    fixedTime: currTask.fixedTime,
    importanceLevel: currTask.importanceLevel,
    );
    taskTimeMap[newTask] = DateTimeRange(start: currTime, end: currTime.add(Duration(minutes: duration)));
  }

  void printTaskList(){
    for(int i = 0; i < currTaskList.length; i++){
      print(currTaskList[i].getLabel());
    }
  }

  var sessioncounter = 0;
  void scheduleTimesBasedOnList(List<Task> taskList){
    while(taskList.isNotEmpty){
      for(int i = 0; i < taskList.length; i++){
        print(taskList[i].getLabel());
      }
      printTaskList();
      currTask = taskList[0];
      if(true){
        taskList.removeRange(0, taskList.length-1);
        break;
      }
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
      else if(_checkIfTimeFits(DateTimeRange(start: currTime, end: currTime.add(Duration(minutes:currTask.duration)))) != 0){
        if(sessionsNeededMap[currTask]! < 1){
          var remainingTime = workingtime;
          while(currTask.duration <= remainingTime){

            sessionsNeededMap.remove(currTask);

            addToTaskTimeMap(currTask.duration);
            taskList.removeAt(0);
            currTime.add(Duration(minutes: currTask.duration));
            remainingTime -= sessionsNeededMap[currTask]!.toInt() * 60;
            currTask = easyTasks[0];
          }
          if(remainingTime != 0){
            addToTaskTimeMap(currTask.duration + remainingTime);
            currTime.add(Duration(minutes: remainingTime));
            addToTaskTimeMap(remainingTime +breaktime);
            currTime.add(Duration(minutes: breaktime));
            sessionsNeededMap.update(currTask, (value) => value - remainingTime/workingtime);
          }
          else{
            addToTaskTimeMap(breaktime);
          }
        }
        else {
          sessionsNeededMap.update(currTask, (value) => value + 1);
          addToTaskTimeMap(currTask.duration);
        }
        sessioncounter+=1;
      }
      else {
        currTime.add(const Duration(minutes:5));
        findNextAvailableTime();
      }
    }

  }
  void scheduleTime(){
    setFixedTasks();
    if(studyMethod == "Premack"){
      while(sessionsNeededMap.isNotEmpty){
        scheduleTimesBasedOnList(easyTasks);
        scheduleTimesBasedOnList(mediumTasks);
        scheduleTimesBasedOnList(hardTasks);
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