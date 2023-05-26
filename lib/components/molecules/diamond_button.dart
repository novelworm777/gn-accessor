import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../atoms/diamond.dart';

/// Diamond-shaped button with only an outline.
class DiamondOutlineButton extends StatelessWidget {
  const DiamondOutlineButton({
    Key? key,
    required this.onPress,
    required this.paddingColour,
    required this.size,
    required this.buttonColour,
  }) : super(key: key);

  final VoidCallback onPress;
  final Color paddingColour;
  final double size;
  final Color buttonColour;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: CustomPaint(
        painter: Diamond(colour: paddingColour),
        child: SizedBox(
          height: size * 1.5,
          width: size * 1.5,
          child: Center(
            child: CustomPaint(
              painter: DiamondOutline(colour: buttonColour),
              child: SizedBox(
                height: size,
                width: size,
                child: Icon(
                  FontAwesomeIcons.plus,
                  color: buttonColour,
                  size: size * 0.4,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
