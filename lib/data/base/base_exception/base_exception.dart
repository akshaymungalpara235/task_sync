class BaseException implements Exception {
  final String message;
  final int? code;

  BaseException(this.message, {this.code});

  @override
  String toString() => 'BaseException(code: $code, message: $message)';
}