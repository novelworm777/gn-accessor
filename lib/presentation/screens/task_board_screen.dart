import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../components/atoms/app_list_tile.dart';
import '../../components/templates/main_app_screen.dart';
import '../../config/route/routes.dart';
import '../../config/themes/colours.dart';
import '../../constants/image_path.dart';
import '../../domain/usecases/task_usecase.dart';
import '../models/task.dart';
import '../models/user.dart';

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
          return _TaskTile(
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

/// List tile for tasks.
class _TaskTile extends StatelessWidget {
  const _TaskTile({
    Key? key,
    required this.bodyOnPress,
    required this.completion,
    required this.leadingOnPress,
    required this.reward,
    required this.title,
  }) : super(key: key);

  final VoidCallback bodyOnPress;
  final int completion;
  final VoidCallback leadingOnPress;
  final num reward;
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppListTile(
      // task title
      body: Text(
        title,
        style: GoogleFonts.jetBrainsMono(
          color: Colours.text,
          fontSize: 14.0,
          fontWeight: FontWeight.w300,
        ),
      ),
      leading: Row(
        children: <Widget>[
          // cryois icon
          Image.asset(iCryois, height: 28.0, width: 28.0),
          const SizedBox(width: 3.0),
          // number of cryois
          Text(
            '$reward',
            style: GoogleFonts.jetBrainsMono(
              color: Colours.darkText,
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
      leadingColour: Colours.lightBase,
      leadingOnPress: leadingOnPress,
      // number of completed
      trailing: Text(
        completion > 999 ? '999+' : '$completion',
        style: GoogleFonts.jetBrainsMono(
          color: Colours.darkText,
          fontSize: 11.0,
          fontWeight: FontWeight.w500,
        ),
      ),
      onPress: bodyOnPress,
    );
  }
}
