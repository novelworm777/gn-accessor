/// Task domain model.
class Task {
  String id;
  String? title;
  String? notes;
  DateTime? due;
  int? available;
  int? completed;
  int? reward;
  DateTime? createdAt;

  /// Creates [Task] from an id and a map.
  Task.create(this.id, Map<String, dynamic> map) {
    title = map['title'];
    notes = map['notes'];
    due = map['due']?.toDate();
    available = map['available'];
    completed = map['completed'];
    reward = map['reward'];
    createdAt = map['created_at']?.toDate();
  }
}
