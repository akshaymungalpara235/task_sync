import 'package:dio/dio.dart';
import 'package:task_sync/data/base/base_response/base_response.dart';
import 'package:task_sync/data/exception/dio_exception/dio_exception_handler.dart';
import 'package:task_sync/utils/app_strings/app_strings.dart';

class BaseApi {
  BaseApi._();

  static BaseApi instance = BaseApi._();

  Future<BaseResponse<T>> safeApiCall<T>(Function() call) async {
    try {
      final response = await call();
      return BaseResponse.success(response);
    } on DioException catch (dioError) {
      final exception = NetworkExceptionHandler.handle(dioError);
      return BaseResponse.error(exception.message, statusCode: exception.code);
    } catch (e) {
      return BaseResponse.error(
        AppStrings.unexpectedErrorMessage,
        statusCode: 500,
      );
    }
  }
}
