import 'package:flutter/material.dart';
import 'package:gn_accessor/presentation/screens/tools_screen.dart';

import '../../presentation/screens/body_index_form_screen/body_index_form_screen.dart';
import '../../presentation/screens/body_index_screen/body_index_screen.dart';
import '../../presentation/screens/login_screen/login_screen.dart';
import '../../presentation/screens/home_screen/home_screen.dart';
import '../../presentation/screens/task_board_screen/task_board_screen.dart';
import '../../presentation/screens/task_detail_screen.dart';
import 'routes.dart';

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
      case Routes.toolsScreen:
        return MaterialPageRoute(builder: (_) => const ToolsScreen());
      case Routes.taskBoardScreen:
        return MaterialPageRoute(builder: (_) => const TaskBoardScreen());
      case Routes.taskDetailScreen:
        final id = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => TaskDetailScreen(id: id));
      case Routes.bodyIndexScreen:
        return MaterialPageRoute(builder: (_) => const BodyIndexScreen());
      case Routes.bodyIndexFormScreen:
        final date = settings.arguments as DateTime;
        return MaterialPageRoute(
            builder: (_) => BodyIndexFormScreen(date: date));
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
