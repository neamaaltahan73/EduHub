import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/courses_repository.dart';
import '../../models/course_model.dart';
part 'courses_event.dart';
part 'courses_state.dart';


class CoursesBloc extends Bloc<CoursesEvent, CoursesState> {
  final CoursesRepository coursesRepository;

  CoursesBloc({required this.coursesRepository}) : super(const CoursesInitial()) {
    
    on<FetchCoursesRequested>((event, emit) async {
      emit(const CoursesLoading());
      try {
        final courses = await coursesRepository.getCourses();
        emit(CoursesLoaded(courses));
      } on DioException catch (e) {
        emit(CoursesError(getErrorMessage(e)));
      } catch (e) {
        emit(CoursesError(e.toString()));
      }
    });

  }

  String getErrorMessage(DioException e) {
    if (e.type == DioExceptionType.connectionError) {
      return 'لا يوجد اتصال بالإنترنت.';
    }
    if (e.response?.statusCode == 401) {
      return 'انتهت صلاحية الجلسة، الرجاء تسجيل الدخول مجدداً.';
    }
    return 'حدث خطأ، حاول مجددًا.';
  }
}