import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'core/navigation/navigation.dart';
import 'features/domain/controllers/currency/currencies_controller.dart';
import 'features/domain/use_cases/app_start_use_case.dart';

Future<void> main() async {
  await AppStartUseCase.execute();

  final sl = GetIt.instance;

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<CurrenciesController>(create: (_) => sl.get()),
    ],
    child: const CurrencyExchange(),
  ));
}

class CurrencyExchange extends StatefulWidget {
  const CurrencyExchange({super.key});

  @override
  State<CurrencyExchange> createState() => _CurrencyExchangeState();
}

class _CurrencyExchangeState extends State<CurrencyExchange> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context.read<CurrenciesController>().init();
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationProvider: Navigation.router.routeInformationProvider,
      routeInformationParser: Navigation.router.routeInformationParser,
      routerDelegate: Navigation.router.routerDelegate,
    );
  }
}
