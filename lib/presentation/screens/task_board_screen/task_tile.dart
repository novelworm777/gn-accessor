import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../components/atoms/app_list_tile.dart';
import '../../../config/themes/colours.dart';
import '../../../constants/image_path.dart';

/// List tile for tasks.
class TaskTile extends StatelessWidget {
  const TaskTile({
    Key? key,
    required this.bodyOnPress,
    required this.completion,
    required this.leadingOnPress,
    required this.reward,
    required this.title,
  }) : super(key: key);

  final VoidCallback bodyOnPress;
  final int completion;
  final VoidCallback leadingOnPress;
  final num reward;
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppListTile(
      // task title
      body: Text(
        title,
        style: GoogleFonts.jetBrainsMono(
          color: Colours.text,
          fontSize: 14.0,
          fontWeight: FontWeight.w300,
        ),
      ),
      leading: Row(
        children: <Widget>[
          // cryois icon
          Image.asset(iCryois, height: 28.0, width: 28.0),
          const SizedBox(width: 3.0),
          // number of cryois
          Text(
            '$reward',
            style: GoogleFonts.jetBrainsMono(
              color: Colours.darkText,
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
      leadingColour: Colours.lightBase,
      leadingOnPress: leadingOnPress,
      // number of completed
      trailing: Text(
        completion > 999 ? '999+' : '$completion',
        style: GoogleFonts.jetBrainsMono(
          color: Colours.darkText,
          fontSize: 11.0,
          fontWeight: FontWeight.w500,
        ),
      ),
      onPress: bodyOnPress,
    );
  }
}
