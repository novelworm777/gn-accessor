import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:provider/provider.dart';

import 'config/route/app_router.dart';
import 'config/route/routes.dart';
import 'presentation/models/user.dart';

void main() async {
  // initialize firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // disable status bar and navigation bar on mobile phone
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

  // run the app
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => User()),
      ],
      child: const GNAccessor(),
    ),
  );
}

class GNAccessor extends StatelessWidget {
  const GNAccessor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: FlutterSmartDialog.init(),
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.initial,
      navigatorObservers: [FlutterSmartDialog.observer],
      onGenerateRoute: AppRouter.generateRoute,
      title: 'GN Accessor',
    );
  }
}
