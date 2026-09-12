import '../../models/course_model.dart';
import '../datasources/courses_remote_data_source.dart';

abstract class CoursesRepository {
  Future<List<CourseModel>> getCourses();
}

class CoursesRepositoryImpl implements CoursesRepository {
  final CoursesRemoteDataSource remoteDataSource;

  CoursesRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<CourseModel>> getCourses() async {
    return await remoteDataSource.fetchCourses();
  }
}