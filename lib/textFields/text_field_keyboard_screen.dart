import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gn_accessor/constants.dart';

class TextFieldKeyboardScreen extends StatelessWidget {
  TextFieldKeyboardScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.green.shade200,
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 33),
          child: Center(
            child: FormBuilder(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Text Keyboard', style: kFontStyle),
                    FormBuilderTextField(
                      name: 'textKeyboard',
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: 37),
                    const Text('Numerical Keyboard', style: kFontStyle),
                    FormBuilderTextField(
                      name: 'numericalKeyboard',
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 37),
                    const Text('Email Keyboard', style: kFontStyle),
                    FormBuilderTextField(
                      name: 'emailKeyboard',
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 37),
                    const Text('Phone Keyboard', style: kFontStyle),
                    FormBuilderTextField(
                      name: 'phoneKeyboard',
                      keyboardType: TextInputType.phone,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
