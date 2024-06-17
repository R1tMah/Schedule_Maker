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
  Map<String, dynamic> toJson() => {
    'title': label,
    'area': area,
    'duration': duration,
    'preftime': preferredTimeOfTask,
    'difficulty': difficultyOfTask,
  };

  static Task fromJson(Map<String, dynamic> json) {
    return Task(
      label: json['title'],
      area: json['area'],
      duration: json['duration'],
      preferredTimeOfTask: json['preftime'],
      difficultyOfTask: json['difficulty'],


    );


  }

   */
}