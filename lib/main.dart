import 'package:flutter/material.dart';



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
      home: const MyHomePage(),
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
        return 'Remindersjjj';
      case 2:
        return 'History';
      case 3:
        return 'Settings';
      default:
        return 'Flutter Demo';
    }
  }
}

class SchedulePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
          'Schedule Page',
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
              // Action for Retake personalized quiz
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RetakePersonalizedQuizPage()),
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
            child: Text('Notifimktions'),
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
                MaterialPageRoute(builder: (context) => HelpPage()),
              );
              // Action for Help
            },
            child: Text('Help'),
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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  QuizApp()),
            );
          },
          child: const Text('Back to Settings'),
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
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Back to Settings'),
        ),
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
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Back to Settings'),
        ),
      ),
    );
  }
}
class HelpPage extends StatelessWidget {
  const HelpPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Back to Settings'),
        ),
      ),
    );
  }
}


class QuizApp extends StatefulWidget {
  @override
  _QuizAppState createState() => _QuizAppState();
}// A State created by StatefulWidget to be displayed on screen.

class _QuizAppState extends State<QuizApp>{
  Widget build(BuildContext context){
    return Column(//Column contains question section, true-false buttons and scorecard (Row).
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child:
              Text("I am a ... "),
            ),// Question section is styled by wrapping it in Center,Padding and Expanded widgets.
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: ElevatedButton(
              child: Text('True'),
              onPressed: () {/*Functionality what to do when button is pressed*/},
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: ElevatedButton(
              child: Text('False'),
              onPressed: () {/*Functionality what to do when button is pressed*/},
            ),
          ),
        ),
        Expanded(
          child: Row(// Scorecard to maintain user's result
            children: <Widget>[
              Icon(Icons.check, color: Colors.green),//For correct response
              Icon(Icons.close, color: Colors.red),// For wrong response
            ],
          ),
        )
      ],
    );
  }
}

/*
class Question {
  String qText;
  bool qAns;

  Question(this.qText, this.qAns); // Constructor used to create an object of 'Question' datatype.
}//Question is now a user-defined datatype used to store Q&A.

class QuizBrain {
  int _qNo = 0;//To store the current question number.

  List<Question> _questions = [
    Question(
        'You should maintain at least 1 metre distance between yourself and anyone who is coughing or sneezing.',
        true),
    Question(
        'It is safe to shake hands with your neighbours as you know them well.',
        false),
    Question('Covid-19 virus can spread through droplets in air.', true),
  ];//The actual database of Q&A. It is a list of 'Question' datatype objects.

  void nextQuestion() {
    if (_qNo < _questions.length - 1) _qNo++;
  }// It updates current question number to the next question number.

  String getQuestion() {
    return _questions[_qNo].qText;
  }// It retrieves the current question from database to display on the screen.

  bool getAnswer() {
    return _questions[_qNo].qAns;
  }// It retrieves the correct answer corresponding to current question to validate user's choice.

  int getCountOfQuestions() {
    return _questions.length;
  }// It retrieves total number of questions to dispaly in result page.

  bool isFinished() {
    if (_qNo == _questions.length - 1)
      return true;
    else
      return false;
  }// It checks if the questions in the database are completed.

  void reset() {
    _qNo = 0;
  }// It resets the quiz, after completing display of all questions.
}
*/
