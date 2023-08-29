import 'dart:async';

import '../../models/currency_model/currency_model.dart';
import '../../repositories/currencies_repository/local_currencies_repository.dart';
import '../../repositories/currencies_repository/remote_currencies_repository.dart';
import '../controller.dart';
import 'currencies_state.dart';

class CurrenciesController extends Controller {
  CurrenciesController({
    required this.currenciesState,
    required this.localCurrenciesRepository,
    required this.remoteCurrenciesRepository,
  });

  final LocalCurrenciesRepository localCurrenciesRepository;
  final RemoteCurrenciesRepository remoteCurrenciesRepository;
  final CurrenciesState currenciesState;

  List<CurrencyModel> get currencies  => currenciesState.currencies;
  
  Future<void> init() async {
    loadingStarted();
    currenciesState.currencies = await localCurrenciesRepository.getAllCurrencies();
    loadingFinished();
    // unawaited(_loadCurrencies());
  }
  
  Future<void> _startFetchingCurrencies() async {
    while (true) {
      currenciesState.currencies = await remoteCurrenciesRepository.getAllCurrencies();
      notifyListeners();

      for (final currency in currenciesState.currencies) {
        await localCurrenciesRepository.upsertCurrency(currency);
      }

      await Future.delayed(const Duration(seconds: 5));
    }
  } 
}