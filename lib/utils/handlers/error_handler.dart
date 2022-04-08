import 'package:flutter/material.dart';

import '../../components/molecules/error_screen.dart';

class ErrorHandler {
  static void notify(String message) {
    // implement notify message
  }

  static void redirect(BuildContext context, String message) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ErrorScreen(message: message)),
    );
  }
}
