import 'package:flutter/material.dart';

class MaskImageButton extends StatelessWidget {
  const MaskImageButton({
    Key? key,
    required this.onPressed,
    required this.imagePath,
    this.isDisabled = false,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String imagePath;
  final bool isDisabled;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: !isDisabled ? onPressed : null,
      child: ColorFiltered(
        colorFilter: ColorFilter.mode(
          !isDisabled ? const Color(0xFF89CA00) : const Color(0xFF969696),
          BlendMode.srcIn,
        ),
        child: Image.asset(
          imagePath,
          height: 33.0,
          width: 33.0,
        ),
      ),
    );
  }
}
