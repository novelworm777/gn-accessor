import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../components/templates/detail_screen.dart';
import '../../../config/themes/colours.dart';

const _kSpacingBetweenItems = SizedBox(height: 33.0);

class TaskDetailScreen extends StatelessWidget {
  const TaskDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DetailScreen(
      colour: Colours.darkBase,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // task title
            Text(
              'Task Title',
              style: GoogleFonts.jetBrainsMono(
                color: Colours.text,
                fontSize: 21.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            _kSpacingBetweenItems,
            // notes
            const _DetailItem(
              content:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse sollicitudin ultrices magna ut ornare. Integer nibh magna, egestas ac arcu in, congue posuere augue. Pellentesque interdum congue nibh, vel aliquet arcu luctus non. Vestibulum cursus at dolor ut tristique. Suspendisse at viverra justo, quis laoreet nisi. Morbi sit amet massa vel quam commodo congue. In sit amet arcu consectetur, molestie magna quis, dignissim mi. Fusce suscipit iaculis sem, et condimentum purus. Pellentesque placerat arcu mauris, at pharetra turpis tincidunt ut. Donec at tellus dui. Proin sodales volutpat dapibus.',
              label: 'Notes',
            ),
            _kSpacingBetweenItems,
            // due date
            const _DetailItem(content: '1 Oct 2022 7:03 AM', label: 'Due Date'),
            _kSpacingBetweenItems,
            // available
            const _DetailItem(content: '999+', label: 'Available'),
            _kSpacingBetweenItems,
            // rewards
            const _DetailItem(content: '99.00 Cryois', label: 'Rewards'),
          ],
        ),
      ),
      hasRightIconButton: true,
      // TODO set homeRoute
      rightIconColour: Colours.green,
      rightIconData: Icons.check,
      rightIconOnPress: () {
        // TODO complete task
      },
    );
  }
}

class _DetailItem extends StatelessWidget {
  const _DetailItem({Key? key, required this.content, required this.label})
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
