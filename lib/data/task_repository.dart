import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants/database_collection.dart';
import '../domain/models/task.dart';

/// Repository for task [FirebaseFirestore] collection.
class TaskRepository {
  /// Find all task data.
  Future<List<Task>> findAll({required String userId}) async {
    QuerySnapshot<Map<String, dynamic>> found =
        await _tasks(userId: userId).get();
    return found.docs.map((doc) => Task.create(doc.id, doc.data())).toList();
  }

  /// Find a task data.
  Future<Task?> findOne({
    required String userId,
    required String taskId,
  }) async {
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

  /// Delete a task data.
  void deleteOne({
    required String userId,
    required String taskId,
  }) {
    _tasks(userId: userId).doc(taskId).delete();
  }

  /// Create [FirebaseFirestore] instance for task collection.
  CollectionReference<Map<String, dynamic>> _tasks({required String userId}) =>
      FirebaseFirestore.instance
          .collection(dUser)
          .doc(userId)
          .collection(dTask);
}
