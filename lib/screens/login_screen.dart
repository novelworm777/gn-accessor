import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gn_accessor/screens/home_screen.dart';
import 'package:gn_accessor/services/auth.dart';
import 'package:gn_accessor/services/user.dart';
import 'package:gn_accessor/utils/handlers/error_handler.dart';
import 'package:provider/provider.dart';

import '../components/atoms/mobile_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  static const String id = '/login';
  final _formKey = GlobalKey<FormBuilderState>();
  final Auth _auth = Auth();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // un-focus input keyboard on blur
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: MobileScreen(
          backgroundImage: 'assets/general/bg-login-screen.png',
          child: Center(
            child: SizedBox(
              height: 55.0,
              width: 250.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          bottomLeft: Radius.circular(30.0),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          '#',
                          style: TextStyle(
                            color: Color(0xBAF4BBBB),
                            fontSize: 21.0,
                            fontFamily: "PoorStory",
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0x5EFFFFFF),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30.0),
                          bottomRight: Radius.circular(30.0),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 13.0),
                      child: Center(
                        child: FormBuilder(
                          key: _formKey,
                          child: FormBuilderTextField(
                            name: 'uid',
                            decoration: const InputDecoration(
                              counterText: '',
                              border: InputBorder.none,
                            ),
                            keyboardType: TextInputType.number,
                            style: const TextStyle(
                              letterSpacing: 13.0,
                              fontFamily: 'PoorStory',
                              fontSize: 21.0,
                              color: Color(0xFFFFFFFF),
                            ),
                            maxLength: 3,
                            cursorColor: const Color(0xFFFFFFFF),
                            onChanged: (value) async {
                              if (value != null && value.length == 3) {
                                try {
                                  final user = await _auth.login(uid: value);
                                  if (user != null) {
                                    user['uid'] = value;
                                    context.read<User>().userData = user;
                                    Navigator.pushNamed(context, HomeScreen.id);
                                  } else {
                                    ErrorHandler.redirect(context,
                                        "I'm sorry there's no such UID registered.");
                                  }
                                } catch (e) {
                                  print(e);
                                }
                                _formKey.currentState?.reset();
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
