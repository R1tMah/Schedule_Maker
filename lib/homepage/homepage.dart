import 'package:flutter/material.dart';
import 'package:ran_app/settings/settings.dart';
import 'package:ran_app/homepage/history.dart';
import 'package:ran_app/reminders/reminderspage.dart';
import 'package:ran_app/schedule/schedulepage.dart';
import 'package:ran_app/schedule/scheduletest.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  final List<Widget> _pages = <Widget>[
    ScheduleHomePageState(),
    RemindersPage(),
    HistoryPage(),
    SettingsPage(),
    ScheduleTestPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[900],
        title: Text(_getAppBarTitle(_selectedIndex)),
        foregroundColor: Colors.white,
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
            // sets the background color of the `BottomNavigationBar`
            canvasColor: Colors.brown[50],
            // sets the active color of the `BottomNavigationBar` if `Brightness` is light
            primaryColor: Colors.red,
            textTheme: Theme.of(context)
                .textTheme
                .copyWith(bodySmall: new TextStyle(color: Colors.yellow))),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today, color: Colors.teal),
              label: 'Schedule',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications, color: Colors.teal),
              label: 'Reminders',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history, color: Colors.teal),
              label: 'History',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings, color: Colors.teal),
              label: 'Settings',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings, color: Colors.teal),
              label: 'Schedule Test',
            ),
          ],
          currentIndex: _selectedIndex,
          fixedColor: Colors.teal[900],
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  String _getAppBarTitle(int index) {
    switch (index) {
      case 0:
        return 'Schedule';
      case 1:
        return 'Reminders';
      case 2:
        return 'History';
      case 3:
        return 'Settings';
      case 4:
        return 'Schedule Test';
      default:
        return 'Flutter Demo';
    }
  }
}
