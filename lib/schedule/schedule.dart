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
  List<Task> currStudyTaskList = [];

  List easyTasks;
  List mediumTasks;
  List hardTasks;
  List otherTasks = [];
  var workingtime;
  var breaktime;
  var currtime = startTime;
  var sessionCounter = 0;
  Task currTask = null;
  var max = 0;


  while(findEasyTask() != null){
    easyTasks.add(findEasyTask());
  }
  while(findMediumTask() != null){
    mediumTasks.add(findMediumTask());
  }
  while(findHardTask() != null){
    hardTasks.add(findHardTask());
  }

  for(int i = 0; i < currTaskList.length; i++){
    if(currTaskList[i].area == 'Study'){
      currStudyTaskList.add(currTaskList[i]);
    }
    else{
      otherTasks.add(currTaskList[i]);
    }
  }

  Map<Task, DateTimeRange> taskTimeMap = {};
  Map<Task, double> sessionsNeededMap = {};
  for(int i = 0; i < studyTasks.length; i++){
    sessionsNeeded[studyTasks[i]] = studyTasks[i].duration/workingtime);
  }

  void initializeList(List<Task> taskList) {
    currTaskList.addAll(taskList);
  }


  List<Task> findEasyTasks() {
    List<Task> easyTask = {};
    for (int i = 0; i < currStudyTaskList.length; i++) {
      if (currStudyTaskList[i].difficultyOfTask == 'Easy') {
        easyTask.add(currStudyTaskList[i]);
      }
    }
    return easyTask;
  }

  Task? findMediumTask() {
    for (int i = 0; i < currStudyTaskList.length; i++) {
      if (currStudyTaskList[i].difficultyOfTask == 'Medium') {
        return currStudyTaskList[i];
      }
    }
    return null;
  }

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
        taskTimeMap[task] = DateTimeRange(start: task.fixedTime!, end: task.fixedTime!.add(Duration(minutes: stringToInt(task.duration))));
      }
    }
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
  void findNextAvailableTime(){
    while(checkIfTimeFits(new DateTimeRange(currTime, currTime)) == 1){
      currTime.add(const Duration(minutes: 5);
    }
  }

  void scheduleTimesBasedOnList(List<Task> taskList){
    while(taskList.isEmpty() == false){
      currTask = taskList[0];
      if(sessioncounter = max){
        currTask = othertasks[0];
        count = 0;
        newTask = Task(
          area: currTask.area,
          label: currTask.label,
          duration: currTask.duration,
          preferredTimeOfTask: currTask.preferredTimeOfTask,
          difficultyOfTask:  currTask.difficultyOfTask,
          fixedTime: currTask.fixedTime,
          importanceLevel: currTask.importanceLevel,
        );
        othertasks.remove(0);
        sessioncounter = 0;
      }
      else if(checkiftimerangefits(currtime, currtime + workingtime + breaktime){
        if(sessionsneededmap(currTask) < 1){
          remainingtime = workingtime;
          while(currTask.duration <= remainingtime){                                                                                                                    z                                         workingtime
            sessionsNeededMap.remove(currTask);
            addToTaskTimeMap(currtime, currtime + currTask.duration);
            taskList.remove(0);
            currtime = currtime + currTask.duration;
            remainingtime -= sessionsneededmap[currentTask] * 60;
            currTask = easyTask[0];
          }
          if(remainingtime != 0){
            addtoTaskTimeMap(currtime, currtime + remainingTime);
            addtoTaskTimeMap(currtime + remainingTime, currtime + remainingTime +breaktime);
            currtime = currtime + remainingTime + breaktime;
            sessionsneededMap[currentTask] -= remainingTime/workingtime;
          }
          else{
            newTask = Task(
            area: currTask.area,
            label: currTask.label,
            duration: currTask.duration,
            preferredTimeOfTask: currTask.preferredTimeOfTask,
            difficultyOfTask:  currTask.difficultyOfTask,
            fixedTime: currTask.fixedTime,
            importanceLevel: currTask.importanceLevel,
            );
            taskTimeMap[newTask] = new DateTimeRange(currTime, currTime + newTask.duration);
          }
        }
        else {
          sessionsNeededMap[currTask] -= 1;
          newTask = Task(
            area: currTask.area,
            label: currTask.label,
            duration: currTask.duration,
            preferredTimeOfTask: currTask.preferredTimeOfTask,
            difficultyOfTask:  currTask.difficultyOfTask,
            fixedTime: currTask.fixedTime,
            importanceLevel: currTask.importanceLevel,
          );
        }
        sessioncounter+=1;
      }
      else {
        findNextAvailableTime();
      }
    }
  }
}
  void scheduleTime(){
    scheduleFixedTimes();
    if(studyMethod == "Premack"){
      while(checkIfAllTaskAreDone){
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