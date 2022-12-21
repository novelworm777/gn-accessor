import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../components/templates/main_app_screen.dart';
import '../../../config/route/routes.dart';
import '../../../config/themes/colours.dart';
import '../../../domain/usecases/task_usecase.dart';
import '../../models/task.dart';
import '../../models/user.dart';
import 'task_tile.dart';

/// Screen where user can see all tasks.
class TaskBoardScreen extends StatefulWidget {
  const TaskBoardScreen({Key? key}) : super(key: key);

  @override
  State<TaskBoardScreen> createState() => _TaskBoardScreenState();
}

class _TaskBoardScreenState extends State<TaskBoardScreen> {
  final TaskUsecase _taskUsecase = TaskUsecase();
  List<Task> _tasks = [];

  @override
  void initState() {
    super.initState();
    _initTasks();
  }

  void _initTasks() async {
    final userId = context.read<User>().id;
    final res = await _taskUsecase.viewAllTasks(userId: userId);
    setState(() {
      _tasks = res.map<Task>((map) => Task.create(map)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainAppScreen(
      colour: Colours.darkBase,
      content: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          final task = _tasks[index];
          return TaskTile(
            bodyOnPress: () {
              Navigator.pushNamed(context, Routes.taskDetailScreen,
                  arguments: task.id);
            },
            completion: task.completed ?? 0,
            leadingOnPress: () {
              // complete task
              setState(() => task.completeTask());
              _taskUsecase.completeTask(
                userId: context.read<User>().id,
                taskId: task.id ?? 'taskId',
              );
            },
            reward: task.reward ?? 0,
            title: task.title ?? '-',
          );
        },
        itemCount: _tasks.length,
        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(height: 17.0),
      ),
      headerTitle: 'Task Board',
      homeRoute: Routes.homeScreen,
    );
  }
}
