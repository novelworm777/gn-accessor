import 'package:cloud_firestore/cloud_firestore.dart';

import '../../constants/database_collection.dart';
import '../domain/models/task.dart';

class TaskRepository {
  /// Find all tasks of a user.
  Future<Iterable<Task>> findTasks({required String userId}) async {
    QuerySnapshot<Map<String, dynamic>> found = await _db(userId: userId).get();
    return found.docs.map((doc) => Task.create(doc.id, doc.data()));
  }

  /// Update a task data.
  ///
  /// Only the data given will be updated, others will be untouched.
  void updateOne({
    required String userId,
    required String taskId,
    required Map<String, dynamic> data,
  }) {
    _db(userId: userId, taskId: taskId).update(data);
  }

  /// Create [FirebaseFirestore] instance.
  _db({required String userId, String? taskId}) {
    if (taskId != null) {
      return FirebaseFirestore.instance
          .collection(dUser)
          .doc(userId)
          .collection(dTask)
          .doc(taskId);
    }
    return FirebaseFirestore.instance
        .collection(dUser)
        .doc(userId)
        .collection(dTask);
  }
}
