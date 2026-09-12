import 'package:dio/dio.dart';
import '../../core/config/api_config.dart';
import '../../core/config/dio_client.dart';
import '../../models/course_model.dart';

abstract class CoursesRemoteDataSource {
  Future<List<CourseModel>> fetchCourses();
}

class CoursesRemoteDataSourceImpl implements CoursesRemoteDataSource {
  final Dio _dio = DioClient.instance.dio;

  @override
  Future<List<CourseModel>> fetchCourses() async {
    final response = await _dio.get(ApiConfig.coursesEndpoint);
    final list = response.data['data'] as List;
    return list.map((item) => CourseModel.fromMap(item)).toList();
  }
}