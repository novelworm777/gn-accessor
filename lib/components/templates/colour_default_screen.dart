import 'package:flutter/material.dart';

import '../../utils/helpers/screen_size.dart';

/// A screen template with only colour as background.
class ColourDefaultScreen extends StatelessWidget {
  const ColourDefaultScreen({
    Key? key,
    required this.colour,
    required this.child,
    this.onTapUnfocus = true,
    this.padding = const EdgeInsets.all(33),
    this.resizeToAvoidBottomInset = false,
  }) : super(key: key);

  final Widget child;
  final Color colour;
  final bool onTapUnfocus;
  final EdgeInsetsGeometry padding;
  final bool resizeToAvoidBottomInset;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          if (onTapUnfocus) FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
          body: Container(
            color: colour,
            child: child,
            height: ScreenSize.height(context),
            padding: padding,
            width: ScreenSize.width(context),
          ),
        ),
      ),
    );
  }
}
