import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class ResearchScreen extends StatelessWidget {
  ResearchScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: FormBuilder(
          key: _formKey,
          child: Container(),
        ),
      ),
    );
  }
}
