import 'package:dio/dio.dart';
import 'package:task_sync/data/base/base_exception/base_exception.dart';
import 'package:task_sync/data/exception/dio_exception/exceptions/bad_response_exception.dart';
import 'package:task_sync/data/exception/dio_exception/exceptions/cancel_exception.dart';
import 'package:task_sync/data/exception/dio_exception/exceptions/connection_timeout_exception.dart';
import 'package:task_sync/data/exception/dio_exception/exceptions/receive_timeout_exception.dart';
import 'package:task_sync/data/exception/dio_exception/exceptions/send_timeout_exception.dart';
import 'package:task_sync/utils/app_constants/app_constants.dart';
import 'package:task_sync/utils/app_strings/app_strings.dart';

class NetworkExceptionHandler {
  static BaseException handle(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return ConnectionTimeOutException(
          AppStrings.connectionTimeOutMessage,
          code: 408,
        );
      case DioExceptionType.sendTimeout:
        return SendTimeOutException(
          AppStrings.sendTimeOutMessage,
          code: 408,
        );
      case DioExceptionType.receiveTimeout:
        return ReceiveTimeOutException(
          AppStrings.receiveTimeOutMessage,
          code: 408,
        );
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final message = error.response?.data[AppConstants.message] ??
            AppStrings.unknownErrorMessage;
        return BadResponseException(message, code: statusCode);
      case DioExceptionType.cancel:
        return CancelException(
          AppStrings.requestCancelledMessage,
          code: 499,
        );
      case DioExceptionType.unknown:
      default:
        return BaseException(
          AppStrings.unexpectedErrorOccurredMessage,
          code: 500,
        );
    }
  }
}
