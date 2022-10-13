import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gn_accessor/research_screen.dart';

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GN Accessor',
      home: ResearchScreen(),
    );
  }
}
