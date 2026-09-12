import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/const/colors/app_colors.dart';
import '../core/const/widgets/app_network_image.dart';
import '../models/course_model.dart';
import '../logic/courses/courses_bloc.dart';
import 'course_details_screen.dart';

class ExploreCoursesScreen extends StatefulWidget {
  final String initialQuery;

  const ExploreCoursesScreen({super.key, this.initialQuery = ''});

  @override
  State<ExploreCoursesScreen> createState() => _ExploreCoursesScreenState();
}

class _ExploreCoursesScreenState extends State<ExploreCoursesScreen> {
  late final TextEditingController _searchController;
  String _query = '';

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.initialQuery);
    _query = widget.initialQuery;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<CourseModel> _filter(List<CourseModel> courses, String query) {
    if (query.trim().isEmpty) return courses;
    final q = query.toLowerCase();
    return courses
        .where(
          (course) =>
              course.title.toLowerCase().contains(q) ||
              course.instructor.toLowerCase().contains(q) ||
              course.category.toLowerCase().contains(q),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.textDark),
        title: const Text(
          'EduHub',
          style: TextStyle(
            color: AppColors.primaryBlue,
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.divider),
                ),
                child: TextField(
                  controller: _searchController,
                  autofocus: true,
                  onChanged: (value) => setState(() => _query = value),
                  decoration: InputDecoration(
                    icon: const Icon(Icons.search, color: AppColors.textGrey),
                    hintText: 'Search courses, skills ...',
                    hintStyle: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textGrey,
                    ),
                    border: InputBorder.none,
                    suffixIcon: _searchController.text.isEmpty
                        ? null
                        : IconButton(
                            icon: const Icon(
                              Icons.close,
                              size: 18,
                              color: AppColors.textGrey,
                            ),
                            onPressed: () {
                              _searchController.clear();
                              setState(() => _query = '');
                            },
                          ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<CoursesBloc, CoursesState>(
                builder: (context, state) {
                  if (state is CoursesLoading || state is CoursesInitial) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is CoursesError) {
                    return Center(
                      child: Text(
                        state.message,
                        style: const TextStyle(color: AppColors.textGrey),
                      ),
                    );
                  }

                  final allCourses = (state as CoursesLoaded).courses;
                  final results = _filter(allCourses, _query);

                  if (results.isEmpty) {
                    return const Center(
                      child: Text(
                        'No courses found',
                        style: TextStyle(color: AppColors.textGrey),
                      ),
                    );
                  }

                  return ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    itemCount: results.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final course = results[index];
                      return GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => CourseDetailsScreen(course: course),
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.cardBackground,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: AppColors.divider),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  AspectRatio(
                                    aspectRatio: 16 / 10,
                                    child: AppNetworkImage(url: course.image),
                                  ),
                                  if (course.badge != null)
                                    Positioned(
                                      top: 10,
                                      left: 10,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: course.badgeColor ??
                                              AppColors.primaryBlue,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Text(
                                          course.badge!,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(14),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      course.title,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.textDark,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      course.instructor,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: AppColors.textGrey,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Row(
                                      children: [
                                        const Icon(Icons.star,
                                            size: 15, color: AppColors.star),
                                        const SizedBox(width: 4),
                                        Text(
                                          '${course.rating}',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.textDark,
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          '(${course.studentsLabel})',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: AppColors.textGrey,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    const Divider(
                                        height: 1, color: AppColors.divider),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              '\$${course.price.toStringAsFixed(2)}',
                                              style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.primaryBlue,
                                              ),
                                            ),
                                            if (course.oldPrice != null) ...[
                                              const SizedBox(width: 6),
                                              Text(
                                                '\$${course.oldPrice!.toStringAsFixed(2)}',
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  color: AppColors.textGrey,
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                ),
                                              ),
                                            ],
                                          ],
                                        ),
                                        if (course.durationLabel != null)
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.access_time,
                                                size: 14,
                                                color: AppColors.textGrey,
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                course.durationLabel!,
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  color: AppColors.textGrey,
                                                ),
                                              ),
                                            ],
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}