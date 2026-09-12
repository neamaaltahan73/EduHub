import 'package:dio/dio.dart';
import 'api_config.dart';
import 'hive_config.dart';

class DioClient {
  DioClient._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConfig.baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: const {'Content-Type': 'application/json'},
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = HiveConfig.authBox.get(HiveConfig.tokenKey) as String?;
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (error, handler) {
          if (error.response?.statusCode == 401) {
            onUnauthorized?.call();
          }
          return handler.next(error);
        },
      ),
    );
  }

  static final DioClient instance = DioClient._internal();

  late final Dio _dio;

  Dio get dio => _dio;

  void Function()? onUnauthorized;
}
