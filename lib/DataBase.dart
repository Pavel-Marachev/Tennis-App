import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {

  static final _databaseName = "MyDatabase.db";
  static final _databaseVersion = 1;

  static final table = 'my_table';

  static final columnId = '_id';
  static final columnName = 'name';
  static final columnDepartment = 'department';

  static final results = 'results';
  static final id = '_id';
  static final columnFirstDepartmentName = 'firstDepartmentName';
  static final columnSecondDepartmentName = 'secondDepartmentName';
  static final columnThirdDepartmentName = 'thirdDepartmentName';
  static final columnFourthDepartmentName = 'fourthDepartmentName';
  static final columnFirstScore = 'firstScore';
  static final columnSecondScore = 'secondScore';
  static final columnData = 'data';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnName TEXT NOT NULL,
            $columnDepartment TEXT NOT NULL
          )
          ''');
    await db.execute('''
          CREATE TABLE $results (
            $id INTEGER PRIMARY KEY,
            $columnFirstDepartmentName TEXT NOT NULL,
            $columnSecondDepartmentName TEXT NOT NULL,
            $columnThirdDepartmentName TEXT,
            $columnFourthDepartmentName TEXT,
            $columnFirstScore INTEGER NOT NULL,
            $columnSecondScore INTEGER NOT NULL,
            $columnData  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
          )
    ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  Future<List<Map<String, dynamic>>> queryName() async {
    Database db = await instance.database;
    return await db.rawQuery("SELECT DISTINCT $columnName AS name FROM $table");
  }

  Future<List<Map<String, dynamic>>> queryDepartment() async {
    Database db = await instance.database;
    return await db.rawQuery("SELECT DISTINCT $columnDepartment AS department FROM $table");
  }

  //Methods for second table(results)
  Future<int> insertResults(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(results, row);
  }

  Future<List<Map<String, dynamic>>> queryAllRowsResults() async {
    Database db = await instance.database;
    return await db.query(results);
  }
}