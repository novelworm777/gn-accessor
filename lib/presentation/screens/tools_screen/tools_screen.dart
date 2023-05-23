import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../components/templates/main_app_screen.dart';
import '../../../config/route/routes.dart';
import '../../../config/themes/colours.dart';
import 'mini_app.dart';

/// Screen of mini apps.
class ToolsScreen extends StatelessWidget {
  const ToolsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainAppScreen(
      colour: Colours.darkBase,
      content: GridView.count(
        crossAxisCount: 4,
        crossAxisSpacing: 13.0,
        mainAxisSpacing: 21.0,
        primary: false,
        children: <MiniApp>[
          // body index icon button
          MiniApp(
            iconData: FontAwesomeIcons.childReaching,
            onPress: () {
              Navigator.pushNamed(context, Routes.bodyIndexScreen);
            },
          ),
          // diary app icon button
          MiniApp(
            iconData: FontAwesomeIcons.book,
            onPress: () {
              Navigator.pushNamed(context, Routes.diaryScreen);
            },
          ),
        ],
      ),
      headerTitle: 'Tools',
      homeRoute: Routes.homeScreen,
    );
  }
}
