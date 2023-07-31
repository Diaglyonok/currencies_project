import 'package:dio/dio.dart';

class HttpClient {
  late Dio _dio;
  static final HttpClient _singleton = HttpClient._();

  factory HttpClient() {
    return _singleton;
  }

  Future<Response<T>> get<T>(String path, {Map<String, dynamic>? queryParameters}) {
    return _dio.get(path, queryParameters: queryParameters);
  }

  HttpClient._() {
    BaseOptions options = BaseOptions(
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(minutes: 1),
        receiveTimeout: const Duration(minutes: 1));

    _dio = Dio(options);
  }
}
