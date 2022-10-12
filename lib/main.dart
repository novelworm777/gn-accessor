import 'package:flutter/material.dart';

void main() {
  runApp(const GNAccessor());
}

class GNAccessor extends StatelessWidget {
  const GNAccessor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GN Accessor',
      home: Container(),
    );
  }
}
