import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

import 'sql_tables.dart';

class SQL {
  const SQL._();

  static const _databaseName = 'currency_database.db';
  static const _databaseVersion = 1;

  static late Database _db;
  static Database get db => _db;

  static Future<void> init() async {
    _db = await _initDatabase();
  }

  static Future<Database> _initDatabase() async {
    final documentsDirectory = await getDatabasesPath();
    final path = p.join(documentsDirectory, _databaseName);

    return openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  static Future<void> _onCreate(Database db, int _) async {
    await SQLTables.createTables(db);
  }
}
