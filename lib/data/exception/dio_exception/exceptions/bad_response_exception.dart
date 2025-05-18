import 'package:task_sync/data/base/base_exception/base_exception.dart';

class BadResponseException extends BaseException {
  BadResponseException(super.message, {super.code});

  @override
  String toString() => 'BadResponseException(code: $code, message: $message)';
}
