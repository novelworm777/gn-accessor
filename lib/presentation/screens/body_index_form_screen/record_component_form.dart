import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../config/themes/colours.dart';
import '../../../types/body_index_component.dart';
import 'body_index_component_form.dart';

/// Component widget for body index and circumference components.
class RecordComponentForm extends StatelessWidget {
  const RecordComponentForm({
    Key? key,
    required this.componentType,
    required this.deleteCallback,
    this.initialValue,
    this.isDisabled = false,
    required this.onChanged,
  }) : super(key: key);

  final BodyIndexComponent componentType;
  final VoidCallback deleteCallback;
  final String? initialValue;
  final bool isDisabled;
  final void Function(dynamic) onChanged;

  @override
  Widget build(BuildContext context) {
    return BodyIndexComponentForm(
      componentType: componentType,
      iconButtonColour: Colours.red,
      iconColour: Colours.text,
      iconData: FontAwesomeIcons.solidTrashCan,
      initialValue: initialValue,
      isDisabled: isDisabled,
      onChanged: onChanged,
      onPress: deleteCallback,
    );
  }
}
