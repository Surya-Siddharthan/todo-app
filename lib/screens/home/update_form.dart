import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_1/models/user.dart';
import 'package:test_1/models/task.dart';
import 'package:test_1/shared/constants.dart';
Tasks task;
class UpdateForm extends StatefulWidget {
  
  UpdateForm(Tasks t) {
    task = t;
  }
  @override
  _UpdateFormState createState() => _UpdateFormState();
}

class _UpdateFormState extends State<UpdateForm> {
  String _task = task.task;
  String _details = task.details;
  int _color = task.color;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return Padding(
      padding: EdgeInsets.all(25.0),
      child: Form(
        key: _formKey,
          child: Column(
            children: <Widget>[
              Text(
                'Update Task',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                initialValue: task.task,
                decoration: textInputDecoration.copyWith(hintText: 'Task'),
                validator: (val) => val.isEmpty ? 'Please enter task name' : null,
                onChanged: (val) => setState(() => _task = val),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                initialValue: task.details,
                decoration: textInputDecoration.copyWith(hintText: 'Details'),
                validator: (val) => val.isEmpty ? 'Please enter task details' : null,
                onChanged: (val) => setState(() => _details = val),
              ),
              SizedBox(height: 10.0),
              Slider(
                value: (_color ?? 100).toDouble(),
                activeColor: Colors.blue[_color ?? 100],
                inactiveColor: Colors.blue,
                min: 100,
                max: 900,
                divisions: 8,
                onChanged: (val) => setState(() => _color = val.round()),
              ),
              RaisedButton(
                color: Colors.pink[400],
                child: Text(
                  'Update Task',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if(_formKey.currentState.validate()) {
                    await Firestore.instance.collection('tasks').document(user.uid).collection('taskList').document(task.taskId).updateData({'color': _color, 'details': _details, 'isDone': false, 'task': _task});
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