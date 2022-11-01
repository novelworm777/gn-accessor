import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants/database_collection.dart';
import '../domain/models/task.dart';

class TaskRepository {
  /// Find all tasks of a user.
  Future<Iterable<Task>> findTasks({required String userId}) async {
    QuerySnapshot<Map<String, dynamic>> found =
        await _tasks(userId: userId).get();
    return found.docs.map((doc) => Task.create(doc.id, doc.data()));
  }

  /// Find one task.
  Future<Task?> findOne(
      {required String userId, required String taskId}) async {
    DocumentSnapshot<Map<String, dynamic>> doc =
        await _tasks(userId: userId).doc(taskId).get();
    if (doc.exists) return Task.create(doc.id, doc.data()!);
    return null;
  }

  /// Update a task data.
  ///
  /// Only the data given will be updated, others will be untouched.
  void updateOne({
    required String userId,
    required String taskId,
    required Map<String, dynamic> data,
  }) {
    _tasks(userId: userId).doc(taskId).update(data);
  }

  /// Create [FirebaseFirestore] instance for task collection.
  CollectionReference<Map<String, dynamic>> _tasks({required String userId}) =>
      FirebaseFirestore.instance
          .collection(dUser)
          .doc(userId)
          .collection(dTask);
}
