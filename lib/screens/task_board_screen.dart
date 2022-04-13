import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gn_accessor/screens/task_form_screen.dart';
import 'package:gn_accessor/services/task_board.dart';
import 'package:gn_accessor/services/user.dart';
import 'package:gn_accessor/utils/handlers/notification_handler.dart';
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
                ),
              );
            }).toList(),
          );
        },
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
