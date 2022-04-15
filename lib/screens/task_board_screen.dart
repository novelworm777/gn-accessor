import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gn_accessor/screens/task_form_screen.dart';
import 'package:gn_accessor/services/task_board.dart';
import 'package:gn_accessor/services/user.dart';
import 'package:gn_accessor/utils/constants.dart';
import 'package:gn_accessor/utils/handlers/notification_handler.dart';
import 'package:gn_accessor/utils/screen_utils.dart';
import 'package:provider/provider.dart';

import '../components/atoms/chip_button.dart';
import '../components/atoms/mobile_screen.dart';
import '../components/molecules/app_footer.dart';
import '../components/molecules/app_header.dart';
import '../components/molecules/price_list_tile.dart';

class TaskBoardScreen extends StatefulWidget {
  const TaskBoardScreen({Key? key}) : super(key: key);

  static const String id = '/task-board';

  @override
  State<TaskBoardScreen> createState() => _TaskBoardScreenState();
}

class _TaskBoardScreenState extends State<TaskBoardScreen> {
  final int _seconds = 2;
  bool _isVisible = true;

  @override
  void initState() {
    super.initState();
    NotificationHandler.init(mounted, seconds: _seconds, callback: () {
      if (mounted) {
        setState(() {
          _isVisible = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final message = ModalRoute.of(context)!.settings.arguments != null
        ? ModalRoute.of(context)!.settings.arguments as String
        : null;
    if (message == null) _isVisible = false;

    return Scaffold(
      body: MobileScreen(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        backgroundImage: 'assets/general/bg-general-app-screen.png',
        child: Column(
          children: [
            const _TaskBoardHeader(),
            _TaskBoardContent(),
            const _TaskBoardFooter(),
          ],
        ),
        popUp: NotificationHandler.notify(
          context,
          message,
          isVisible: _isVisible,
          backgroundColour: const Color(0xFF3B3B3B),
          fontColour: const Color(0xFF88BFFF),
        ),
      ),
    );
  }
}

class _TaskBoardHeader extends StatelessWidget {
  const _TaskBoardHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AppHeader(title: 'Task Board');
  }
}

class _TaskBoardContent extends StatelessWidget {
  _TaskBoardContent({
    Key? key,
  }) : super(key: key);

  final _taskBoard = TaskBoard();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream: _taskBoard.getTasks(context.watch<User>().uid!),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }
          if (!snapshot.hasData) {
            return const Text('Task Board is empty!');
          }
          return ListView(
            children: snapshot.data!.docs.map((task) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 7.0),
                child: PriceListTile(
                  title: task['title'],
                  price: task['reward'],
                  onPressed: () {
                    _viewTaskDetails(context, task);
                  },
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }

  Future<dynamic> _viewTaskDetails(
      BuildContext context, QueryDocumentSnapshot task) {
    return showDialog(
        context: context,
        builder: (context) {
          return _TaskDetailsDialog();
        });
  }
}

class _TaskDetailsDialog extends StatelessWidget {
  const _TaskDetailsDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      // backgroundColor: const Color(0xFF3B3B3B),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(13.0)),
      ),
      insetPadding:
          const EdgeInsets.symmetric(horizontal: 21.0, vertical: 21.0),
      child: SizedBox(
        height: ScreenUtils.height(context, ratio: 0.67),
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
              flex: 6,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 28.0),
                decoration: const BoxDecoration(
                  color: Color(0xFF3B3B3B),
                  borderRadius: BorderRadius.only(
                    topLeft: kSmallRadius,
                    topRight: kSmallRadius,
                  ),
                ),
                child: Column(
                  children: const [
                    _TaskDetail(
                      text: 'Complete new Genshin Impact event',
                      fontSize: 21.0,
                      fontWeight: FontWeight.bold,
                      padding: EdgeInsets.symmetric(horizontal: 42.0),
                    ),
                    SizedBox(height: 42),
                    _TaskDetail(
                        text:
                            'A new version has come and there’s lots of new events going on. Do your best to complete them!'),
                    SizedBox(height: 13),
                    _TaskDetail(text: 'Due by [date] [time].'),
                    SizedBox(height: 13),
                    _TaskDetail(text: 'Due by 1 Jan 22 7:45 PM.'),
                    SizedBox(height: 13),
                    _TaskDetail(
                        text:
                            'A reward of 1 coin will be given after each time completing the task.'),
                    SizedBox(height: 42),
                    _TaskDetail(text: 'Good luck, Tasker!'),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: const [
                  _DeleteTaskButton(),
                  _CompleteTaskButton(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _TaskDetail extends StatelessWidget {
  const _TaskDetail({
    Key? key,
    required this.text,
    this.fontSize,
    this.fontWeight,
    this.padding,
  }) : super(key: key);

  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 21.0),
      child: SizedBox(
        width: double.infinity,
        child: Text(
          text,
          style: TextStyle(
            color: const Color(0xFFC4C4C4),
            fontSize: fontSize ?? 19.0,
            fontFamily: 'PoorStory',
            fontWeight: fontWeight,
          ),
          textAlign: TextAlign.start,
        ),
      ),
    );
  }
}

class _DeleteTaskButton extends StatelessWidget {
  const _DeleteTaskButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF2E2E2E),
          borderRadius: BorderRadius.only(bottomLeft: kSmallRadius),
        ),
        child: IconButton(
          icon: const Icon(
            Icons.delete_outline_rounded,
            color: Color(0xFFC10404),
            size: 40.0,
          ),
          padding: EdgeInsets.zero,
          onPressed: () {},
        ),
      ),
    );
  }
}

class _CompleteTaskButton extends StatelessWidget {
  const _CompleteTaskButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF88BFFF),
          borderRadius: BorderRadius.only(bottomRight: kSmallRadius),
        ),
        child: TextButton(
          child: const Text(
            'Done',
            style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 35.0,
              fontFamily: 'PoorStory',
            ),
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}

class _TaskBoardFooter extends StatelessWidget {
  const _TaskBoardFooter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppFooter(
      rightItem: ChipButton(
        title: 'Create Task',
        onPress: () => Navigator.pushNamed(context, TaskFormScreen.id),
      ),
    );
  }
}
