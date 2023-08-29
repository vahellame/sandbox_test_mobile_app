import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

class SQL {
  factory SQL() {
    _sql ??= const SQL._privateConstructor();

    return _sql!;
  }

  const SQL._privateConstructor();

  static const _databaseName = 'currency_database.db';
  static const _databaseVersion = 1;

  static const table = 'currency';

  static const columnId = 'id';
  static const columnName = 'name';
  static const columnRate = 'rate';

  // Singleton instance
  static SQL? _sql;
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();

    return _database!;
  }

  // Open the database
  Future<Database> _initDatabase() async {
    final documentsDirectory = await getDatabasesPath();
    final path = p.join(documentsDirectory, _databaseName);

    return openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnName TEXT NOT NULL,
            $columnRate TEXT NOT NULL
          )
          ''');
  }

  // Insert a currency into the database
  Future<int> insert(Map<String, dynamic> row) async {
    final db = await instance.database;

    return db.insert(table, row);
  }

  // Query all the rows
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    final db = await instance.database;

    return db.query(table);
  }

  // Update a row
  Future<int> update(Map<String, dynamic> row) async {
    final db = await instance.database;
    final int id = row[columnId];

    return db.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }

  // Delete a row
  Future<int> delete(int id) async {
    final db = await instance.database;

    return db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

  // Singleton instance
  static SQL get instance => _sql!;
}
