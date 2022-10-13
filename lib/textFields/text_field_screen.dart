import 'package:flutter/material.dart';
import 'package:gn_accessor/textFields/text_field_keyboard_screen.dart';

const _kFontStyle = TextStyle(
  fontSize: 21,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);

class TextFieldScreen extends StatelessWidget {
  const TextFieldScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: Container(
          color: Colors.blue.shade200,
          padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 33),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _Button(
                  text: 'Keyboard',
                  nextScreen: TextFieldKeyboardScreen(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    Key? key,
    required this.text,
    required this.nextScreen,
  }) : super(key: key);

  final String text;
  final Widget nextScreen;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => nextScreen),
            ),
        child: Text(text, style: _kFontStyle));
  }
}
