import 'package:flutter/material.dart';

import '../../config/themes/colours.dart';

enum FlyingLocation { left, center, right }

/// Icon button to be placed in header.
class FlyingIconButton extends StatelessWidget {
  const FlyingIconButton({
    Key? key,
    this.colour = Colours.darkBase,
    this.iconColour = Colours.text,
    required this.iconData,
    required this.location,
    required this.onPress,
    this.radius = 21.0,
  }) : super(key: key);

  final Color colour;
  final Color iconColour;
  final IconData iconData;
  final FlyingLocation location;
  final VoidCallback onPress;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: getBorderRadius(),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.75),
              blurRadius: 4,
              offset: const Offset(0, 4),
            ),
          ],
          color: colour,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 7.0),
        child: Icon(
          iconData,
          color: iconColour,
        ),
      ),
    );
  }

  BorderRadiusGeometry? getBorderRadius() {
    switch (location) {
      case FlyingLocation.left:
        return BorderRadius.only(
          bottomRight: Radius.circular(radius),
          topRight: Radius.circular(radius),
        );
      case FlyingLocation.center:
        return BorderRadius.only(
          bottomLeft: Radius.circular(radius),
          bottomRight: Radius.circular(radius),
          topLeft: Radius.circular(radius),
          topRight: Radius.circular(radius),
        );
      case FlyingLocation.right:
        return BorderRadius.only(
          bottomLeft: Radius.circular(radius),
          topLeft: Radius.circular(radius),
        );
      default:
        return null;
    }
  }
}
