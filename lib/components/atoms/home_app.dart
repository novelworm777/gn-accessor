import 'package:flutter/material.dart';

class HomeApp extends StatelessWidget {
  const HomeApp({
    Key? key,
    required this.appIcon,
    required this.appName,
    required this.onPress,
  }) : super(key: key);

  final String appIcon;
  final String appName;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        decoration: BoxDecoration(
          color: const Color(0x5EFFFFFF),
          borderRadius: BorderRadius.circular(13.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
      ),
    );
  }
}
