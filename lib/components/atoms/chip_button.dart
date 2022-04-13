import 'package:flutter/material.dart';
import 'package:gn_accessor/utils/constants.dart';

class ChipButton extends StatelessWidget {
  const ChipButton({
    Key? key,
    required this.title,
    required this.onPress,
    this.dropShadow = true,
    this.colour,
  }) : super(key: key);

  final String title;
  final VoidCallback onPress;
  final bool dropShadow;
  final Color? colour;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 17.0),
        decoration: BoxDecoration(
          color: colour ?? const Color(0xFF2E2E2E),
          borderRadius: const BorderRadius.all(kBigRadius),
          boxShadow: dropShadow ? [kDarkShadow] : null,
        ),
        child: Text(
          title,
          style: const TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 17.0,
            fontFamily: 'PoorStory',
          ),
        ),
      ),
    );
  }
}
