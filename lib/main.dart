import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gn_accessor/screens/login_screen.dart';

void main() {
  // disable status bar and navigation bar
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual);

  // run app
  runApp(const GNAccessor());
}

class GNAccessor extends StatelessWidget {
  const GNAccessor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GN Accessor',
      theme: ThemeData(
        fontFamily: 'PoorStory',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
      },
    );
  }
}
