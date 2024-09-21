import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangeSplitPage extends StatefulWidget {
  final String initialSplit;

  ChangeSplitPage({Key? key, this.initialSplit = '30-10 rule'}) : super(key: key);

  @override
  _ChangeSplitPageState createState() => _ChangeSplitPageState();
}

class _ChangeSplitPageState extends State<ChangeSplitPage> {
  late String _selectedSplit;

  @override
  void initState() {
    super.initState();
    _selectedSplit = widget.initialSplit;
  }

  Future<void> _saveSplit() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedSplit', _selectedSplit);
    Navigator.pop(context, _selectedSplit);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Split'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Select a Split Rule:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,  // Changed to white
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _selectedSplit,
              onChanged: (newValue) {
                setState(() {
                  _selectedSplit = newValue!;
                });
              },
              items: <String>['30-10 rule', '60-20 rule', '90-30 rule']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,  // Changed to white
                    ),
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
              onPressed: _saveSplit,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                textStyle: const TextStyle(fontSize: 18),
              ),
              child: const Text('Save Split'),
            ),
          ],
        ),
      ),
    );
  }
}
