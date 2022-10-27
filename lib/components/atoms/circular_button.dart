import 'package:flutter/material.dart';
import 'package:gn_accessor/config/themes/colours.dart';

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
      child: IconButton(
        enableFeedback: true,
        icon: icon,
        onPressed: onPress,
      ),
      decoration: BoxDecoration(color: colour, shape: BoxShape.circle),
      height: size,
      width: size,
    );
  }
}
