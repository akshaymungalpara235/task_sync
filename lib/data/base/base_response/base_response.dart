class BaseResponse<T> {
  final T? data;
  final String? message;
  final int? statusCode;
  final bool isSuccess;

  BaseResponse.success(this.data)
      : message = null,
        statusCode = 200,
        isSuccess = true;

  BaseResponse.error(this.message, {this.statusCode})
      : data = null,
        isSuccess = false;
}
