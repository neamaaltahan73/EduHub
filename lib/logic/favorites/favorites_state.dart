part of 'favorites_bloc.dart';

abstract class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object?> get props => [];
}

class FavoritesInitial extends FavoritesState {
  const FavoritesInitial();
}

class FavoritesLoading extends FavoritesState {
  const FavoritesLoading();
}

class FavoritesLoaded extends FavoritesState {
  final List<int> favoriteIds;
  final List<CourseModel> favoriteCourses;

  const FavoritesLoaded({
    required this.favoriteIds,
    required this.favoriteCourses,
  });

  bool isFavorite(int courseId) => favoriteIds.contains(courseId);

  @override
  List<Object?> get props => [favoriteIds, favoriteCourses];
}

class FavoritesError extends FavoritesState {
  final String message;

  const FavoritesError(this.message);

  @override
  List<Object?> get props => [message];
}
