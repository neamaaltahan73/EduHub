part of 'favorites_bloc.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object?> get props => [];
}

class LoadFavorites extends FavoritesEvent {
  const LoadFavorites();
}

class ToggleFavoriteRequested extends FavoritesEvent {
  final int courseId;

  const ToggleFavoriteRequested(this.courseId);

  @override
  List<Object?> get props => [courseId];
}
