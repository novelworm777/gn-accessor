import 'package:flutter/material.dart';
import 'package:gn_accessor/domain/usecases/task_usecase.dart';
import 'package:gn_accessor/presentation/models/task.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../components/templates/detail_screen.dart';
import '../../config/route/routes.dart';
import '../../config/themes/colours.dart';
import '../models/user.dart';

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
  late final Task _task;

  @override
  void initState() {
    super.initState();
    viewTask();
  }

  void viewTask() async {
    final userId = context.read<User>().uid;
    final res = await _taskUsecase.viewTask(userId: userId, taskId: widget.id);
    setState(() {
      _task = Task.create(res);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DetailScreen(
      colour: Colours.darkBase,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // task title
            Text(
              _task.title,
              style: GoogleFonts.jetBrainsMono(
                color: Colours.text,
                fontSize: 21.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            _kSpacingBetweenItems,
            // notes
            _DetailItem(content: _task.notes!, label: 'Notes'),
            _kSpacingBetweenItems,
            // due date
            _DetailItem(content: '${_task.due}', label: 'Due Date'),
            _kSpacingBetweenItems,
            // available
            _DetailItem(content: '${_task.completed}', label: 'Available'),
            _kSpacingBetweenItems,
            // rewards
            _DetailItem(content: '${_task.reward} Cryois', label: 'Rewards'),
          ],
        ),
      ),
      hasRightIconButton: true,
      homeRoute: Routes.homeScreen,
      rightIconColour: Colours.green,
      rightIconData: Icons.check,
      rightIconOnPress: () {
        // complete task
        setState(() => _task.completeTask());
        _taskUsecase.completeTask(
          userId: context.read<User>().uid,
          taskId: widget.id,
        );
      },
    );
  }
}

/// Item for [TaskDetailScreen].
class _DetailItem extends StatelessWidget {
  const _DetailItem({Key? key, required this.content, required this.label})
      : super(key: key);

  final String content;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          label,
          style: GoogleFonts.jetBrainsMono(
            color: Colours.darkText,
            fontSize: 17.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 7.0),
        Text(
          content,
          style: GoogleFonts.jetBrainsMono(
            color: Colours.text,
            fontSize: 15.0,
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }
}