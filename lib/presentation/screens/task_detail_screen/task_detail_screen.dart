import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../components/templates/detail_screen.dart';
import '../../../config/route/routes.dart';
import '../../../config/themes/colours.dart';
import '../../../domain/usecases/task_usecase.dart';
import '../../models/task.dart';
import '../../models/user.dart';
import 'detail_item.dart';

const _kSpacingBetweenItems = SizedBox(height: 33.0);

/// Screen containing details of a task.
class TaskDetailScreen extends StatefulWidget {
  const TaskDetailScreen({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  final TaskUsecase _taskUsecase = TaskUsecase();
  Task _task = Task();

  @override
  void initState() {
    super.initState();
    _initTask();
  }

  void _initTask() async {
    final userId = context.read<User>().id;
    final res = await _taskUsecase.viewTask(userId: userId, taskId: widget.id);
    setState(() {
      _task = Task.create(res);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DetailScreen(
      backRoute: Routes.taskBoardScreen,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // task title
            Text(
              _task.title ?? '-',
              style: GoogleFonts.jetBrainsMono(
                color: Colours.text,
                fontSize: 21.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            _kSpacingBetweenItems,
            // notes
            _task.notes != null && _task.notes!.isNotEmpty
                ? DetailItem(content: _task.notes!, label: 'Notes')
                : Container(),
            _task.notes != null ? _kSpacingBetweenItems : Container(),
            // due date
            DetailItem(content: '${_task.due ?? '-'}', label: 'Due Date'),
            _kSpacingBetweenItems,
            // available
            DetailItem(
                content: '${_task.completed ?? '-'}', label: 'Available'),
            _kSpacingBetweenItems,
            // rewards
            DetailItem(
              content: _task.reward != null ? '${_task.reward} Cryois' : '-',
              label: 'Rewards',
            ),
          ],
        ),
      ),
      colour: Colours.darkBase,
      hasRightIconButton: true,
      homeRoute: Routes.homeScreen,
      rightIconColour: Colours.green,
      rightIconData: Icons.check,
      rightIconOnPress: () {
        // complete task
        setState(() => _task.completeTask());
        _taskUsecase.completeTask(
          userId: context.read<User>().id,
          taskId: widget.id,
        );
      },
    );
  }
}
