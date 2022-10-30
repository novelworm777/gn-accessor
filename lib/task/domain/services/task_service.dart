import 'package:gn_accessor/task/domain/models/task.dart';

import '../../data/task_repository.dart';

/// Service for task module.
class TaskService {
  final TaskRepository _repository = TaskRepository();

  /// Find all tasks that a user has.
  Future<Iterable<Task>> findAllByUserId(
      {required String userId, bool throwError = true}) async {
    Iterable<Task> tasks = await _repository.findTasks(userId: userId);
    if (tasks.isEmpty && throwError) {
      throw const FormatException("there isn't a single task");
    }
    return tasks;
  }

  /// Add the number of [completed] by one.
  Task addCompleted({
    required String userId,
    required Task task,
    bool update = true,
  }) {
    task.completed = task.completed! + 1;
    if (update) {
      Map<String, dynamic> updated = {'completed': task.completed};
      _repository.updateOne(userId: userId, taskId: task.id!, data: updated);
    }
    return task;
  }
}
