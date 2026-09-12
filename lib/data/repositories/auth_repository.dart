import '../../models/login_model.dart';
import '../datasources/auth_local_data_source.dart';
import '../datasources/auth_remote_data_source.dart';

abstract class AuthRepository {
  Future<String> login(LoginModel loginModel);
  Future<void> logout();
  String? getSavedToken();
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<String> login(LoginModel loginModel) async {
    final token = await remoteDataSource.login(
      email: loginModel.email ?? '',
      password: loginModel.password ?? '',
    );

    if (token == null || token.isEmpty) {
      throw Exception('Failed to receive a valid token from the server');
    }
    await localDataSource.saveToken(token);
    return token;
  }

  @override
  Future<void> logout() async {
    try {
      await remoteDataSource.logout();
    } finally {
      await localDataSource.clearToken();
    }
  }

  @override
  String? getSavedToken() => localDataSource.getToken();
}