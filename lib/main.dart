import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:gn_accessor/screens/home_screen.dart';
import 'package:gn_accessor/screens/login_screen.dart';
import 'package:gn_accessor/screens/market_screen.dart';
import 'package:gn_accessor/screens/task_board_screen.dart';
import 'package:gn_accessor/screens/task_form_screen.dart';
import 'package:gn_accessor/services/user.dart';
import 'package:provider/provider.dart';

void main() async {
  // initialize firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // disable status bar and navigation bar
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

  // run app
  runApp(const GNAccessor());
}

class GNAccessor extends StatelessWidget {
  const GNAccessor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => User(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'GN Accessor',
        theme: ThemeData(
          fontFamily: 'PoorStory',
        ),
        initialRoute: LoginScreen.id,
        routes: {
          LoginScreen.id: (context) => LoginScreen(),
          HomeScreen.id: (context) => HomeScreen(),
          TaskBoardScreen.id: (context) => TaskBoardScreen(),
          TaskFormScreen.id: (context) => TaskFormScreen(),
          MarketScreen.id: (context) => MarketScreen(),
        },
        navigatorObservers: [FlutterSmartDialog.observer],
        builder: FlutterSmartDialog.init(),
      ),
    );
  }
}
