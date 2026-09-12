import '../../core/config/hive_config.dart';

abstract class AuthLocalDataSource {
  Future<void> saveToken(String token);
  String? getToken();
  Future<void> clearToken();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  @override
  Future<void> saveToken(String token) async {
    await HiveConfig.authBox.put(HiveConfig.tokenKey, token);
  }

  @override
  String? getToken() => HiveConfig.authBox.get(HiveConfig.tokenKey) as String?;

  @override
  Future<void> clearToken() async {
    await HiveConfig.authBox.delete(HiveConfig.tokenKey);
  }
}
