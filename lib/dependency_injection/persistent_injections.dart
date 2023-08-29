import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../features/data/repositories/local_currencies_repository_impl.dart';
import '../features/data/repositories/remote_currencies_repository_impl.dart';
import '../features/domain/repositories/currencies_repository/local_currencies_repository.dart';
import '../features/domain/repositories/currencies_repository/remote_currencies_repository.dart';

class PersistentInjections {
  const PersistentInjections._();

  static void inject() {
    final sl = GetIt.instance;

    sl.registerLazySingleton(Dio.new);

    sl.registerLazySingleton<LocalCurrenciesRepository>(LocalCurrenciesRepositoryImpl.new);
    sl.registerLazySingleton<RemoteCurrenciesRepository>(() => RemoteCurrenciesRepositoryImpl(sl.get()));
  }
}
