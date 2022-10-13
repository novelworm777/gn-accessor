import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gn_accessor/constants.dart';

class TextFieldLabelAlignmentScreen extends StatelessWidget {
  TextFieldLabelAlignmentScreen({Key? key}) : super(key: key);

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
                    const Text('Label Alignment: Left', style: kFontStyle),
                    FormBuilderTextField(
                      name: 'labelAlignmentLeft',
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: 37),
                    const Text('Label Alignment: Center', style: kFontStyle),
                    FormBuilderTextField(
                      name: 'labelAlignmentCenter',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 37),
                    const Text('Label Alignment: Right', style: kFontStyle),
                    FormBuilderTextField(
                      name: 'labelAlignmentRight',
                      textAlign: TextAlign.right,
                    ),
                    const SizedBox(height: 37),
                    const Text('Label Alignment: Start', style: kFontStyle),
                    FormBuilderTextField(
                      name: 'labelAlignmentStart',
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: 37),
                    const Text('Label Alignment: End', style: kFontStyle),
                    FormBuilderTextField(
                      name: 'labelAlignmentEnd',
                      textAlign: TextAlign.end,
                    ),
                    const SizedBox(height: 37),
                    const Text('Label Alignment: Justify', style: kFontStyle),
                    FormBuilderTextField(
                      name: 'labelAlignmentJustify',
                      textAlign: TextAlign.justify,
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
