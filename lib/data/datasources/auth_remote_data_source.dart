import 'package:dio/dio.dart';
import '../../core/config/api_config.dart';
import '../../core/config/dio_client.dart';

abstract class AuthRemoteDataSource {
  Future<String?> login({required String email, required String password});
  Future<void> logout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio _dio = DioClient.instance.dio;

  @override
  Future<String?> login({required String email, required String password}) async {
    final response = await _dio.post(
      ApiConfig.loginEndpoint,
      data: {
        "email": email,
        "password": password,
      },
    );
    final data = response.data as Map<String, dynamic>;
    return data['token'] as String?;
  }

  @override
  Future<void> logout() async {
    await _dio.post(ApiConfig.logoutEndpoint);
  }
}
