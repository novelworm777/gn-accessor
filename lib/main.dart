import 'package:flutter/material.dart';
import 'package:gn_accessor/config/route/app_router.dart';

import 'config/route/routes.dart';

void main() {
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
