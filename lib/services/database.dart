import 'package:test_1/models/task.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  String uid;
  DatabaseService({ this.uid });
  // collection reference
  final CollectionReference taskCollection = Firestore.instance.collection('tasks');
  //add task
  Future<void> addTask(String task, String details, int color) async {
    return await taskCollection.document(uid).collection('taskList').add({'task' : task, 'details' : details, 'color' : color, 'isDone' : false});
  }
  //mark as done
  Future <void> markDone(String taskId, bool val) async {
    return await taskCollection.document(uid).collection('taskList').document(taskId).updateData({'isDone': val});
  }
  //delete task
  Future <void> deleteTask(String taskId) async {
    return await taskCollection.document(uid).collection('taskList').document(taskId).delete();
  }
  // task list from snapshot
  List<Tasks> _taskListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Tasks(
        taskId: doc.documentID ?? '',
        isDone: doc.data['isDone'] ?? 'false',
        task: doc.data['task'] ?? '',
        details: doc.data['details'] ?? '',
        color: doc.data['color'] ?? 0
      );
    }).toList();
  }

  // get brews stream
  Stream<List<Tasks>> get tasks {
    return taskCollection.document(uid).collection('taskList').snapshots()
      .map(_taskListFromSnapshot);
  }

}