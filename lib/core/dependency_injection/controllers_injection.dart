import 'package:get_it/get_it.dart';

import '../../features/domain/controllers/currency/currencies_controller.dart';

class ControllersInjections {
  const ControllersInjections._();

  static void inject() {
    final sl = GetIt.instance;

    sl.registerLazySingleton(
      () => CurrenciesController(
        currenciesState: sl.get(),
        localCurrenciesRepository: sl.get(),
        remoteCurrenciesRepository: sl.get(),
      ),
    );
  }
}
