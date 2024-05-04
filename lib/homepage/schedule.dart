import 'package:flutter/material.dart';
import 'package:ran_app/homepage/name_input.dart';
class SchedulePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Hello, ' + name + ', Schedule Page',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}