import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/favorites_repository.dart';
import '../../models/course_model.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final FavoritesRepository favoritesRepository;

  FavoritesBloc({required this.favoritesRepository})
    : super(FavoritesInitial()) {
    on<LoadFavorites>((event, emit) async {
      emit(FavoritesLoading());
      try {
        final courses = await favoritesRepository.getFavoriteCourses();
        final ids = favoritesRepository.getFavoriteIds();
        emit(FavoritesLoaded(favoriteIds: ids, favoriteCourses: courses));
      } catch (e) {
        emit(FavoritesError('تعذر تحميل قائمة المفضلة.'));
      }
    });

    on<ToggleFavoriteRequested>((event, emit) async {
      try {
        await favoritesRepository.toggleFavorite(event.courseId);
        final courses = await favoritesRepository.getFavoriteCourses();
        final ids = favoritesRepository.getFavoriteIds();
        emit(FavoritesLoaded(favoriteIds: ids, favoriteCourses: courses));
      } catch (e) {
        emit(FavoritesError('تعذر تحديث المفضلة.'));
      }
    });
  }
}
