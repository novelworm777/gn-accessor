import 'package:flutter/material.dart';
import 'package:gn_accessor/screens/home_screen.dart';
import 'package:gn_accessor/utils/constants.dart';

import '../atoms/app_back_button.dart';
import '../atoms/app_divider.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({
    Key? key,
    this.title,
  }) : super(key: key);

  final String? title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 21.0),
          child: Stack(
            children: [
              Center(
                child: title != null ? Text(title!, style: kTitleStyle) : null,
              ),
              AppBackButton(
                onPressed: () => Navigator.pushNamed(context, HomeScreen.id),
              ),
            ],
          ),
        ),
        const AppDivider(),
      ],
    );
  }
}
