//Object class for a task
import 'package:flutter/material.dart';
import 'dart:math' as math;
class Task{
  Task({
    this.area = "", //1 Study, 2
    this.label = "",
    this.background = Colors.red,
    this.duration = 0,
    this.preferredTimeOfTask = "",
    this.difficultyOfTask = "",
    this.fixedTime,
    this.importanceLevel = 1,
      });


  String label;
  String area;
  Color background;
  int duration;
  String preferredTimeOfTask;
  String difficultyOfTask;
  DateTime? fixedTime;
  int importanceLevel;



  bool isFixedTime(){
    if(preferredTimeOfTask == "Not Fixed Time" || fixedTime == null){
      return false;
    }else{
      return true;
    }
  }
  void setArea(String area){
    this.area = area;
  }
  String getLabel(){
    return label;
  }
  String getArea(){
    return area;
  }
  void setLabel(String label){
    this.label = label;
  }
  void setBackGround(Color color){
    this.background = color;
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

  void setDuration(int duration){
    this.duration = duration;
  }

  void setPreferredTime(String pt){
    preferredTimeOfTask = pt;
  }
  void setDifficulty(String diff){
    difficultyOfTask = diff;
  }


  // Convert Task to a JSON-compatible map
  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'area': area,
      'background': background.value, // Convert Color to int
      'duration': duration,
      'preferredTimeOfTask': preferredTimeOfTask,
      'difficultyOfTask': difficultyOfTask,
      'fixedTime': fixedTime?.toIso8601String(), // Convert DateTime to String
      'importanceLevel': importanceLevel,
    };
  }

  // Create a Task from a JSON-compatible map
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      label: json['label'],
      area: json['area'],
      background: Color(json['background']), // Convert int to Color
      duration: json['duration'],
      preferredTimeOfTask: json['preferredTimeOfTask'],
      difficultyOfTask: json['difficultyOfTask'],
      fixedTime: json['fixedTime'] != null
          ? DateTime.parse(json['fixedTime'])
          : null, // Convert String to DateTime
      importanceLevel: json['importanceLevel'],
    );
  }
}