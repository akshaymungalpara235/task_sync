import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:task_sync/utils/app_constants/app_constants.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;
  static String _databaseName = 'tasks.db';

  DatabaseHelper._init();

  static void setDatabaseName(String name) {
    _databaseName = name;
    _database = null; // Force reinitialization with new name
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB(_databaseName);
    return _database!;
  }

  @visibleForTesting
  Future<Database> initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: createDB,
    );
  }

  @visibleForTesting
  Future<void> createDB(Database db, int version) async {
    await db.execute(AppConstants.taskTable);
  }

  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }
} 