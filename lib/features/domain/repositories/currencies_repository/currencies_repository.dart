import '../../models/currency_model/currency_model.dart';

abstract class CurrenciesRepository {
  const CurrenciesRepository();

  Future<List<CurrencyModel>> getAllCurrencies();
}
