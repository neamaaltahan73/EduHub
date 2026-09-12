import '../../models/course_model.dart';
import '../datasources/cart_local_data_source.dart';
import 'courses_repository.dart';

abstract class CartRepository {
  List<int> getCartIds();
  Future<List<int>> addToCart(int courseId);
  Future<List<int>> removeFromCart(int courseId);
  Future<List<CourseModel>> getCartCourses();
}

class CartRepositoryImpl implements CartRepository {
  final CartLocalDataSource localDataSource;
  final CoursesRepository coursesRepository;

  CartRepositoryImpl({
    required this.localDataSource,
    required this.coursesRepository,
  });

  @override
  List<int> getCartIds() {
    return localDataSource.getCartIds();
  }

  @override
  Future<List<int>> addToCart(int courseId) async {
    return await localDataSource.addToCart(courseId);
  }

  @override
  Future<List<int>> removeFromCart(int courseId) async {
    return await localDataSource.removeFromCart(courseId);
  }

  @override
  Future<List<CourseModel>> getCartCourses() async {
    final ids = localDataSource.getCartIds();
    if (ids.isEmpty) return [];
    final allCourses = await coursesRepository.getCourses();
    return allCourses.where((course) => ids.contains(course.id)).toList();
  }
}