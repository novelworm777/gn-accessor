import 'package:flutter/material.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: const Icon(
        Icons.arrow_back_ios_rounded,
        color: Color(0xFFFFFFFF),
        size: 30.0,
      ),
    );
  }
}
