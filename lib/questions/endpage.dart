import 'package:flutter/material.dart';
import 'package:ran_app/homepage/homepage.dart';

class EndPage extends StatelessWidget {
  const EndPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("End Page"),
      ),
      body: Column(
        children:[
          Expanded(
            flex: 5,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Center(
                child: Text("Quiz Complete"),
              ),
            ),
          ),
          ElevatedButton(
          child: const Text('Go to Schedule'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MyHomePage()),
            );
          },
        ),
      ],
      ),
    );
  }
}