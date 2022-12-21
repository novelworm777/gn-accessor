import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../config/themes/colours.dart';

/// Item for [TaskDetailScreen].
class DetailItem extends StatelessWidget {
  const DetailItem({Key? key, required this.content, required this.label})
      : super(key: key);

  final String content;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          label,
          style: GoogleFonts.jetBrainsMono(
            color: Colours.darkText,
            fontSize: 17.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 7.0),
        Text(
          content,
          style: GoogleFonts.jetBrainsMono(
            color: Colours.text,
            fontSize: 15.0,
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }
}
