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
      });


  String label;
  String area;
  Color background;
  String duration;
  String preferredTimeOfTask;
  String difficultyOfTask;

  void setArea(String area){
    this.area = area;
  }
  String getLabel(){
    return this.label;
  }
  void setLabel(String label){
    this.label = label;
  }

  Color chooseBackGround(List<Color> colorList){
    Color currentCol = Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
    while(colorList.contains(currentCol) != true){
      currentCol = Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
    }
    return currentCol;
  }


  void setDuration(String duration){
    this.duration = duration;
  }

  void setPreferredTime(String pt){
    preferredTimeOfTask = pt;
  }
  void setDifficulty(String diff){
    difficultyOfTask = diff;
  }

}