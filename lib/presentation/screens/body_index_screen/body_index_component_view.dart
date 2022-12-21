import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../config/themes/colours.dart';

/// Body index component widget for view usage.
class BodyIndexComponentView extends StatelessWidget {
  const BodyIndexComponentView({
    Key? key,
    required this.name,
    this.notation,
    required this.value,
  }) : super(key: key);

  final String name;
  final String? notation;
  final Object value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Text>[
        Text(
          name,
          style: GoogleFonts.jetBrainsMono(
            color: Colours.darkText,
            fontSize: 13.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          notation != null ? "$value$notation" : "$value",
          style: GoogleFonts.jetBrainsMono(
            color: Colours.darkText,
            fontSize: 13.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
