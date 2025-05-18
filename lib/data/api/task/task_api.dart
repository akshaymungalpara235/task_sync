import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:task_sync/data/model/remote/task/task_remote_model.dart';
import 'package:task_sync/utils/app_constants/app_constants.dart';

part 'task_api.g.dart';

@RestApi()
abstract class TaskApi {
  factory TaskApi(Dio dio) = _TaskApi;

  @GET(AppConstants.taskEndPoint)
  Future<List<TaskRemoteModel>> getAllTasks();

  @GET(AppConstants.taskEndPoint)
  Future<List<TaskRemoteModel>> getTasksByStatus(
    @Query(AppConstants.isCompleted) bool isCompleted,
  );

  @POST(AppConstants.taskEndPoint)
  Future<TaskRemoteModel> createTask(@Body() TaskRemoteModel taskRemoteModel);

  @PUT(AppConstants.taskEndPoint)
  Future<TaskRemoteModel> updateTask(@Body() TaskRemoteModel taskRemoteModel);

  @DELETE(AppConstants.taskEndPoint)
  Future<void> deleteTask(@Path(AppConstants.id) String id);

  @GET(AppConstants.taskEndPoint)
  Future<void> toggleTaskStatus(@Path(AppConstants.id) String id);
}
