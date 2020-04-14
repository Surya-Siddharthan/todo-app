import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_1/services/database.dart';
import 'package:test_1/shared/constants.dart';
import 'package:test_1/models/user.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  
  final _formKey = GlobalKey<FormState>();
  
  String _currentTask;
  String _currentDetails;
  int _currentColor;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return Padding(
      padding: EdgeInsets.all(25.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Text(
              'Create New Task',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: textInputDecoration.copyWith(hintText: 'Task'),
              validator: (val) => val.isEmpty ? 'please enter a task' : null,
              onChanged: (val) => setState(() => _currentTask = val),
            ), 
            SizedBox(height: 20),
            //dropdown
            TextFormField(
              decoration: textInputDecoration.copyWith(hintText: 'Details'),
              validator: (val) => val.isEmpty ? 'please enter the details' : null,
              onChanged: (val) => setState(() => _currentDetails = val),
            ), 
            SizedBox(height: 20),
            //slider
            Text('Pick a color'),
            Slider(
              value: (_currentColor ?? 100).toDouble(),
              activeColor: Colors.blue[_currentColor ?? 100],
              inactiveColor: Colors.blue,
              min: 100,
              max: 900,
              divisions: 8,
              onChanged: (val) => setState(() => _currentColor = val.round()),
            ),
            RaisedButton(
              color: Colors.pink[400],
              child: Text(
                'Add Task',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                if(_formKey.currentState.validate()) {
                  await DatabaseService(uid: user.uid).addTask(_currentTask, _currentDetails, _currentColor);
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}