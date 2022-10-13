import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gn_accessor/constants.dart';

class TextFieldLetterSpacingScreen extends StatelessWidget {
  TextFieldLetterSpacingScreen({Key? key}) : super(key: key);

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
                    const Text('Obscure Text', style: kFontStyle),
                    FormBuilderTextField(
                      name: 'obscureText',
                      style: const TextStyle(letterSpacing: 13.0),
                      initialValue: 'something', // complementary
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
