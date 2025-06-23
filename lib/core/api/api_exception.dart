import 'package:dio/dio.dart';

class ApiException implements Exception {
  final String msg;

  ApiException({required this.msg});

      factory ApiException.fromDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return ApiException(msg: "Connection time out");
      case DioExceptionType.sendTimeout:
        return ApiException(msg: "Send timeout");
      case DioExceptionType.receiveTimeout:
        return ApiException(msg: "Receive timeout");
      case DioExceptionType.badResponse:
        return ApiException(
          msg: "Invalid response: ${error.response?.statusCode}",
        );
      case DioExceptionType.cancel:
        return ApiException(msg: "Request cancelled");
      case DioExceptionType.unknown:
      default:
        return ApiException(msg: "Unexpected error: ${error.message}");
    }
  }
}
