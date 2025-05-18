import '../entity/task.dart';

abstract class TaskRepository {
  Future<List<Task>> getAllTasks();
  Future<List<Task>> getTasksByStatus(bool isCompleted);
  Future<Task> createTask(Task task);
  Future<Task> updateTask(Task task);
  Future<void> deleteTask(String id);
  Future<void> toggleTaskStatus(String id);
} 