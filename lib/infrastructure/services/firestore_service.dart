import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/task_model.dart';

class FirestoreService {
  final CollectionReference _taskCollection =
  FirebaseFirestore.instance.collection('tasks');

  Future<void> addOrUpdateTask(Task task) async {
    await _taskCollection.doc(task.id).set(task.toMap());
  }

  Future<List<Task>> getTasks() async {
    final snapshot = await _taskCollection.get();
    return snapshot.docs
        .map((doc) => Task.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Future<void> deleteTask(String id) async {
    await _taskCollection.doc(id).delete();
  }
}
