import 'package:decimal/decimal.dart';
import 'package:dio/dio.dart';

import '../../../core/constants/constants.dart';
import '../../domain/models/currency_model/currency_model.dart';
import '../../domain/repositories/currencies_repository/remote_currencies_repository.dart';

class RemoteCurrenciesRepositoryImpl implements RemoteCurrenciesRepository {
  const RemoteCurrenciesRepositoryImpl(this.dio);

  final Dio dio;

  @override
  Future<List<CurrencyModel>> getAllCurrencies() async {
    final response = await dio.get(
      Constants.currencyBaseUrl,
      queryParameters: {
        'apikey': Constants.currencyApiKey,
      },
    );

    if (response.statusCode == 200) {
      final currenciesJson = response.data as Map;
      final currenciesRaw = currenciesJson['data'] as Map;

      // I am too lazy to convert in to tear-off
      //ignore: unnecessary_lambdas
      final currencies = <CurrencyModel>[];
      for (final currencyName in currenciesRaw.keys) {
        currencies.add(CurrencyModel(
          name: currencyName,
          rate: Decimal.parse(currenciesRaw[currencyName].toString()),
        ));
      }

      return currencies;
    }

    throw Exception('Failed to load currencies');
  }
}
