import '../../models/user_profile_model.dart';
import '../datasources/profile_remote_data_source.dart';

abstract class ProfileRepository {
  Future<UserProfileModel> getProfile();
}

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl({required this.remoteDataSource});

  @override
  Future<UserProfileModel> getProfile() async {
    return await remoteDataSource.fetchProfile();
  }
}