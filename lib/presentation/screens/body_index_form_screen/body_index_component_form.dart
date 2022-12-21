import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../components/atoms/circular_button.dart';
import '../../../config/themes/colours.dart';
import '../../../types/body_index_component.dart';
import '../../../types/gender.dart';

const _kFontSize = 15.0;
const _kFormTextStyle = TextStyle(
  color: Colours.darkBase,
  fontSize: 15.0,
);

/// Body index component widget for form usage.
class BodyIndexComponentForm extends StatelessWidget {
  const BodyIndexComponentForm({
    Key? key,
    required this.componentType,
    this.initialValue,
    required this.iconButtonColour,
    required this.iconColour,
    required this.iconData,
    this.isDisabled = false,
    required this.onChanged,
    required this.onPress,
  }) : super(key: key);

  final BodyIndexComponent componentType;
  final String? initialValue;
  final Color iconButtonColour;
  final Color iconColour;
  final IconData iconData;
  final bool isDisabled;
  final void Function(dynamic) onChanged;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        SizedBox(
          width: 100,
          child: Text(
            componentType.pretty,
            softWrap: true,
            style: GoogleFonts.jetBrainsMono(
              color: Colours.darkText,
              fontSize: _kFontSize,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Row(
          children: <Widget>[
            SizedBox(
              width: 100.0,
              child: _generateForm(),
            ),
            if (componentType.notation != null) const SizedBox(width: 13.0),
            if (componentType.notation != null)
              Text(
                componentType.notation!.trim(),
                style: GoogleFonts.jetBrainsMono(
                  color: Colours.darkText,
                  fontSize: _kFontSize,
                  fontWeight: FontWeight.w500,
                ),
              ),
            const SizedBox(width: 13.0),
            CircularButton(
              colour: iconButtonColour,
              icon: Icon(
                iconData,
                color: iconColour,
                size: 13.0,
              ),
              onPress: onPress,
              size: 28.0,
            ),
          ],
        ),
      ],
    );
  }

  /// Generate form based on its component type.
  Widget _generateForm() {
    switch (componentType) {
      case BodyIndexComponent.gender:
        return FormBuilderDropdown(
          decoration: _getFormDecoration(),
          dropdownColor: Colours.text,
          enabled: !isDisabled,
          iconSize: 0,
          initialValue: initialValue,
          itemHeight: 49.0,
          items: Gender.values
              .map((element) => DropdownMenuItem(
                    value: element.name,
                    child: Text(element.pretty),
                  ))
              .toList(),
          name: componentType.name,
          onChanged: onChanged,
          style: _kFormTextStyle,
        );
      default:
        return FormBuilderTextField(
          decoration: _getFormDecoration(),
          enabled: !isDisabled,
          initialValue: initialValue,
          name: componentType.name,
          onChanged: onChanged,
          readOnly: isDisabled,
          showCursor: false,
          style: _kFormTextStyle,
          textAlign: TextAlign.right,
        );
    }
  }

  /// Get default decoration for forms.
  InputDecoration _getFormDecoration() {
    return InputDecoration(
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 13.0,
        vertical: 7.0,
      ),
      disabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(7.0)),
        borderSide: BorderSide.none,
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(7.0)),
        borderSide: BorderSide.none,
      ),
      filled: true,
      fillColor: isDisabled ? const Color(0xFFC3C3C3) : Colours.text,
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(7.0)),
        borderSide: BorderSide(
          color: Colours.darkText,
          strokeAlign: StrokeAlign.center,
          width: 3.0,
        ),
      ),
    );
  }
}
