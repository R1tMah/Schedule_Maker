import 'package:flutter/material.dart';

var firstTime = 1;
var name = '';

/*
COMMENTS FOR CHANGE:
ADDED A QUESTION FOR THE QUIZ BUT NEED TO FIGURE OUT HOW TO STORE THE DIFFERENT
QUESTIONS WITHIN THE APP AND NEED TO FIND A WAY TO CHANGE THE SCREEN AND SEE IF QUESTIONS ARE RIGHT
*/
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  //Color myPrimaryColor = Colors.blue; // Define a primary color swatch
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(// Define a primary color swatch
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.teal),
        scaffoldBackgroundColor: Colors.teal[900],
        useMaterial3: true,
      ),
      home: const NameInputPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  final List<Widget> _pages = <Widget>[
    SchedulePage(),
    RemindersPage(),
    HistoryPage(),
    SettingsPage(),
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
            textTheme: Theme
                .of(context)
                .textTheme
                .copyWith(bodySmall: new TextStyle(color: Colors.yellow))),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today,
                  color: Colors.teal),
              label: 'Schedule',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications,
                  color: Colors.teal),
              label: 'Reminders',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history,
                  color: Colors.teal),
              label: 'History',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings,
                  color: Colors.teal),
              label: 'Settings',
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
      default:
        return 'Flutter Demo';
    }
  }
}


class NameInputPage extends StatefulWidget {
  const NameInputPage({Key? key}) : super(key: key);

  @override
  _NameInputPageState createState() => _NameInputPageState();
}

class _NameInputPageState extends State<NameInputPage> {
  TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[900],
        title: const Text('Enter Your Name'),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              style: TextStyle(
                color: Colors.white
              ),
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                labelStyle: TextStyle(
                  color: Colors.white
                ),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Get the entered name
                name = _nameController.text;
                // Call the callback function to pass the name to the parent widget
                firstTime = 0;
                // Navigate back
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyHomePage()),
                );
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

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



class RemindersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
          'Reminders Page',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('History Page',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}



class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => QuizApp()),
              );
            },
            child: Text('Retake personalized quiz'),
          ),
          SizedBox(height: 50),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationsPage()),
              );
              // Action for Notifications
            },
            child: Text('Notification'),
          ),
          SizedBox(height: 50),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutUsPage()),
              );
              // Action for About Us
            },
            child: Text('About Us'),
          ),
          SizedBox(height: 50),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OurMission()),
              );
              // Action for Help
            },
            child: Text('Our Mission'),
          ),
        ],
      ),
    );
  }
}

class RetakePersonalizedQuizPage extends StatelessWidget {
  const RetakePersonalizedQuizPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Retake Personalized Quiz'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {

          },
          child: const Text('Retake Personalized Quiz'),
        ),
      ),
    );
  }
}

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications Page'),
      ),
      body: Center(
        ),
    );
  }
}

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us Page'),
      ),
      body: Center(
        ),
    );
  }
}
class OurMission extends StatefulWidget {
  const OurMission({Key? key}) : super(key: key);

  @override
  _OurMissionState createState() => _OurMissionState();
}

class _OurMissionState extends State<OurMission> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 500), // Set animation duration
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward(); // Start the animation
  }
  @override
  void dispose() {
    _controller.dispose(); // Dispose the animation controller
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Our Mission'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FadeTransition(
                opacity: _animation, // Apply the animation to the opacity property
                child: Text(
                  'About Our Mission',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              FadeTransition(
                opacity: _animation, // Apply the animation to the opacity property
                child: Text(
                  'At Schedule Maker, we aim to...',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16.0, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}




class QuizApp extends StatefulWidget {
  @override
  _QuizAppState createState() => _QuizAppState();
}// A State created by StatefulWidget to be displayed on screen.

class _QuizAppState extends State<QuizApp> {
  String? _selectedOption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Center(
                child: Text("I spend __ hours on my phone"),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: ElevatedButton(
                child: Text('1-3'),
                onPressed: () {
                  setState(() {
                    _selectedOption = '1-3';
                  });
                  _navigateToSecondPage(context);
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: ElevatedButton(
                child: Text('4-6'),
                onPressed: () {
                  setState(() {
                    _selectedOption = '4-6';
                  });
                  _navigateToSecondPage(context);
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: ElevatedButton(
                child: Text('7-9'),
                onPressed: () {
                  setState(() {
                    _selectedOption = 'High School Student';
                  });
                  _navigateToSecondPage(context);
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: ElevatedButton(
                child: Text('9+'),
                onPressed: () {
                  setState(() {
                    _selectedOption = 'Teacher';
                  });
                  _navigateToSecondPage(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }



  void _navigateToSecondPage(BuildContext context) {
    Future.delayed(Duration(milliseconds: 500), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  SecondQuestion()),
      );
    });
  }
}

class SecondQuestion extends StatefulWidget {
  @override
  SecondQuestionState createState() => SecondQuestionState();
}// A State created by StatefulWidget to be displayed on screen.

class SecondQuestionState extends State<SecondQuestion> {
  String? _selectedOption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Center(
                child: Text("Do you take breaks when you do work"),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: ElevatedButton(
                child: Text('College Student'),
                onPressed: () {
                  setState(() {
                    _selectedOption = 'College Student';
                  });
                  _navigateToThirdPage(context);
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: ElevatedButton(
                child: Text('College Student'),
                onPressed: () {
                  setState(() {
                    _selectedOption = 'College Student';
                  });
                  _navigateToThirdPage(context);
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: ElevatedButton(
                child: Text('High School Student'),
                onPressed: () {
                  setState(() {
                    _selectedOption = 'High School Student';
                  });
                  _navigateToThirdPage(context);
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: ElevatedButton(
                child: Text('Teacher'),
                onPressed: () {
                  setState(() {
                    _selectedOption = 'Teacher';
                  });
                  _navigateToThirdPage(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }



  void _navigateToThirdPage(BuildContext context) {
    Future.delayed(Duration(milliseconds: 500), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  ThirdQuestion()),
      );
    });
  }
}


class ThirdQuestion extends StatefulWidget {
  @override
  ThirdQuestionState createState() => ThirdQuestionState();
}// A State created by StatefulWidget to be displayed on screen.

class ThirdQuestionState extends State<ThirdQuestion> {
  String? _selectedOption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Center(
                child: Text("Do you have anxiety"),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: ElevatedButton(
                child: Text('College Student'),
                onPressed: () {
                  setState(() {
                    _selectedOption = 'College Student';
                  });
                  _navigateToFourthPage(context);
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: ElevatedButton(
                child: Text('College Student'),
                onPressed: () {
                  setState(() {
                    _selectedOption = 'College Student';
                  });
                  _navigateToFourthPage(context);
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: ElevatedButton(
                child: Text('High School Student'),
                onPressed: () {
                  setState(() {
                    _selectedOption = 'High School Student';
                  });
                  _navigateToFourthPage(context);
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: ElevatedButton(
                child: Text('Teacher'),
                onPressed: () {
                  setState(() {
                    _selectedOption = 'Teacher';
                  });
                  _navigateToFourthPage(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }



  void _navigateToFourthPage(BuildContext context) {
    Future.delayed(Duration(milliseconds: 500), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  FourthQuestion()),
      );
    });
  }
}

class FourthQuestion extends StatefulWidget {
  @override
  FourthQuestionState createState() => FourthQuestionState();
}// A State created by StatefulWidget to be displayed on screen.

class FourthQuestionState extends State<FourthQuestion> {
  String? _selectedOption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Center(
                child: Text("Motivation Question 1"),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: ElevatedButton(
                child: Text('College Student'),
                onPressed: () {
                  setState(() {
                    _selectedOption = 'College Student';
                  });
                  _navigateToFifthPage(context);
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: ElevatedButton(
                child: Text('College Student'),
                onPressed: () {
                  setState(() {
                    _selectedOption = 'College Student';
                  });
                  _navigateToFifthPage(context);
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: ElevatedButton(
                child: Text('High School Student'),
                onPressed: () {
                  setState(() {
                    _selectedOption = 'High School Student';
                  });
                  _navigateToFifthPage(context);
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: ElevatedButton(
                child: Text('Teacher'),
                onPressed: () {
                  setState(() {
                    _selectedOption = 'Teacher';
                  });
                  _navigateToFifthPage(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }



  void _navigateToFifthPage(BuildContext context) {
    Future.delayed(Duration(milliseconds: 500), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  FifthQuestion()),
      );
    });
  }
}


class FifthQuestion extends StatefulWidget {
  @override
  FifthQuestionState createState() => FifthQuestionState();
}// A State created by StatefulWidget to be displayed on screen.

class FifthQuestionState extends State<FifthQuestion> {
  String? _selectedOption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Center(
                child: Text("Motivation Question 2"),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: ElevatedButton(
                child: Text('College Student'),
                onPressed: () {
                  setState(() {
                    _selectedOption = 'College Student';
                  });
                  _navigateToSixthPage(context);
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: ElevatedButton(
                child: Text('College Student'),
                onPressed: () {
                  setState(() {
                    _selectedOption = 'College Student';
                  });
                  _navigateToSixthPage(context);
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: ElevatedButton(
                child: Text('High School Student'),
                onPressed: () {
                  setState(() {
                    _selectedOption = 'High School Student';
                  });
                  _navigateToSixthPage(context);
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: ElevatedButton(
                child: Text('Teacher'),
                onPressed: () {
                  setState(() {
                    _selectedOption = 'Teacher';
                  });
                  _navigateToSixthPage(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }



  void _navigateToSixthPage(BuildContext context) {
    Future.delayed(Duration(milliseconds: 500), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  SixthQuestion()),
      );
    });
  }
}


class SixthQuestion extends StatefulWidget {
  @override
  SixthQuestionState createState() => SixthQuestionState();
}// A State created by StatefulWidget to be displayed on screen.

class SixthQuestionState extends State<SixthQuestion> {
  String? _selectedOption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Center(
                child: Text("Overthinking Question 1"),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: ElevatedButton(
                child: Text('College Student'),
                onPressed: () {
                  setState(() {
                    _selectedOption = 'College Student';
                  });
                  _navigateToSixthPage(context);
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: ElevatedButton(
                child: Text('College Student'),
                onPressed: () {
                  setState(() {
                    _selectedOption = 'College Student';
                  });
                  _navigateToSixthPage(context);
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: ElevatedButton(
                child: Text('High School Student'),
                onPressed: () {
                  setState(() {
                    _selectedOption = 'High School Student';
                  });
                  _navigateToSixthPage(context);
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: ElevatedButton(
                child: Text('Teacher'),
                onPressed: () {
                  setState(() {
                    _selectedOption = 'Teacher';
                  });
                  _navigateToSixthPage(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }



  void _navigateToSixthPage(BuildContext context) {
    Future.delayed(Duration(milliseconds: 500), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  SixthQuestion()),
      );
    });
  }
}

