import 'package:task_sync/data/base/base_exception/base_exception.dart';

class UnknownException extends BaseException {
  UnknownException(super.message);

  @override
  String toString() => 'UnknownException(code: $code, message: $message)';
}
