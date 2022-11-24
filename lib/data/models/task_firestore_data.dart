import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/models/task_domain.dart';

/// Task firestore data model.
class TaskFirestoreData {
  String? id;
  String? title;
  String? notes;
  DateTime? due;
  int? available;
  int? completed;
  int? reward;
  DateTime? createdAt;

  TaskFirestoreData({
    this.id,
    this.title,
    this.notes,
    this.due,
    this.available,
    this.completed,
    this.reward,
    this.createdAt,
  });

  /// Convert [TaskDomain] into [TaskFirestoreData] object.
  factory TaskFirestoreData.fromDomain(TaskDomain model) => TaskFirestoreData(
        id: model.id,
        title: model.title,
        notes: model.notes,
        due: model.due,
        available: model.available,
        completed: model.completed,
        reward: model.reward,
        createdAt: model.createdAt,
      );

  /// Convert firestore snapshot into [TaskFirestoreData] object.
  factory TaskFirestoreData.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot, {
    SnapshotOptions? options,
  }) {
    final data = snapshot.data();
    final task = TaskFirestoreData.fromMap(data);
    task.id = snapshot.id;
    return task;
  }

  /// Convert [Map] into [TaskFirestoreData] object.
  factory TaskFirestoreData.fromMap(Map<String, dynamic>? map) =>
      TaskFirestoreData(
        title: map?['title'] as String?,
        notes: map?['notes'] as String?,
        due: map?['due'] as DateTime?,
        available: map?['available'] as int?,
        completed: map?['completed'] as int?,
        reward: map?['reward'] as int?,
        createdAt: map?['createdAt'] as DateTime?,
      );

  /// Convert [TaskFirestoreData] into firestore json.
  Map<String, dynamic> toFirestore() => {
        if (title != null) "title": title,
        if (notes != null) "notes": notes,
        if (due != null) "due": due,
        if (available != null) "available": available,
        if (completed != null) "completed": completed,
        if (reward != null) "reward": reward,
        if (createdAt != null) "createdAt": createdAt,
      };
}
