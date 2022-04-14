import 'package:flutter/material.dart';
import 'package:gn_accessor/utils/screen_utils.dart';

class MobileScreen extends StatelessWidget {
  const MobileScreen({
    Key? key,
    required this.child,
    this.backgroundImage,
    this.colour,
    this.padding,
    this.popUp,
  }) : super(key: key);

  final Widget child;
  final Color? colour;
  final String? backgroundImage;
  final EdgeInsetsGeometry? padding;
  final Widget? popUp;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtils.width(context),
      height: ScreenUtils.height(context),
      padding: padding ??
          const EdgeInsets.symmetric(vertical: 24.0, horizontal: 21.0),
      decoration: BoxDecoration(
        color: colour,
        image: backgroundImage != null
            ? DecorationImage(
                image: AssetImage(backgroundImage!),
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: Stack(
        children: [
          child,
          popUp ?? Container(),
        ],
      ),
    );
  }
}
