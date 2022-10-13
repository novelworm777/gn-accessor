import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gn_accessor/constants.dart';
import 'package:gn_accessor/textFields/text_field_screen.dart';

class ResearchScreen extends StatelessWidget {
  ResearchScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.red.shade200,
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 33),
          child: Center(
            child: FormBuilder(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _Label(
                      title: 'Text Field',
                      detailScreen: TextFieldScreen(),
                    ),
                    FormBuilderTextField(name: 'textField'),
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

class _Label extends StatelessWidget {
  const _Label({
    Key? key,
    required this.title,
    required this.detailScreen,
  }) : super(key: key);

  final String title;
  final Widget detailScreen;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: kFontStyle),
        TextButton(
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => detailScreen)),
            child: const Text('Details')),
      ],
    );
  }
}
