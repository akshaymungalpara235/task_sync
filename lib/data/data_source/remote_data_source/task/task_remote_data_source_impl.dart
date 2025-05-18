import 'package:dio/dio.dart';
import 'package:task_sync/data/api/task/task_api.dart';
import 'package:task_sync/data/base/base_api/base_api.dart';
import 'package:task_sync/data/base/base_response/base_response.dart';
import 'package:task_sync/data/base/interceptor/app_interceptor.dart';
import 'package:task_sync/data/data_source/remote_data_source/task/task_remote_data_source.dart';
import 'package:task_sync/domain/entity/task.dart';

class TaskRemoteDataSourceImpl extends TaskRemoteDataSource {
  TaskRemoteDataSourceImpl._() {
    _dio = Dio();

    // TODO(Akshay): Replace respective Base Url with ''.
    _dio.options = BaseOptions(baseUrl: '');
    _dio.interceptors.add(AppInterceptor());
    _taskApi = TaskApi(_dio);
  }

  late final Dio _dio;
  late final TaskApi _taskApi;

  final _baseApi = BaseApi.instance;

  static final TaskRemoteDataSourceImpl instance = TaskRemoteDataSourceImpl._();

  @override
  Future<BaseResponse<Task>> createTask(Task task) async {
    return _baseApi.safeApiCall(() async {
      final response = await _taskApi.createTask(task.toTaskRemoteModel());
      return response.toTask();
    });
  }

  @override
  Future<BaseResponse<void>> deleteTask(String id) async {
    return _baseApi.safeApiCall(() async {
      await _taskApi.deleteTask(id);
      return null;
    });
  }

  @override
  Future<BaseResponse<List<Task>>> getAllTasks() async {
    return _baseApi.safeApiCall(() async {
      final response = await _taskApi.getAllTasks();
      final taskList = response.map((task) => task.toTask()).toList();
      return taskList;
    });
  }

  @override
  Future<BaseResponse<List<Task>>> getTasksByStatus(bool isCompleted) async {
    return _baseApi.safeApiCall(() async {
      final response = await _taskApi.getTasksByStatus(isCompleted);
      final taskList = response.map((task) => task.toTask()).toList();
      return taskList;
    });
  }

  @override
  Future<BaseResponse<void>> toggleTaskStatus(String id) async {
    return _baseApi.safeApiCall(() async {
      await _taskApi.toggleTaskStatus(id);
      return null;
    });
  }

  @override
  Future<BaseResponse<Task>> updateTask(Task task) async {
    return _baseApi.safeApiCall(() async {
      final response = await _taskApi.updateTask(task.toTaskRemoteModel());
      return response.toTask();
    });
  }
}
