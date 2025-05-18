import 'package:task_sync/data/model/local/task/task_local_model.dart';
import 'package:task_sync/domain/entity/task.dart';

abstract class TaskLocalDataSource {
  Future<List<TaskLocalModel>> getAllTasks();
  Future<List<TaskLocalModel>> getTasksByStatus(bool isCompleted);
  Future<TaskLocalModel> createTask(Task task);
  Future<TaskLocalModel> updateTask(Task task);
  Future<void> deleteTask(String id);
  Future<void> toggleTaskStatus(String id);
  Future<List<TaskLocalModel>> createTaskList(List<Task> taskList);
}