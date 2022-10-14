import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../components/templates/colour_default_screen.dart';
import '../../../config/themes/colours.dart';
import 'mobile_login_screen.dart';

/// Screen where user can log into the app.
class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return ColourDefaultScreen(
      colour: Colours.darkBase,
      child: MobileLoginScreen(formKey: _formKey),
    );
  }
}
