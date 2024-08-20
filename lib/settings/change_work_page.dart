import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangeWorkPage extends StatefulWidget {
  @override
  _ChangeWorkPageState createState() => _ChangeWorkPageState();
}

class _ChangeWorkPageState extends State<ChangeWorkPage> {
  late String _selectedWork = 'Interleaved Practice'; // Default value

  @override
  void initState() {
    super.initState();
    _loadWork();
  }

  Future<void> _loadWork() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedWork = prefs.getString('selectedWork') ?? 'Interleaved Practice';
    });
  }

  Future<void> _saveWork(String work) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedWork', work);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Work Technique'),
      ),
      body: ListView(
        children: [
          RadioListTile(
            title: Text('Interleaved Practice'),
            value: 'Interleaved Practice',
            groupValue: _selectedWork,
            onChanged: (value) {
              setState(() {
                _selectedWork = value.toString();
              });
              _saveWork(_selectedWork);
            },
          ),
          RadioListTile(
            title: Text('Eat That Frog Technique'),
            value: 'Eat That Frog Technique',
            groupValue: _selectedWork,
            onChanged: (value) {
              setState(() {
                _selectedWork = value.toString();
              });
              _saveWork(_selectedWork);
            },
          ),
          RadioListTile(
            title: Text('ABCDE method'),
            value: 'ABCDE method',
            groupValue: _selectedWork,
            onChanged: (value) {
              setState(() {
                _selectedWork = value.toString();
              });
              _saveWork(_selectedWork);
            },
          ),
          RadioListTile(
            title: Text('Premack'),
            value: 'Premack',
            groupValue: _selectedWork,
            onChanged: (value) {
              setState(() {
                _selectedWork = value.toString();
              });
              _saveWork(_selectedWork);
            },
          ),
        ],
      ),
    );
  }
}
