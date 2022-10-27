import 'package:flutter/material.dart';
import 'package:gn_accessor/config/route/routes.dart';

import '../../auth/presentation/screens/login_screen.dart';
import '../../home/presentation/screens/home_screen.dart';

/// Route generator.
///
/// Reference from [Stack Overflow](https://stackoverflow.com/a/63220116).
class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.loginScreen:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case Routes.homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
