import 'package:flutter/material.dart';

class AppDivider extends StatelessWidget {
  const AppDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(
      color: Color(0xFFFFFFFF),
      thickness: 3.0,
      height: 28.0,
    );
  }
}
