import '../../data/task_repository.dart';
import '../models/task.dart';

/// Service for task module.
class TaskService {
  final TaskRepository _repository = TaskRepository();

  /// Find all tasks that a user has.
  Future<Iterable<Task>> findAllByUserId({required String userId}) async {
    return await _repository.findTasks(userId: userId);
  }

  /// Get a task by ID.
  Future<Task?> findById({
    required String userId,
    required String taskId,
  }) async {
    return await _repository.findOne(userId: userId, taskId: taskId);
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
