import 'package:flutter/material.dart';

class MobileScreen extends StatelessWidget {
  const MobileScreen({
    Key? key,
    required this.child,
    this.backgroundImage,
    this.colour,
    this.padding,
  }) : super(key: key);

  final Widget child;
  final Color? colour;
  final String? backgroundImage;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: child,
    );
  }
}
