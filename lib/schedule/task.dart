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
    if(fixedTime == DateTime(0) || fixedTime == null){
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



}