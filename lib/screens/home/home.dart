import 'package:flutter/material.dart';
import 'package:test_1/screens/home/settings_form.dart';
import 'package:test_1/services/auth.dart';
import 'package:test_1/services/database.dart';
import 'package:provider/provider.dart';
import 'package:test_1/screens/home/task_list.dart';
import 'package:test_1/models/task.dart';
import 'package:test_1/models/user.dart';
class Home extends StatelessWidget {
  final AuthService _auth = AuthService(); 
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    void _showSettingsPanel() {
      showModalBottomSheet(
        isScrollControlled: true,
        context: context, 
        builder: (context) {
        return SingleChildScrollView(
          child:Container(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SettingsForm(),
          )
          );
      });
    }
    return StreamProvider<List<Tasks>>.value(
      value: DatabaseService(uid: user.uid).tasks,
        child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('to-do'),
          backgroundColor: Colors.blue[400],
          elevation: 0.0,
          actions: <Widget>[
            RawMaterialButton(
              onPressed: () async {
                await _auth.signOut();
              },
              child: Icon(
                Icons.power_settings_new,
              ),
              shape: CircleBorder(),
              elevation: 2.0,
              padding: EdgeInsets.all(15.0),
            ),
          ],
        ),
        body: BrewList(uid: user.uid),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showSettingsPanel(),
          child: Icon(Icons.add),
          backgroundColor: Colors.blue,
        ),
      ),
    );
  }
}