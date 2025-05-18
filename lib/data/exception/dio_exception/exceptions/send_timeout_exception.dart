import 'package:task_sync/data/base/base_exception/base_exception.dart';

class SendTimeOutException extends BaseException {
  SendTimeOutException(super.message, {super.code});

  @override
  String toString() => 'SendTimeOutException(code: $code, message: $message)';
}
