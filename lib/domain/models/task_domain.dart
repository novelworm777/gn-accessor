import '../../data/models/task_firestore_data.dart';

/// Task domain model.
class TaskDomain {
  String? id;
  String? title;
  String? notes;
  DateTime? due;
  int? available;
  int? completed;
  int? reward;
  DateTime? createdAt;

  TaskDomain({
    this.id,
    this.title,
    this.notes,
    this.due,
    this.available,
    this.completed,
    this.reward,
    this.createdAt,
  });

  /// Convert [TaskFirestoreData] into [TaskDomain] object.
  factory TaskDomain.fromData(TaskFirestoreData model) => TaskDomain(
        id: model.id,
        title: model.title,
        notes: model.notes,
        due: model.due,
        available: model.available,
        completed: model.completed,
        reward: model.reward,
        createdAt: model.createdAt,
      );
}
