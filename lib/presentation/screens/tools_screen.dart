import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../components/templates/main_app_screen.dart';
import '../../config/themes/colours.dart';

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
        children: <Widget>[
          MiniApp(
            iconData: FontAwesomeIcons.childReaching,
            onPress: () {},
          ),
        ],
      ),
      headerTitle: 'Tools',
    );
  }
}

/// Mini app icon button.
class MiniApp extends StatelessWidget {
  const MiniApp({
    Key? key,
    required this.iconData,
    required this.onPress,
  }) : super(key: key);

  final IconData iconData;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(21.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.75),
              blurRadius: 4,
              offset: const Offset(0, 4),
            ),
          ],
          color: Colours.lightBase,
        ),
        child: Icon(
          iconData,
          color: Colours.text,
          size: 42.0,
        ),
      ),
    );
  }
}
