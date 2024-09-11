import 'package:flutter/material.dart';
import 'package:ran_app/questions/quiz.dart';
import 'package:ran_app/questions/endpage.dart';
import 'package:ran_app/settings/change_split_page.dart';
import 'package:ran_app/settings/change_work_page.dart';
import 'package:ran_app/settings/help.dart';
import 'package:flutter/cupertino.dart';
import 'package:ran_app/questions/question11.dart';



class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: ListView(
            children: [
              _CustomListTile(
                  title: "Adjustments",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ModificationsPage()),
                    );
                  }),
              _CustomListTile(
                  title: "Notifications",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NotificationsPage()),
                    );
                  }),
              _CustomListTile(
                  title: "About Us Page",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AboutUsPage()),
                    );
                  }),
              _CustomListTile(
                  title: "Our Mission",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const OurMission()),
                    );
                  }),
              _CustomListTile(
                  title: "Help",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HelpPage()),
                    );
                  }),
          ],
          )
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

class ModificationsPage extends StatelessWidget {
  const ModificationsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[900],
        foregroundColor: Colors.white,
        title: const Text('Modifications Page'),
      ),
      body: Center(
        child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            child: ListView(
              children: [
                _CustomListTile(
                    title: "Retake Personalized Quiz",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => QuizApp()
                        ),
                      );
                    }
                ),
                _CustomListTile(
                    title: "Change Split",

                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChangeSplitPage()),
                      );
                    }),
                _CustomListTile(
                    title: "Change Work Technique",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChangeWorkPage()),
                      );
                    }),
                _CustomListTile(
                  title: "Change Start Time",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EleventhQuestion(),
                      ),
                    );
                  },
                ),
              ],
            )
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

class _CustomListTile extends StatelessWidget {
  final String title;
  final Function() onTap;

  const _CustomListTile(
      {Key? key, required this.title,  required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white, // White background
      margin: const EdgeInsets.symmetric(vertical: 1), // Margin around the tile
      child: ListTile(
        title: Text(
          textAlign: TextAlign.center,
          title,
          style: TextStyle(fontSize: 16.0, color: Colors.teal), // Green text
        ),

        onTap: onTap,
      ),
    );
  }
}
