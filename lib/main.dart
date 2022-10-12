import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gn_accessor/config/route/app_router.dart';

import 'config/route/routes.dart';

void main() {
  // disable status bar and navigation bar on mobile phone
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

  // run the app
  runApp(const GNAccessor());
}

class GNAccessor extends StatelessWidget {
  const GNAccessor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GN Accessor',
      initialRoute: Routes.initial,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
