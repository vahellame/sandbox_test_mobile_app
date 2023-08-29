import 'package:decimal/decimal.dart';
import 'package:sqflite/sqflite.dart';

import '../../../core/sql/sql.dart';
import '../../../core/sql/sql_tables.dart';
import '../../domain/models/currency_model/currency_model.dart';
import '../../domain/repositories/currencies_repository/local_currencies_repository.dart';

class LocalCurrenciesRepositoryImpl implements LocalCurrenciesRepository {
  const LocalCurrenciesRepositoryImpl();

  @override
  Future<List<CurrencyModel>> getAllCurrencies() async {
    final maps = await SQL.db.query(SQLTables.currencyTable);

    return List.generate(maps.length, (i) {
      return CurrencyModel(
        name: maps[i][SQLTables.currencyColumnName]! as String,
        rate: Decimal.parse(maps[i][SQLTables.currencyColumnRate]! as String),
      );
    });
  }

  @override
  Future<void> upsertCurrency(CurrencyModel currency) async {
    await SQL.db.insert(
      SQLTables.currencyTable,
      {
        SQLTables.currencyColumnName: currency.name,
        SQLTables.currencyColumnRate: currency.rate.toString(),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> deleteCurrency(String name) async {
    await SQL.db.delete(
      SQLTables.currencyTable,
      where: '${SQLTables.currencyColumnName} = ?',
      whereArgs: [name],
    );
  }
}
