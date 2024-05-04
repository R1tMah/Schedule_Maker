import 'package:flutter/material.dart';
import 'package:ran_app/questions/quiz.dart';

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