import 'dart:io';
import 'package:dio/dio.dart';
import 'package:mood_tune/core/api/api_exception.dart';
import 'package:mood_tune/core/api/i_Api_service.dart';

class ApiService implements IApiService {
  final Dio _dio;

  ApiService(dioClient) : _dio = dioClient.dio;

  @override
  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      return response.data;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } catch (e) {
      throw Exception("Unknown Exception ${e.toString()}");
    }
  }

  @override
  Future<dynamic> post(String path, {data}) async {
    try {
      final response = await _dio.post(path, data: data);
      return response.data;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } on SocketException {
      throw SocketException("Network error please try again later");
    } catch (e) {
      throw Exception("Unknown Exception ${e.toString()}");
    }
  }

  @override
  Future<dynamic> put(String path, {data}) async {
    try {
      final response = await _dio.put(path, data: data);
      return response.data;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } on SocketException {
      throw SocketException("Network error please try again later");
    } catch (e) {
      throw Exception("Unknown Exception ${e.toString()}");
    }
  }

  @override
  Future<dynamic> delete(String path, {data}) async {
    try {
      final response = await _dio.delete(path, data: data);
      return response.data;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } on SocketException {
      throw SocketException("Network error please try again later");
    } catch (e) {
      throw Exception("Unknown Exception ${e.toString()}");
    }
  }

  // Download the file
  Future<dynamic> downLoadFile(String url, String filepath) async {
    try {
      final download = await _dio.download(url, filepath);
      return download;
    } catch (e) {
      throw Exception("Unknown Exception ${e.toString()}");
    }
  }
}
