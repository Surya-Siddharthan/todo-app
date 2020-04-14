import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_1/models/task.dart';
import 'package:test_1/screens/home/task_tile.dart';
class BrewList extends StatefulWidget {
  final String uid;
  BrewList({this.uid});
  @override
  _BrewListState createState() => _BrewListState(uid: uid);
}

class _BrewListState extends State<BrewList> {
  final String uid;
  _BrewListState({this.uid});
  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<Tasks>>(context) ?? [];
    if(brews.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 100, vertical: 10),
        child: Text(
          "Add Tasks by clicking '+' icon",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15),
        ),
      );
    }
    return ListView.builder(
      itemCount: brews.length,
      itemBuilder: (context, index) {
        return BrewTile(task: brews[index], uid: uid);
      },
      );
  }
}
