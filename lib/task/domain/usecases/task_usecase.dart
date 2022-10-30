import '../models/task.dart';
import '../services/task_service.dart';

/// Usecase for task module.
class TaskUsecase {
  final TaskService _taskService = TaskService();

  /// Get all tasks for task board.
  Future<Iterable<Map<String, dynamic>>> viewAllTasks(
      {required String userId}) async {
    Iterable<Task> tasks = await _taskService.findAllByUserId(
      userId: userId,
      throwError: false,
    );
    return tasks.map<Map<String, dynamic>>((task) => {
          'id': task.id,
          'title': task.title,
          'completed': task.completed,
          'reward': task.reward,
        });
  }
}
