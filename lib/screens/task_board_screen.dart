import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gn_accessor/services/task_board.dart';
import 'package:gn_accessor/services/user.dart';
import 'package:provider/provider.dart';

import '../components/atoms/chip_button.dart';
import '../components/atoms/mobile_screen.dart';
import '../components/molecules/app_footer.dart';
import '../components/molecules/app_header.dart';
import '../components/molecules/price_list_tile.dart';

class TaskBoardScreen extends StatelessWidget {
  TaskBoardScreen({Key? key}) : super(key: key);

  static const String id = '/task-board';
  final _taskBoard = TaskBoard();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MobileScreen(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        backgroundImage: 'assets/general/bg-general-app-screen.png',
        child: Column(
          children: [
            const AppHeader(title: 'Task Board'),
            Expanded(
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
                          title: task['name'],
                          price: task['reward'],
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
            AppFooter(
              rightItem: ChipButton(
                title: 'Create Task',
                onPress: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
