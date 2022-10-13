import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gn_accessor/constants.dart';

class TextFieldInputAlignmentScreen extends StatelessWidget {
  TextFieldInputAlignmentScreen({Key? key}) : super(key: key);

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
                    const Text('Input Alignment: Left', style: kFontStyle),
                    FormBuilderTextField(
                      name: 'inputAlignmentLeft',
                      textAlign: TextAlign.left,
                      initialValue: "something", // complementary
                    ),
                    const SizedBox(height: 37),
                    const Text('Input Alignment: Center', style: kFontStyle),
                    FormBuilderTextField(
                      name: 'inputAlignmentCenter',
                      textAlign: TextAlign.center,
                      initialValue: "something", // complementary
                    ),
                    const SizedBox(height: 37),
                    const Text('Input Alignment: Right', style: kFontStyle),
                    FormBuilderTextField(
                      name: 'inputAlignmentRight',
                      textAlign: TextAlign.right,
                      initialValue: "something", // complementary
                    ),
                    const SizedBox(height: 37),
                    const Text('Input Alignment: Start', style: kFontStyle),
                    FormBuilderTextField(
                      name: 'inputAlignmentStart',
                      textAlign: TextAlign.start,
                      initialValue: "something", // complementary
                    ),
                    const SizedBox(height: 37),
                    const Text('Input Alignment: End', style: kFontStyle),
                    FormBuilderTextField(
                      name: 'inputAlignmentEnd',
                      textAlign: TextAlign.end,
                      initialValue: "something", // complementary
                    ),
                    const SizedBox(height: 37),
                    const Text('Input Alignment: Justify', style: kFontStyle),
                    FormBuilderTextField(
                      name: 'inputAlignmentJustify',
                      textAlign: TextAlign.justify,
                      initialValue: "something", // complementary
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
