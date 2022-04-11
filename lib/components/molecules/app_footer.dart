import 'package:flutter/material.dart';

import '../atoms/app_divider.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({
    Key? key,
    this.leftItem,
    this.rightItem,
  }) : super(key: key);

  final Widget? leftItem;
  final Widget? rightItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AppDivider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 21.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              leftItem ?? Container(),
              rightItem ?? Container(),
            ],
          ),
        ),
      ],
    );
  }
}
