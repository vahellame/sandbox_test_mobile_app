import 'package:sqflite/sqflite.dart';

class SQLTables {
  static const currencyTable = 'currency';

  static const currencyColumnName = 'name';
  static const currencyColumnRate = 'rate';

  static Future<void> createTables(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $currencyTable (
        $currencyColumnName TEXT PRIMARY KEY,
        $currencyColumnRate TEXT NOT NULL
      )
    ''');
  }
}
