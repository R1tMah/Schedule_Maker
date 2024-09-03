import 'package:flutter/material.dart';

class HelpPage extends StatefulWidget {
  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Schedule'),
            Tab(text: 'Reminders'),
            Tab(text: 'History'),
            Tab(text: 'Techniques'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          GeneralPage(),
          RemindersPage(),
          HistoryPage(),
          TechniquesPage(),
        ],
      ),
    );
  }
}

class GeneralPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding around the text
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'The Schedule Page is the heart of the app, designed to help users efficiently organize their day. Users can input all their tasks, and the app handles the rest by arranging them into a well-structured, optimized daily schedule tailored to their needs. Whether your day is light or packed, this page ensures effective time management, letting you focus on what matters without the stress of planning.\n\nWhen you enter tasks, the app gathers details like task area, duration, and whether it has a fixed time. This fixed time option allows specific tasks to be scheduled at particular times, which is reflected directly in your daily schedule. For tasks under the "Study" area, additional factors such as difficulty and importance are considered to ensure your study sessions are well-organized.\n\nYou can also select tasks from the "Study" area to receive tailored study methods. The app prompts you for extra information to provide personalized guidance on the most effective ways to complete your tasks.',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TechniquesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTechnique('30-10 rule',
                  'The 30-10 rule is a time management technique where you work for 30 minutes followed by a 10-minute break. This method helps maintain focus and productivity by giving your brain regular intervals of rest.'),
              SizedBox(height: 16.0),
              _buildTechnique('60-20 rule',
                  'The 60-20 rule suggests working for 60 minutes and then taking a 20-minute break. This approach allows for deep focus while also ensuring you have time to recharge, which can enhance long-term productivity.'),
              SizedBox(height: 16.0),
              _buildTechnique('90-30 rule',
                  'The 90-30 rule involves working for 90 minutes followed by a 30-minute break. This technique is ideal for tackling large tasks that require sustained attention, providing ample time for rest afterward.'),
              SizedBox(height: 16.0),
              _buildTechnique('Interleaved Practice',
                  'Interleaved Practice is a learning technique where you mix different topics or forms of practice in one session. This method improves learning by encouraging the brain to distinguish between different concepts.'),
              SizedBox(height: 16.0),
              _buildTechnique('Eat That Frog Technique',
                  'The Eat That Frog Technique involves tackling tasks from hardest to easiest throughout the day. By getting the most challenging tasks out of the way first, you build momentum and reduce stress for the rest of the day.'),
              SizedBox(height: 16.0),
              _buildTechnique('ABCDE method',
                  'The ABCDE method is a prioritization technique where you work on tasks from most important to least important throughout the day. This approach ensures that you focus on your highest priorities first, making sure the critical tasks are completed.'),
              SizedBox(height: 16.0),
              _buildTechnique('Premack',
                  'The Premack Principle suggests tackling tasks from easiest to hardest. By starting with simpler tasks, you build confidence and momentum to take on more difficult tasks as the day progresses.'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTechnique(String title, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 19.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            decoration: TextDecoration.underline,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          description,
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}


class RemindersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding around the text
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'This page allows you to effortlessly create, organize, and manage your tasks and to-do lists. You can prioritize tasks to stay on top of everything. This page ensures you never miss an important deadline or appointment. With an intuitive interface, managing your daily reminders becomes a breeze.',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding around the text
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "The History page serves as a comprehensive archive of all your past schedules. Here, you can easily browse through previous dates to review or reflect on your daily plans. The page offers flexible viewing options, allowing you to switch between monthly, bi-weekly, and weekly views to better track your progress over time. Whether you're checking what tasks you completed on a specific day or looking to revisit a past routine, the History page provides a detailed view of all your previous schedules, ensuring you have a complete record of your productivity journey.",
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
