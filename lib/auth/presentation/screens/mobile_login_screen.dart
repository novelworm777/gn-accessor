import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../config/themes/colours.dart';

/// Login Screen for Mobile App
class MobileLoginScreen extends StatelessWidget {
  const MobileLoginScreen({
    Key? key,
    required GlobalKey<FormBuilderState> formKey,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormBuilderState> _formKey;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FormBuilder(
        key: _formKey,
        child: FormBuilderTextField(
          name: 'uid',
          cursorColor: Colours.text,
          decoration: const InputDecoration(
            counterText: '',
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colours.text),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colours.text),
            ),
          ),
          keyboardType: TextInputType.number,
          maxLength: 3,
          onChanged: (value) {
            if (value != null && value.length == 3) {
              // TODO login
              final loginRes = null;

              // TODO push into Home Screen if login succeed
              if (loginRes != null) {}
            }
          },
          style: const TextStyle(
            color: Colours.text,
            letterSpacing: 13.0,
            fontSize: 17.0,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
