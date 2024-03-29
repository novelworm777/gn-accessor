import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

import '../../../components/templates/colour_default_screen.dart';
import '../../../config/route/routes.dart';
import '../../../config/themes/colours.dart';
import '../../../domain/usecases/user_usecase.dart';
import '../../models/user.dart';

/// Screen where user can log into the app.
class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final UserUsecase _userUsecase = UserUsecase();
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return ColourDefaultScreen(
      colour: Colours.darkBase,
      child: Center(
        child: FormBuilder(
          key: _formKey,
          child: FormBuilderTextField(
            name: 'uid',
            cursorColor: Colours.text,
            decoration: const InputDecoration(
              counterText: '',
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colours.text),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colours.text),
              ),
            ),
            keyboardType: TextInputType.number,
            maxLength: 3,
            onChanged: (value) async {
              if (value != null && value.length == 3) {
                try {
                  // login
                  final res = await _userUsecase.login(uid: value);
                  // save the data locally
                  context.read<User>().user = res;
                  // push into home screen
                  Navigator.pushNamed(context, Routes.homeScreen);
                } catch (error) {
                  _formKey.currentState?.reset();
                }
              }
            },
            style: const TextStyle(
              color: Colours.text,
              letterSpacing: 13.0,
              fontSize: 17.0,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
