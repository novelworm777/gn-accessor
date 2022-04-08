import 'package:flutter/material.dart';

import '../atoms/mobile_screen.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({
    Key? key,
    required this.message,
    this.colour = const Color(0xFF1B2838),
  }) : super(key: key);

  final String message;
  final Color colour;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MobileScreen(
        colour: colour,
        padding: const EdgeInsets.only(left: 37.0, right: 37.0, bottom: 45.0),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/error/icon-line-diamond-left.png'),
                  _ErrorMessage(message: message),
                  Image.asset('assets/error/icon-line-diamond-right.png'),
                ],
              ),
            ),
            const _BackButton(),
          ],
        ),
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFF969696),
            width: 3.0,
          ),
          borderRadius: BorderRadius.circular(30.0),
        ),
        padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 42.0),
        child: const Text(
          'Back',
          style: TextStyle(
            color: Color(0xFF969696),
            fontSize: 24.0,
            fontFamily: 'PoorStory',
          ),
        ),
      ),
    );
  }
}

class _ErrorMessage extends StatelessWidget {
  const _ErrorMessage({
    Key? key,
    required this.message,
  }) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 21.0, horizontal: 21.0),
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Color(0xFF969696),
          fontSize: 21.0,
          fontFamily: 'PoorStory',
        ),
      ),
    );
  }
}
