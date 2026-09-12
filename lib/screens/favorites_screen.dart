import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/const/colors/app_colors.dart';
import '../core/const/widgets/favorite_course_card.dart';
import '../logic/favorites/favorites_bloc.dart';
import 'course_details_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: const Text(
          'EduHub',
          style: TextStyle(
            color: AppColors.primaryBlue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<FavoritesBloc, FavoritesState>(
          builder: (context, state) {
            if (state is FavoritesLoading || state is FavoritesInitial) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is FavoritesError) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: AppColors.textGrey),
                ),
              );
            }

            final favorites = (state as FavoritesLoaded).favoriteCourses;

            if (favorites.isEmpty) {
              return const Center(
                child: Text(
                  'No saved courses yet',
                  style: TextStyle(color: AppColors.textGrey),
                ),
              );
            }

            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const Text(
                  'Saved Courses',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 16),
                ...favorites.map(
                  (course) => FavoriteCourseCard(
                    course: course,
                    onRemoveFavorite: () => context.read<FavoritesBloc>().add(
                      ToggleFavoriteRequested(course.id),
                    ),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CourseDetailsScreen(course: course),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
