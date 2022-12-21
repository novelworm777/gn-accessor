import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../config/themes/colours.dart';
import '../../../types/body_index_component.dart';
import 'body_index_component_form.dart';

/// Component widget for basic profile components.
class BasicProfileComponentForm extends StatefulWidget {
  const BasicProfileComponentForm({
    Key? key,
    required this.componentType,
    this.initialValue,
    required this.isLocked,
    required this.onChanged,
    required this.onPress,
  }) : super(key: key);

  final BodyIndexComponent componentType;
  final String? initialValue;
  final bool isLocked;
  final void Function(dynamic) onChanged;
  final VoidCallback onPress;

  @override
  State<BasicProfileComponentForm> createState() =>
      _BasicProfileComponentFormState();
}

class _BasicProfileComponentFormState extends State<BasicProfileComponentForm> {
  @override
  Widget build(BuildContext context) {
    return BodyIndexComponentForm(
      componentType: widget.componentType,
      iconButtonColour: Colours.lightBase,
      iconColour: Colours.text,
      iconData:
          widget.isLocked ? FontAwesomeIcons.lock : FontAwesomeIcons.lockOpen,
      initialValue: widget.initialValue,
      isDisabled: widget.isLocked,
      onChanged: widget.onChanged,
      onPress: widget.onPress,
    );
  }
}
