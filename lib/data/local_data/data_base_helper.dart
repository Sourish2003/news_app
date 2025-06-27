import 'dart:developer';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _databaseVersion = 1;

  static const table = 'time_entries';

  static const columnId = '_id';
  static const columnStartTime = 'startTime';
  static const columnEndTime = 'endTime';
  static const columnActivity = 'activity';
  static const columnDuration = 'duration';
  static const columnMachineName = 'machineName';
  static const columnProjectName = 'projectName';

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    log("initializing database");
    var databasesPath = await getDatabasesPath();
    log("databases path: $databasesPath");
    String path = join(databasesPath, 'timeTracker.db');
    log("opening database");
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnStartTime TEXT NOT NULL,
        $columnEndTime TEXT NOT NULL,
        $columnActivity TEXT NOT NULL,
        $columnDuration TEXT NOT NULL,
        $columnMachineName TEXT NOT NULL,
        $columnProjectName TEXT NOT NULL
      )
    ''');
  }
}
