import 'package:flutter/material.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: const Icon(
        Icons.arrow_back_ios_rounded,
        color: Color(0xFFFFFFFF),
        size: 30.0,
      ),
    );
  }
}
