import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gn_accessor/constants.dart';

class TextFieldActionScreen extends StatelessWidget {
  TextFieldActionScreen({Key? key}) : super(key: key);

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
                    const Text('On Change', style: kFontStyle),
                    FormBuilderTextField(
                      name: 'onChange',
                      onChanged: (value) {
                        final snackBar = SnackBar(content: Text('$value'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                    ),
                    const SizedBox(height: 37),
                    const Text('Save Text Field', style: kFontStyle),
                    FormBuilderTextField(name: 'save'),
                    Center(
                      child: TextButton(
                        onPressed: () => _formKey.currentState!.save(),
                        child: const Text('Press'),
                      ),
                    ),
                    const SizedBox(height: 37),
                    const Text('Get All Text Field Data', style: kFontStyle),
                    FormBuilderTextField(name: 'getAllData'),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          _formKey.currentState!.save();
                          final formData = _formKey.currentState!.value;
                          final snackBar = SnackBar(content: Text('$formData'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                        child: const Text('Press'),
                      ),
                    ),
                    const SizedBox(height: 37),
                    const Text('Get One Text Field Data', style: kFontStyle),
                    FormBuilderTextField(name: 'getOneData'),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          _formKey.currentState!.save();
                          final formData =
                              _formKey.currentState!.value['getOneData'];
                          final snackBar = SnackBar(content: Text('$formData'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                        child: const Text('Press'),
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
