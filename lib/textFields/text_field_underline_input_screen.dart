import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gn_accessor/constants.dart';

class TextFieldUnderlineInputScreen extends StatelessWidget {
  TextFieldUnderlineInputScreen({Key? key}) : super(key: key);

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
                    const Text('White Line (Enabled)', style: kFontStyle),
                    FormBuilderTextField(
                      name: 'whiteLineEnabled',
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                      ),
                    ),
                    const SizedBox(height: 37),
                    const Text('White Line (Focused)', style: kFontStyle),
                    FormBuilderTextField(
                      name: 'whiteLineFocused',
                      decoration: const InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                      ),
                    ),
                    const SizedBox(height: 37),
                    const Text('White Line (Disabled)', style: kFontStyle),
                    FormBuilderTextField(
                      name: 'whiteLineDisabled',
                      enabled: false,
                      decoration: const InputDecoration(
                        disabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                      ),
                    ),
                    const SizedBox(height: 37),
                    const Text('Thicker Line (Enabled)', style: kFontStyle),
                    FormBuilderTextField(
                      name: 'thickerLineEnabled',
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(width: 3.7)),
                      ),
                    ),
                    const SizedBox(height: 37),
                    const Text('Thicker Line (Focused)', style: kFontStyle),
                    FormBuilderTextField(
                      name: 'thickerLineFocused',
                      decoration: const InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(width: 3.7)),
                      ),
                    ),
                    const SizedBox(height: 37),
                    const Text('Thicker Line (Disabled)', style: kFontStyle),
                    FormBuilderTextField(
                      name: 'thickerLineDisabled',
                      enabled: false,
                      decoration: const InputDecoration(
                        disabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(width: 3.7)),
                      ),
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
