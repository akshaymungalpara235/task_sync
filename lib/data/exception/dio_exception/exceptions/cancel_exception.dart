import 'package:task_sync/data/base/base_exception/base_exception.dart';

class CancelException extends BaseException {
  CancelException(super.message, {super.code});

  @override
  String toString() => 'CancelException(code: $code, message: $message)';
}
