import '../../data/repositories/task_repository.dart';
import '../models/task_domain.dart';

/// Service for task module.
class TaskService {
  final TaskRepository _repository = TaskRepository();

  /// Find all tasks.
  Future<List<TaskDomain>> findAll({required String userId}) async {
    return await _repository.findAll(userId: userId);
  }

  /// Find a task by [id].
  Future<TaskDomain?> findById({
    required String userId,
    required String taskId,
  }) async {
    return await _repository.findOne(userId: userId, taskId: taskId);
  }

  /// Add the number of [completed] by one.
  TaskDomain addCompleted({
    required String userId,
    required TaskDomain task,
    bool update = true,
  }) {
    // update task
    TaskDomain updated = TaskDomain(completed: (task.completed ?? 0) + 1);

    // check whether task has been cleared
    bool isCleared = updated.completed == task.available;

    // delete task data
    if (isCleared) {
      _repository.deleteOne(userId: userId, taskId: task.id!);
    }
    // update task data
    else if (update) {
      _repository.updateOne(userId: userId, taskId: task.id!, data: updated);
    }

    return task;
  }
}
