import 'package:task_sync/data/data_source/local_data_source/task/task_local_data_source.dart';
import 'package:task_sync/data/data_source/local_data_source/task/task_local_data_source_impl.dart';
import 'package:task_sync/data/data_source/remote_data_source/task/task_remote_data_source.dart';
import 'package:task_sync/data/data_source/remote_data_source/task/task_remote_data_source_impl.dart';
import 'package:task_sync/domain/entity/task.dart';

import '../../domain/repositories/task_repository.dart';

// TODO(Akshay): All the implementation will be conditional and based on the requirements.
class TaskRepositoryImpl implements TaskRepository {
  TaskRepositoryImpl._();

  static TaskRepositoryImpl instance = TaskRepositoryImpl._();

  final TaskLocalDataSource _localDataSource = TaskLocalDataSourceImpl.instance;
  final TaskRemoteDataSource _remoteDataSource =
      TaskRemoteDataSourceImpl.instance;

  @override
  Future<Task> createTask(Task task) async {
    // TODO(Akshay): API will be conditional and will be based on the requirement.
    Task updatedTask;
    final response = await _remoteDataSource.createTask(task);
    if (response.isSuccess && response.data != null) {
      updatedTask = response.data!;
    } else {
      updatedTask = task;
    }
    final localTask = await _localDataSource.createTask(updatedTask);
    return localTask.toTask();
  }

  @override
  Future<void> deleteTask(String id) async {
    await _remoteDataSource.deleteTask(id);
    await _localDataSource.deleteTask(id);
  }

  @override
  Future<List<Task>> getAllTasks() async {
    final response = await _remoteDataSource.getAllTasks();
    if (response.isSuccess && response.data != null) {
      await _localDataSource.createTaskList(response.data!);
    }
    final localUpdatedTaskList = await _localDataSource.getAllTasks();
    return localUpdatedTaskList.map((task) => task.toTask()).toList();
  }

  @override
  Future<List<Task>> getTasksByStatus(bool isCompleted) async {
    final response = await _remoteDataSource.getTasksByStatus(isCompleted);
    if (response.isSuccess && response.data != null) {
      await _localDataSource.createTaskList(response.data!);
    }
    final localUpdatedTaskList =
        await _localDataSource.getTasksByStatus(isCompleted);
    return localUpdatedTaskList.map((task) => task.toTask()).toList();
  }

  @override
  Future<void> toggleTaskStatus(String id) async {
    await _remoteDataSource.toggleTaskStatus(id);
    await _localDataSource.toggleTaskStatus(id);
  }

  @override
  Future<Task> updateTask(Task task) async {
    // TODO(Akshay): API will be conditional and will be based on the requirement.
    Task updatedTask;
    final response = await _remoteDataSource.updateTask(task);
    if (response.isSuccess && response.data != null) {
      updatedTask = response.data!;
    } else {
      updatedTask = task;
    }
    final updatedLocalTask = await _localDataSource.updateTask(updatedTask);
    return updatedLocalTask.toTask();
  }
}
