//Object class for a task
import 'package:flutter/material.dart';
import 'dart:math' as math;
class Task{
  Task({
    this.area = "", //1 Study, 2
    this.label = "",
    this.background = Colors.red,
    this.duration = "",
    this.preferredTimeOfTask = "",
    this.difficultyOfTask = "",
    this.fixedTime,
    this.importanceLevel = 1,
      });


  String label;
  String area;
  Color background;
  String duration;
  String preferredTimeOfTask;
  String difficultyOfTask;
  DateTime? fixedTime;
  int importanceLevel;

  void setArea(String area){
    this.area = area;
  }
  String getLabel(){
    return label;
  }
  void setLabel(String label){
    this.label = label;
  }

  Color chooseBackGround(List<Color> colorList) {
    Color currentCol = Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
    if (colorList.contains(currentCol)) {
      return chooseBackGround(colorList);
    }
    colorList.add(currentCol);
    return currentCol;
  }
  /*


   */

  void setDuration(String duration){
    this.duration = duration;
  }

  void setPreferredTime(String pt){
    preferredTimeOfTask = pt;
  }
  void setDifficulty(String diff){
    difficultyOfTask = diff;
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
}