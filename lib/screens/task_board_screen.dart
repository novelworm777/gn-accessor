import 'package:flutter/material.dart';

import '../components/atoms/mobile_screen.dart';
import '../components/molecules/app_header.dart';
import '../components/molecules/price_list_tile.dart';

class TaskBoardScreen extends StatelessWidget {
  const TaskBoardScreen({Key? key}) : super(key: key);

  static const String id = '/task-board';

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
              child: ListView(
                shrinkWrap: true,
                children: const [
                  PriceListTile(
                    title:
                        'Complete new Genshin Impact event and here we are now!',
                    price: 1,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
