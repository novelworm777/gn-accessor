import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants/database_collection.dart';
import '../domain/models/task_domain.dart';
import '../utils/services/firestore.dart';
import 'models/task_firestore_data.dart';

/// Repository for task [FirebaseFirestore] collection.
class TaskRepository {
  final _firestore = Firestore.user();

  /// Find all task data.
  Future<List<TaskDomain>> findAll({required String userId}) async {
    final QuerySnapshot<TaskFirestoreData> found =
        await _tasks(userId: userId).get();
    return found.docs
        .map((snapshot) => TaskDomain.fromData(snapshot.data()))
        .toList();
  }

  /// Find a task data.
  Future<TaskDomain?> findOne({
    required String userId,
    required String taskId,
  }) async {
    final TaskFirestoreData? found =
        await _tasks(userId: userId).doc(taskId).get().then(
              (snapshot) => snapshot.data(),
              onError: (error) => null,
            );
    if (found != null) return TaskDomain.fromData(found);
    return null;
  }

  /// Update a task data.
  ///
  /// Only the data given will be updated, others will be untouched.
  Future<TaskDomain?> updateOne({
    required String userId,
    required String taskId,
    required TaskDomain data,
  }) async {
    await _tasks(userId: userId)
        .doc(taskId)
        .set(TaskFirestoreData.fromDomain(data), SetOptions(merge: true));
    return findOne(userId: userId, taskId: taskId);
  }

  /// Delete a task data.
  void deleteOne({
    required String userId,
    required String taskId,
  }) =>
      _tasks(userId: userId).doc(taskId).delete();

  /// Create [FirebaseFirestore] instance for task collection.
  CollectionReference<TaskFirestoreData> _tasks({required String userId}) =>
      _firestore.doc(userId).collection(dTask).withConverter<TaskFirestoreData>(
            fromFirestore: (snapshot, _) =>
                TaskFirestoreData.fromFirestore(snapshot),
            toFirestore: (model, _) => model.toFirestore(),
          );
}
