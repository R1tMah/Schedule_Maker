import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangeWorkPage extends StatefulWidget {
  @override
  _ChangeWorkPageState createState() => _ChangeWorkPageState();
}

class _ChangeWorkPageState extends State<ChangeWorkPage> {
  late String _selectedWork;

  @override
  void initState() {
    super.initState();
    _loadWork();
  }

  Future<void> _loadWork() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedWork = prefs.getString('selectedWork') ?? 'Nothing';
    });
  }

  Future<void> _saveWork() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedWork', _selectedWork);
    Navigator.pop(context, _selectedWork);  // Return to the previous screen with the selected work technique
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Work Technique'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Select a Work Technique:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _selectedWork,
              onChanged: (newValue) {
                setState(() {
                  _selectedWork = newValue!;
                });
              },
              items: <String>[
                'Interleaved Practice',
                'Eat That Frog Technique',
                'ABCDE method',
                'Premack'
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: const TextStyle(fontSize: 18),
                  ),
                );
              }).toList(),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(color: Colors.blue, width: 2),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _saveWork,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                textStyle: const TextStyle(fontSize: 18),
              ),
              child: const Text('Save Work Technique'),
            ),
          ],
        ),
      ),
    );
  }
}
