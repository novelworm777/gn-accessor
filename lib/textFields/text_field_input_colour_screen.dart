import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gn_accessor/constants.dart';

class TextFieldInputColourScreen extends StatelessWidget {
  TextFieldInputColourScreen({Key? key}) : super(key: key);

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
                    const Text('Input Colour', style: kFontStyle),
                    FormBuilderTextField(
                      name: 'inputColour',
                      style: const TextStyle(color: Colors.white),
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
