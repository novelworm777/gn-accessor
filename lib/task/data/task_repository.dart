import 'package:cloud_firestore/cloud_firestore.dart';

import '../../constants/database_collection.dart';
import '../domain/models/task.dart';

class TaskRepository {
  /// Find all tasks of a user.
  Future<Iterable<Task>> findTasks({required String userId}) async {
    QuerySnapshot<Map<String, dynamic>> found = await _db(userId).get();
    return found.docs.map((doc) => Task.create(doc.id, doc.data()));
  }

  /// Create [FirebaseFirestore] instance.
  CollectionReference<Map<String, dynamic>> _db(String userId) =>
      FirebaseFirestore.instance
          .collection(dUser)
          .doc(userId)
          .collection(dTask);
}
