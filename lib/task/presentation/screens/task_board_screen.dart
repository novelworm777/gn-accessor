import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../auth/presentation/models/user.dart';
import '../../../components/atoms/app_list_tile.dart';
import '../../../components/templates/main_app_screen.dart';
import '../../../config/route/routes.dart';
import '../../../config/themes/colours.dart';
import '../../../constants/image_path.dart';
import '../../domain/usecases/task_usecase.dart';
import '../models/task_board.dart';

/// Screen where user can see all tasks.
class TaskBoardScreen extends StatefulWidget {
  const TaskBoardScreen({Key? key}) : super(key: key);

  @override
  State<TaskBoardScreen> createState() => _TaskBoardScreenState();
}

class _TaskBoardScreenState extends State<TaskBoardScreen> {
  final TaskUsecase _taskUsecase = TaskUsecase();

  @override
  Widget build(BuildContext context) {
    viewAllTasks();

    return MainAppScreen(
      colour: Colours.darkBase,
      content: Consumer<TaskBoard>(
          builder: (BuildContext context, TaskBoard taskBoard, Widget? child) {
        return ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            final task = taskBoard.unmodifiableTasks[index];
            return _TaskTile(
              bodyOnPress: () {
                Navigator.pushNamed(context, Routes.taskDetailScreen,
                    arguments: task.id);
              },
              completion: task.completed,
              leadingOnPress: () {
                // complete task
                taskBoard.update(task.complete());
                _taskUsecase.completeTask(
                    userId: context.read<User>().uid, taskId: task.id);
              },
              reward: task.reward,
              title: task.title,
            );
          },
          itemCount: taskBoard.taskCount,
          separatorBuilder: (BuildContext context, int index) =>
              const SizedBox(height: 17.0),
        );
      }),
      headerTitle: 'Task Board',
      homeRoute: Routes.homeScreen,
    );
  }

  void viewAllTasks() async {
    if (!context.watch<TaskBoard>().isViewed) {
      context.read<TaskBoard>().tasks = await _taskUsecase.viewAllTasks(
        userId: context.read<User>().uid,
      );
    }
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
