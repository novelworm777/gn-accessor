import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gn_accessor/constants.dart';

class TextFieldCursorScreen extends StatelessWidget {
  TextFieldCursorScreen({Key? key}) : super(key: key);

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
                    const Text('Cursor Color', style: kFontStyle),
                    FormBuilderTextField(
                      name: 'cursorColor',
                      cursorColor: Colors.white,
                    ),
                    const SizedBox(height: 37),
                    const Text('Cursor Width', style: kFontStyle),
                    FormBuilderTextField(
                      name: 'cursorWidth',
                      cursorWidth: 3.7,
                    ),
                    const SizedBox(height: 37),
                    const Text('Cursor Radius: Zero', style: kFontStyle),
                    FormBuilderTextField(
                      name: 'cursorRadiusZero',
                      cursorWidth: 13.7, // complementary
                      cursorRadius: Radius.zero,
                    ),
                    const SizedBox(height: 37),
                    const Text('Cursor Radius: Circular', style: kFontStyle),
                    FormBuilderTextField(
                      name: 'cursorRadiusCircular',
                      cursorWidth: 13.7, // complementary
                      cursorRadius: const Radius.circular(3.7),
                    ),
                    const SizedBox(height: 37),
                    const Text('Cursor Radius: Elliptical', style: kFontStyle),
                    FormBuilderTextField(
                      name: 'cursorRadiusElliptical',
                      cursorWidth: 13.7, // complementary
                      cursorRadius: const Radius.elliptical(7, 13),
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
