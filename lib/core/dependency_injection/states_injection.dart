import 'package:get_it/get_it.dart';

import '../../features/domain/controllers/currency/currencies_state.dart';

class StatesInjections {
  const StatesInjections._();

  static void inject() {
    final sl = GetIt.instance;

    sl.registerLazySingleton(CurrenciesState.new);
  }
}
