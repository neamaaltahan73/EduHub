import '../../models/course_model.dart';
import '../datasources/favorites_local_data_source.dart';
import 'courses_repository.dart';

abstract class FavoritesRepository {
  List<int> getFavoriteIds();
  Future<List<int>> toggleFavorite(int courseId);
  Future<List<CourseModel>> getFavoriteCourses();
}

class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesLocalDataSource localDataSource;
  final CoursesRepository coursesRepository;

  FavoritesRepositoryImpl({
    required this.localDataSource,
    required this.coursesRepository,
  });

  @override
  List<int> getFavoriteIds() {
    return localDataSource.getFavoriteIds();
  }

  @override
  Future<List<int>> toggleFavorite(int courseId) async {
    return await localDataSource.toggleFavorite(courseId);
  }

  @override
  Future<List<CourseModel>> getFavoriteCourses() async {
    final ids = localDataSource.getFavoriteIds();
    if (ids.isEmpty) return [];
    final allCourses = await coursesRepository.getCourses();
    return allCourses.where((course) => ids.contains(course.id)).toList();
  }
}