import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:task_sync/utils/app_constants/app_constants.dart';

class AppInterceptor extends Interceptor {
  static const int _maxCharactersPerLine = 200;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final requestPath = '${options.baseUrl}${options.path}';
    final requestData = options.data;
    final requestHeaders = options.headers;

    requestHeaders[AppConstants.contentType] = AppConstants.applicationJson;

    if (kDebugMode) {
      _logRequest(requestPath, options.method, requestHeaders, requestData);
    }

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final requestPath = '${response.requestOptions.baseUrl}${response.requestOptions.path}';
    final statusCode = response.statusCode;
    final responseData = response.data;

    if (kDebugMode) {
      _logResponse(requestPath, statusCode, responseData);
    }

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final requestPath = '${err.requestOptions.baseUrl}${err.requestOptions.path}';
    final errorMessage = err.message;
    final errorResponse = err.response?.data;
    final statusCode = err.response?.statusCode;

    if (kDebugMode) {
      _logError(requestPath, statusCode, errorMessage, errorResponse);
    }

    // Handle specific error cases
    _handleErrorCases(err, handler);

    super.onError(err, handler);
  }

  void _logRequest(String path, String? method, Map<String, dynamic> headers, dynamic data) {
    debugPrint('┌------------------------------------------------------------------------------');
    debugPrint('| Request: $method $path');
    debugPrint('| Headers:');
    headers.forEach((key, value) {
      debugPrint('|\t$key: $value');
    });
    debugPrint('| Body:');
    _logData(data);
    debugPrint('└------------------------------------------------------------------------------');
  }

  void _logResponse(String path, int? statusCode, dynamic data) {
    debugPrint('┌------------------------------------------------------------------------------');
    debugPrint('| Response: $path');
    debugPrint('| Status Code: $statusCode');
    debugPrint('| Body:');
    _logData(data);
    debugPrint('└------------------------------------------------------------------------------');
  }

  void _logError(String path, int? statusCode, String? message, dynamic data) {
    debugPrint('┌------------------------------------------------------------------------------');
    debugPrint('| Error: $path');
    debugPrint('| Status Code: $statusCode');
    debugPrint('| Message: $message');
    if (data != null) {
      debugPrint('| Error Data:');
      _logData(data);
    }
    debugPrint('└------------------------------------------------------------------------------');
  }

  void _logData(dynamic data) {
    if (data == null) return;

    String prettyJson;
    if (data is String) {
      try {
        final object = json.decode(data);
        prettyJson = const JsonEncoder.withIndent('  ').convert(object);
      } catch (e) {
        prettyJson = data;
      }
    } else {
      prettyJson = const JsonEncoder.withIndent('  ').convert(data);
    }

    prettyJson.split('\n').forEach((line) {
      if (line.length > _maxCharactersPerLine) {
        final chunks = _splitIntoChunks(line, _maxCharactersPerLine);
        chunks.forEach((chunk) => debugPrint('|\t$chunk'));
      } else {
        debugPrint('|\t$line');
      }
    });
  }

  List<String> _splitIntoChunks(String text, int chunkSize) {
    final chunks = <String>[];
    for (var i = 0; i < text.length; i += chunkSize) {
      chunks.add(text.substring(i, i + chunkSize > text.length ? text.length : i + chunkSize));
    }
    return chunks;
  }
  void _handleErrorCases(DioException err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        // Handle timeout errors
        break;
      case DioExceptionType.badResponse:
        switch (err.response?.statusCode) {
          case 400:
            // Handle bad request
            break;
          case 401:
            // Handle unauthorized
            break;
          case 403:
            // Handle forbidden
            break;
          case 404:
            // Handle not found
            break;
          case 500:
            // Handle server error
            break;
        }
        break;
      case DioExceptionType.cancel:
        // Handle cancelled request
        break;
      default:
        // Handle other errors
        break;
    }
  }
}
