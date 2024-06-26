import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:ran_app/homepage/homepage.dart';
import 'package:ran_app/keys.dart';

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

var response = '';
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
    ' Pomodoro Technique, 50-20 rule, 90-30 rule          And choose one of '
    'the following that best fits the person: Interleaved Practice, Eat That '
    'Frog Technique, ABCDE method, Premack          When giving the answer, '
    'only give the answers to the two questions separated by a comma';

class EndPage extends StatelessWidget {
  const EndPage({super.key});
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
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      return responseBody['choices'][0]['message']['content'];
    } else {
      throw Exception('Failed to load response');
    }
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
            response = responseText;
            return Column(
              children: [
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                      child: Text('Split: ${(response.split(', '))[0]}\nWork: '
                          '${(response.split(', '))[1]}'),
                      //child: Text("Quiz Complete"),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
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