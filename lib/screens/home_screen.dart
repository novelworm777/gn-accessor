import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gn_accessor/screens/task_board_screen.dart';
import 'package:gn_accessor/utils/constants.dart';
import 'package:intl/intl.dart';

import '../components/atoms/home_app.dart';
import '../components/atoms/mobile_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  static const String id = '/home';
  final String _time = DateFormat('HH:mm').format(DateTime.now());
  final String _dateMonth = DateFormat('d/M').format(DateTime.now());
  final String _day = DateFormat('EEE').format(DateTime.now()).toUpperCase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MobileScreen(
        padding: const EdgeInsets.only(
            left: 21.0, right: 21.0, top: 120.0, bottom: 45.0),
        backgroundImage: 'assets/general/bg-home-screen.png',
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              child: Column(
                children: [
                  Text(
                    _time,
                    style: const TextStyle(
                      color: Color(0xFF3B3B3B),
                      fontSize: 70.0,
                      fontFamily: 'PoorStory',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '$_dateMonth $_day',
                    style: const TextStyle(
                      color: Color(0xFF3B3B3B),
                      fontSize: 21.0,
                      fontFamily: 'PoorStory',
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              child: Flex(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                direction: Axis.horizontal,
                children: [
                  HomeApp(
                    appName: 'Task Board',
                    appIcon: 'assets/home/icon-task-board.png',
                    onPress: () {
                      Navigator.pushNamed(context, TaskBoardScreen.id);
                    },
                  ),
                  HomeApp(
                    appName: 'Market',
                    appIcon: 'assets/home/icon-market.png',
                    onPress: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(),
            MaterialButton(
              onPressed: () => SystemNavigator.pop(),
              child: Container(
                width: 55.0,
                height: 55.0,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    color: Color(0x5EFFFFFF),
                    shape: BoxShape.circle,
                    boxShadow: [kDarkShadow]),
                child: const Icon(
                  Icons.power_settings_new,
                  size: 50.0,
                  color: Color(0xFFFFFFFF),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
