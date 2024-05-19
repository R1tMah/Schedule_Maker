import 'package:flutter/material.dart';
import 'package:ran_app/homepage/name_input.dart';


class ScheduleHomePageState extends StatefulWidget {
  @override
  SchedulePage createState() => SchedulePage();
}// A State created by StatefulWidget to be displayed on screen.


class SchedulePage extends  State<ScheduleHomePageState>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget> [
          Expanded(
            flex: 5,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Center(
                child: Text( 'Hello, ' + name + ', Schedule Page',style: TextStyle(color: Colors.white),)
              )
            )
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: ElevatedButton(
                child: Text('Enter Tasks'),
                onPressed: () {
                    setState(() {

                    });
                },
              ),
            ),
          ),
        ]
      )
    );
  }
}