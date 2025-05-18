import 'package:task_sync/data/base/base_exception/base_exception.dart';

class ConnectionTimeOutException extends BaseException {
  ConnectionTimeOutException(super.message, {super.code});

  @override
  String toString() =>
      'ConnectionTimeOutException(code: $code, message: $message)';
}
