import 'package:task_sync/data/base/base_response/base_response.dart';
import 'package:task_sync/domain/entity/task.dart';

abstract class TaskRemoteDataSource {
  Future<BaseResponse<List<Task>>> getAllTasks();

  Future<BaseResponse<List<Task>>> getTasksByStatus(bool isCompleted);

  Future<BaseResponse<Task>> createTask(Task task);

  Future<BaseResponse<Task>> updateTask(Task task);

  Future<BaseResponse<void>> deleteTask(String id);

  Future<BaseResponse<void>> toggleTaskStatus(String id);
}
