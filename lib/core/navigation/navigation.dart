import 'package:go_router/go_router.dart';

import '../../features/screens/currency_exchange_screen/currency_exchange_screen.dart';

class AppRouter {
  static String get currencyExchange => '/currency_exchange';

  static final _router = GoRouter(
    routes: routes,
    initialLocation: currencyExchange,
  );

  static GoRouter get router => _router;

  static final routes = [
    GoRoute(
      path: currencyExchange,
      builder: (_, __) => const CurrencyExchangeScreen(),
    ),
  ];
}
