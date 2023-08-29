import 'package:flutter/material.dart';

import 'core/navigation/navigation.dart';

void main() {
  runApp(const CurrencyExchange());
}

class CurrencyExchange extends StatelessWidget {
  const CurrencyExchange({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: AppRouter.router.routeInformationParser,
      routerDelegate: AppRouter.router.routerDelegate,
    );
  }
}
