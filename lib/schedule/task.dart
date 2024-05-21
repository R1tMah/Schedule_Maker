//Object class for a task
import 'package:flutter/material.dart';
import 'dart:math';
class Task{
  Task({
    this.area = "", //1 Study, 2
    this.label = "",
    this.background = Colors.red,
    this.duration = 0,
    this.preferredTimeOfTask = "",
    this.difficultyOfTask = "",
      });


  String label;
  String area;
  Color background;
  int duration;
  String preferredTimeOfTask;
  String difficultyOfTask;

  void setArea(String area){
    this.area = area;
  }

  void setLabel(String label){
    this.label = label;
  }

  void chooseBackGround(List<Color> colors){
    if(difficultyOfTask == Null){
      return;
    }
    if(difficultyOfTask == "Easy"){
      background = Colors.green;
    }
    if(difficultyOfTask == "Medium"){
      background = Colors.yellow;
    }
    if(difficultyOfTask == "Hard"){
      background = Colors.red;
    }
  }


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