import 'package:sqflite/sqflite.dart';
import 'package:task_sync/data/data_source/local_data_source/task/task_local_data_source.dart';
import 'package:task_sync/data/database/database_helper.dart';
import 'package:task_sync/data/model/local/task/task_local_model.dart';
import 'package:task_sync/domain/entity/task.dart';
import 'package:task_sync/utils/app_constants/app_constants.dart';
import 'package:uuid/uuid.dart';

class TaskLocalDataSourceImpl implements TaskLocalDataSource {
  TaskLocalDataSourceImpl._();

  static final TaskLocalDataSourceImpl instance = TaskLocalDataSourceImpl._();

  final _dbHelper = DatabaseHelper.instance;
  final _uuid = const Uuid();

  @override
  Future<List<TaskLocalModel>> getAllTasks() async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(AppConstants.dbName);
    return List.generate(maps.length, (i) {
      return TaskLocalModel.fromJson(maps[i]);
    });
  }

  @override
  Future<List<TaskLocalModel>> getTasksByStatus(bool isCompleted) async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      AppConstants.dbName,
      where: AppConstants.whereIsCompleted,
      whereArgs: [isCompleted ? 1 : 0],
    );
    return List.generate(maps.length, (i) {
      return TaskLocalModel.fromJson(maps[i]);
    });
  }

  @override
  Future<TaskLocalModel> createTask(Task task) async {
    final db = await _dbHelper.database;
    final newTask = task.copyWith(
      id: _uuid.v4(),
      createdAt: DateTime.now(),
    );

    await db.insert(
      AppConstants.dbName,
      newTask.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return newTask.toTaskLocalModel();
  }

  @override
  Future<TaskLocalModel> updateTask(Task task) async {
    final db = await _dbHelper.database;
    await db.update(
      AppConstants.dbName,
      task.toJson(),
      where: AppConstants.whereId,
      whereArgs: [task.id],
    );
    return task.toTaskLocalModel();
  }

  @override
  Future<void> deleteTask(String id) async {
    final db = await _dbHelper.database;
    await db.delete(
      AppConstants.dbName,
      where: AppConstants.whereId,
      whereArgs: [id],
    );
  }

  @override
  Future<void> toggleTaskStatus(String id) async {
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      AppConstants.dbName,
      where: AppConstants.whereId,
      whereArgs: [id],
    );
    
    if (maps.isNotEmpty) {
      final currentStatus = maps[0][AppConstants.isCompleted] as int;
      await db.update(
        AppConstants.dbName,
        {AppConstants.isCompleted: currentStatus == 1 ? 0 : 1},
        where: AppConstants.whereId,
        whereArgs: [id],
      );
    }
  }

  @override
  Future<List<TaskLocalModel>> createTaskList(List<Task> taskList) async {
    final db = await _dbHelper.database;
    final batch = db.batch();
    
    for (var task in taskList) {
      final taskToSave = task.copyWith(
        id: task.id.isEmpty ? _uuid.v4() : task.id,
      );
      
      batch.insert(
        AppConstants.dbName,
        taskToSave.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    
    await batch.commit();
    return taskList.map((task) => task.toTaskLocalModel()).toList();
  }
}
