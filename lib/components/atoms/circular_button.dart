import 'package:flutter/material.dart';

import '../../config/themes/colours.dart';

/// Circular icon button.
class CircularButton extends StatelessWidget {
  const CircularButton({
    Key? key,
    this.colour = Colours.lightBase,
    required this.icon,
    required this.onPress,
    this.size = 50.0,
  }) : super(key: key);

  final Color colour;
  final Icon icon;
  final VoidCallback onPress;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: colour, shape: BoxShape.circle),
      height: size,
      width: size,
      child: IconButton(
        enableFeedback: true,
        icon: icon,
        onPressed: onPress,
      ),
    );
  }
}
