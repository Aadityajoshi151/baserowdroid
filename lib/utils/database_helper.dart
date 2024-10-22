import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/table_data_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    // Define the path to the database
    String path = join(await getDatabasesPath(), 'table_data.db');

    // Open the database and create the table if it doesn't exist
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  // Create table when the database is first created
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE table_data (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        table_name TEXT NOT NULL,
        baserow_table_id INTEGER NOT NULL
      )
    ''');
  }

  // Insert a new record
  Future<int> insertTableData(TableData tableData) async {
    final db = await database;
    return await db.insert('table_data', tableData.toMap());
  }

  // Get all records
  Future<List<TableData>> getAllTableData() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('table_data');

    return List.generate(maps.length, (i) {
      return TableData.fromMap(maps[i]);
    });
  }

  // Update a record
  Future<int> updateTableData(TableData tableData) async {
    final db = await database;
    return await db.update(
      'table_data',
      tableData.toMap(),
      where: 'id = ?',
      whereArgs: [tableData.id],
    );
  }

  // Delete a record
  Future<int> deleteTableData(int id) async {
    final db = await database;
    return await db.delete(
      'table_data',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Close the database
  Future<void> close() async {
    final db = await database;
    db.close();
  }
}
