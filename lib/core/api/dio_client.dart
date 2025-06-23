import 'package:dio/dio.dart';
import 'package:dio_http_formatter/dio_http_formatter.dart';
import 'package:mood_tune/core/api/api_constant.dart';

class DioClientService {
  final Dio dio;

  DioClientService()
    : dio = Dio(
        BaseOptions(
          baseUrl: ApiConstant.baseUrl,
          connectTimeout: const Duration(seconds: 60),
          receiveTimeout: const Duration(seconds: 60),
          headers: {'Accept': 'application/json'},
        ),
      ) {
    dio.interceptors.add(
      HttpFormatter(loggingFilter: (request, response, error) => true),
    );
    dio.interceptors.add(
      InterceptorsWrapper(
        onResponse: (response, handler) {
          print(response.data);
          print(response.headers);

          handler.next(response);
        },

        onRequest: (options, handler) {
          print(options.data);
          print(options.uri);
          print(options.headers);
          handler.next(options);
        },
      ),
    );
  }
  //dio  interceptor
}
