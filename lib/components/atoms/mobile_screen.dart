import 'package:flutter/material.dart';

class MobileScreen extends StatelessWidget {
  const MobileScreen({
    Key? key,
    required this.child,
    this.backgroundImage = '',
  }) : super(key: key);

  final Widget child;
  final String backgroundImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(backgroundImage),
          fit: BoxFit.cover,
        ),
      ),
      child: child,
    );
  }
}
