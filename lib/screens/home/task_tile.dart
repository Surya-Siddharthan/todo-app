import 'package:flutter/material.dart';
import 'package:test_1/models/task.dart';
import 'package:test_1/services/database.dart';
import 'package:test_1/screens/home/update_form.dart';
class BrewTile extends StatelessWidget {
  final Tasks task;
  final String uid;
  BrewTile({this.task, this.uid});
  @override
  Widget build(BuildContext context) {
    void _showUpdatePanel() {
      showModalBottomSheet(
        isScrollControlled: true,
        context: context, 
        builder: (context) {
        return SingleChildScrollView(
          child:Container(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: UpdateForm(task),
          )
          );
      });
    }
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
      child: Card(
        color: Colors.blue[task.color],
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          onTap: () => _showUpdatePanel(),
          leading: Checkbox(value: task.isDone, onChanged: (value) async {
              await DatabaseService(uid: uid).markDone(task.taskId, value);
          },),
          title: task.isDone ? Text(task.task, style: TextStyle(decoration: TextDecoration.lineThrough)) : Text(task.task),
          subtitle: Text(task.details),
          trailing: RawMaterialButton(
              onPressed: () async {
                await DatabaseService(uid: uid).deleteTask(task.taskId);
              },
              child: Icon(
                Icons.remove,
              ),
              shape: CircleBorder(),
              elevation: 2.0,
              padding: EdgeInsets.all(15.0),
            ),
        ),
      ),    
    );
  }
}