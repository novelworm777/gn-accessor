import 'package:flutter/material.dart';

class HomeApp extends StatelessWidget {
  const HomeApp({
    Key? key,
    required this.appIcon,
    required this.appName,
  }) : super(key: key);

  final String appIcon;
  final String appName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 14.0),
      decoration: const BoxDecoration(
        color: Color(0x5EFFFFFF),
        borderRadius: BorderRadius.all(Radius.circular(13.0)),
      ),
      child: Column(
        children: [
          Container(
            width: 90.0,
            height: 90.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(appIcon),
                fit: BoxFit.contain,
              ),
            ),
          ),
          Text(
            appName,
            style: const TextStyle(
              color: Color(0xFF3B3B3B),
              fontSize: 15.0,
              fontFamily: 'PoorStory',
            ),
          ),
        ],
      ),
    );
  }
}
