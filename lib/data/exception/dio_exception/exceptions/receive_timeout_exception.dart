import 'package:task_sync/data/base/base_exception/base_exception.dart';

class ReceiveTimeOutException extends BaseException {
  ReceiveTimeOutException(super.message, {super.code});

  @override
  String toString() =>
      'ReceiveTimeOutException(code: $code, message: $message)';
}
