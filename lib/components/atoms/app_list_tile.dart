import 'package:flutter/material.dart';
import 'package:gn_accessor/utils/constants.dart';

class AppListTile extends StatelessWidget {
  const AppListTile({
    Key? key,
    required this.title,
    this.trailing,
  }) : super(key: key);

  final String title;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 21.0),
              padding: const EdgeInsets.all(13.0),
              decoration: const BoxDecoration(
                color: Color(0x5EFFFFFF),
                borderRadius: BorderRadius.only(
                  topLeft: kSmallRadius,
                  bottomLeft: kSmallRadius,
                ),
              ),
              child: Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF3B3B3B),
                  fontSize: 15.0,
                  fontFamily: 'PoorStory',
                ),
              ),
            ),
          ),
          trailing ?? Container(),
        ],
      ),
    );
  }
}
