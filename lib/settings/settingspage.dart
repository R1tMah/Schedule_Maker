import 'package:flutter/material.dart';
import 'package:ran_app/questions/quiz.dart';
import 'package:ran_app/questions/endpage.dart';
import 'package:ran_app/settings/change_split_page.dart';
import 'package:ran_app/settings/help.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
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
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChangeSplitPage()),
                );
              },
              child: Text('Change Split'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationsPage()),
                );
              },
              child: Text('Notifications'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutUsPage()),
                );
              },
              child: Text('About Us'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OurMission()),
                );
              },
              child: Text('Our Mission'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HelpPage()),
                );
              },
              child: Text('Help'),
            ),
          ],
        ),
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
          onPressed: () {},
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
      body: Center(),
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
      body: Center(),
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
              Expanded(
                child: SingleChildScrollView(
                  child: FadeTransition(
                    opacity: _animation, // Apply the animation to the opacity property
                    child: Text(
                      'As college students, we frequently encountered the frustration of setting out to accomplish a list of tasks each day, only to fall short of our goals. We soon realized that this is a common struggle shared by many, especially among students like us. Recognizing this widespread challenge inspired us to create an app that could help people manage their tasks more effectively.\n\nFrom the inception of this idea, we were filled with excitement and determination. Developing the app, however, was no easy feat. We faced numerous obstacles along the way, from technical difficulties to balancing our academic responsibilities. Yet, our passion for solving this problem and our commitment to helping others kept us driven and focused.\n\nThroughout the development process, we learned a great deal and grew both as individuals and as a team. We pushed through the tough times, fueled by the vision of creating a tool that could make a real difference in people’s lives.\n\nNow that the app is complete and available to the public, we feel an immense sense of pride and accomplishment. Seeing our hard work come to fruition and knowing it has the potential to help others is incredibly rewarding.\n\nWe sincerely hope that this app reaches a wide audience and provides the support that many need to organize their tasks and achieve their goals. Our ultimate aim is to make a positive impact and improve lives around the world through this app.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16.0, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
