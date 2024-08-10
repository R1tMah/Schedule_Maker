import 'package:flutter/material.dart';

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

  void _saveSplit() {
    Navigator.pop(context, _selectedSplit);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Split'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton<String>(
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
                  child: Text(value),
                );
              }).toList(),
            ),
            ElevatedButton(
              onPressed: _saveSplit,
              child: const Text('Save Split'),
            ),
          ],
        ),
      ),
    );
  }
}
