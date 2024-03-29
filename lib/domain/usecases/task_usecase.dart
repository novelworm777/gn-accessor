import '../models/task_domain.dart';
import '../models/user_domain.dart';
import '../services/task_service.dart';
import '../services/user_service.dart';

/// Usecase for task module.
class TaskUsecase {
  final TaskService _taskService = TaskService();
  final UserService _userService = UserService();

  /// Get all tasks for task board.
  Future<Iterable<Map<String, dynamic>>> viewAllTasks(
      {required String userId}) async {
    Iterable<TaskDomain> tasks = await _taskService.findAll(userId: userId);
    return tasks.map<Map<String, dynamic>>((task) => {
          'id': task.id,
          'title': task.title,
          'completed': task.completed,
          'reward': task.reward,
        });
  }

  /// Get a task details.
  Future<Map<String, dynamic>> viewTask({
    required String userId,
    required String taskId,
  }) async {
    TaskDomain? task =
        await _taskService.findById(userId: userId, taskId: taskId);
    return {
      'id': task!.id,
      'title': task.title,
      'notes': task.notes,
      'due': task.due,
      'available': task.available,
      'completed': task.completed,
      'reward': task.reward,
    };
  }

  /// Complete a task.
  void completeTask({
    required String userId,
    required String taskId,
  }) async {
    // get all data that will be updated
    UserDomain? user = await _userService.findById(id: userId);
    if (user == null) {
      throw const FormatException("unable to update nonexistent user");
    }
    TaskDomain? task =
        await _taskService.findById(userId: userId, taskId: taskId);
    if (task == null) {
      throw const FormatException("unable to update nonexistent task");
    }

    // add the number of completed in task
    _taskService.addCompleted(userId: userId, task: task);

    // add the rewarded cryois
    _userService.addCryois(user: user, number: task.reward!);
  }
}
