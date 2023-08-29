import '../../models/currency_model/currency_model.dart';
import 'currencies_repository.dart';

abstract class LocalCurrenciesRepository extends CurrenciesRepository {
  const LocalCurrenciesRepository();

  Future<void> upsertCurrency(CurrencyModel currency);

  Future<void> deleteCurrency(String name);
}
