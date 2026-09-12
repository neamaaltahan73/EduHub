import 'package:dio/dio.dart';
import '../../core/config/api_config.dart';
import '../../core/config/dio_client.dart';
import '../../models/user_profile_model.dart';

abstract class ProfileRemoteDataSource {
  Future<UserProfileModel> fetchProfile();
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final Dio _dio = DioClient.instance.dio;

  @override
  Future<UserProfileModel> fetchProfile() async {
    final response = await _dio.get(ApiConfig.profileEndpoint);
    final data = (response.data as Map<String, dynamic>)['data'] as Map<String, dynamic>?;
    if (data == null) {
      throw Exception('لم يتم استلام بيانات الملف الشخصي من السيرفر.');
    }
    return UserProfileModel.fromMap(data);
  }
}
