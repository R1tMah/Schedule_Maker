import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ran_app/homepage/homepage.dart';
import 'package:ran_app/keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:ran_app/questions/quiz.dart';
import 'package:ran_app/questions/question2.dart';
import 'package:ran_app/questions/question3.dart';
import 'package:ran_app/questions/question4.dart';
import 'package:ran_app/questions/question5.dart';
import 'package:ran_app/questions/question6.dart';
import 'package:ran_app/questions/question7.dart';
import 'package:ran_app/questions/question8.dart';
import 'package:ran_app/questions/question9.dart';
import 'package:ran_app/questions/question10.dart';

import '../settings/change_split_page.dart';
import '../settings/change_work_page.dart';

var response = '';
var work = '';
var workingMethod = '';
var prompt = 'Questions and options: 1) How frequently do you check your phone '
    'notifications throughout the day? [Very frequently, Frequently, Sometimes'
    ', Not frequently, Very rarely] 2) On a scale of 1 to 10, how motivated do'
    ' you feel to accomplish tasks and challenges? [1-10] 3) How often do you '
    'find yourself procrastinating? [Very often, Often, Sometimes, Not often, '
    'Very rarely] 4) Do you find that your motivation varies depending on the '
    'type or nature of the task? [Yes, No] 5) How easily on a scale of 1-10 do'
    ' you get bored when engaging in repetitive or monotonous activities? '
    '[1-10] 6) Are you often preoccupied with "what-if" scenarios or potential'
    ' negative outcomes? [Very often, Often, Sometimes, Not often, Very '
    'rarely] 7) How frequently do you experience "mind wandering" or '
    'daydreaming during daily activities? [Very frequently, Frequently, '
    'Sometimes, Not frequently, Very rarely] 8) Do you find that you are '
    'more motivated by external rewards or intrinsic satisfaction? [External '
    'rewards, Intrinsic satisfaction] 9) Do you often find it difficult to '
    'quiet your mind or relax? [Very often, Often, Sometimes, Not often, Very '
    'rarely] 10) Are you easily distracted by external stimuli, such as noise '
    'or movement? [Yes, No]          Answers: 1) ${answer1} 2) ${answer2} '
    '3) ${answer3} 4) ${answer4} 5) ${answer5} 6) ${answer6} 7) ${answer7} '
    '8) ${answer8} 9) ${answer9} 10) ${answer10}          Using these answers'
    ' to the questions, choose one of the following that best fits the person:'
    ' 30-10 rule, 60-20 rule, 90-30 rule          And choose one of '
    'the following that best fits the person: Interleaved Practice, Eat That '
    'Frog Technique, ABCDE method, Premack          When giving the answer, '
    'only give the answers to the two questions separated by a comma';
late String _currentWork = ''; // Default value

class EndPage extends StatefulWidget {
  const EndPage({Key? key}) : super(key: key);

  @override
  _EndPageState createState() => _EndPageState();
}

class _EndPageState extends State<EndPage> {
  late String _currentSplit = ''; // Default value


  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _currentSplit = prefs.getString('selectedSplit') ?? '30-10 rule';
      _currentWork = prefs.getString('selectedWork') ?? 'Interleaved Practice';
    });
  }

  Future<String> fetchResponse() async {
    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/chat/completions'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${OPEN_AI_KEY}'
      },
      body: jsonEncode(
        {
          "model": "gpt-3.5-turbo",
          "messages": [
            {"role": "user", "content": prompt} // Include the user prompt
          ],
          "max_tokens": 250,
          "temperature": 0,
          "top_p": 1,
        },
      ),
    );
    print('Response status code: ${response.statusCode}');
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['choices'][0]['message']['content'];
    } else {
      throw Exception('Failed to load data');
    }

  }

  String fetchDisplay(String split, String work) {
    String result = "Based on your answers, we've analyzed your responses and determined the best techniques to help you maximize your productivity and focus. Here's what we recommend:\n\n\n";

    if(split == '30-10 rule'){
      result += "The 30-10 rule is a time management technique where you work for 30 minutes followed by a 10-minute break. This method helps maintain focus and productivity by giving your brain regular intervals of rest.\n\n";
    } else if(split == '60-20 rule') {
      result += "The 60-20 rule suggests working for 60 minutes and then taking a 20-minute break. This approach allows for deep focus while also ensuring you have time to recharge, which can enhance long-term productivity.\n\n";
    } else if(split == '90-30 rule') {
      result += "The 90-30 rule involves working for 90 minutes followed by a 30-minute break. This technique is ideal for tackling large tasks that require sustained attention, providing ample time for rest afterward.\n\n";
    } else {
      result += "No split technique selected.\n\n";
    }

    if(work == 'Interleaved Practice') {
      result += "Interleaved Practice is a learning technique where you mix different topics or forms of practice in one session. This method improves learning by encouraging the brain to distinguish between different concepts.\n\n\n";
    } else if(work == 'Eat That Frog Technique') {
      result += "The Eat That Frog Technique involves tackling tasks from hardest to easiest throughout the day. By getting the most challenging tasks out of the way first, you build momentum and reduce stress for the rest of the day.\n\n\n";
    } else if(work == 'ABCDE method') {
      result += "The ABCDE method is a prioritization technique where you work on tasks from most important to least important throughout the day. This approach ensures that you focus on your highest priorities first, making sure the critical tasks are completed.\n\n\n";
    } else if(work == 'Premack') {
      result += "The Premack Principle suggests tackling tasks from easiest to hardest. By starting with simpler tasks, you build confidence and momentum to take on more difficult tasks as the day progresses.\n\n";
    } else {
      result += "No working technique selected.\n\n\n";
    }

    result += "With these strategies in place, your schedules will be customized to help you work smarter and stay on track. Every plan you create here will be tailored to fit these techniques, so you can focus on what matters and make steady progress throughout your day. If you'd like to adjust your techniques later on, you can always do that manually in the settings. \n\nLet’s get started!";

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("End Page"),
      ),
      body: FutureBuilder(
        future: fetchResponse(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            String responseText = snapshot.data.toString();
            String split = _currentSplit;
            String work = _currentWork;

            return Column(
              children: [
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                      child: Text(
                        fetchDisplay(split, work),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const MyHomePage()),
                    );
                  },
                  child: const Text('Go to Schedule'),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}