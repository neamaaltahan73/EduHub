

import 'package:flutter/material.dart';
import '../core/const/colors/app_colors.dart';
import '../core/const/data/home_data.dart';
import '../core/const/widgets/category_chip.dart';
import '../core/const/widgets/continue_learning_card.dart';
import '../core/const/widgets/course_card.dart';
import '../core/const/widgets/instructor_avatar.dart';
import '../core/const/widgets/section_header.dart';
import '../core/const/widgets/app_bottom_nav_bar.dart';
import 'course_details_screen.dart';

class HomeDashboardScreen extends StatefulWidget {
  const HomeDashboardScreen({super.key});

  @override
  State<HomeDashboardScreen> createState() => _HomeDashboardScreenState();
}

class _HomeDashboardScreenState extends State<HomeDashboardScreen> {
  int _currentIndex = 0;
  String _selectedCategory = 'Development';

  void _openCourseDetails() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const CourseDetailsScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Good morning,',
                      style: TextStyle(fontSize: 13, color: AppColors.textGrey),
                    ),
                    Text(
                      'Hello, Emma! 👋',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textDark,
                      ),
                    ),
                  ],
                ),
                const CircleAvatar(
                  radius: 22,
                  backgroundImage: AssetImage('assets/Image Hero Area.png'),
                ),
              ],
            ),
            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.divider),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.search, color: AppColors.textGrey),
                  hintText: 'Search for courses...',
                  hintStyle: TextStyle(fontSize: 13, color: AppColors.textGrey),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 24),

            SectionHeader(title: 'Continue Learning', onSeeAll: () {}),
            const SizedBox(height: 12),
            SizedBox(
              height: 175,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: continueLearningList.length,
                itemBuilder: (context, index) =>
                    ContinueLearningCard(data: continueLearningList[index]),
              ),
            ),
            const SizedBox(height: 24),

            const Text(
              'Categories',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categoriesList.length,
                itemBuilder: (context, index) {
                  final category = categoriesList[index];
                  return CategoryChip(
                    label: category,
                    isSelected: category == _selectedCategory,
                    onTap: () => setState(() => _selectedCategory = category),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),

            SectionHeader(title: 'Popular Courses', onSeeAll: () {}),
            const SizedBox(height: 12),
            SizedBox(
              height: 210,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: popularCoursesList.length,
                itemBuilder: (context, index) => CourseCard(
                  course: popularCoursesList[index],
                  showDetailsLink: true,
                  onTap: _openCourseDetails,
                ),
              ),
            ),
            const SizedBox(height: 24),

            const Text(
              'Recommended for You',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 210,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: recommendedCoursesList.length,
                itemBuilder: (context, index) => CourseCard(
                  course: recommendedCoursesList[index],
                  onTap: _openCourseDetails,
                ),
              ),
            ),
            const SizedBox(height: 24),

           
            const Text(
              'Top Instructors',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 90,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: topInstructorsList.length,
                itemBuilder: (context, index) =>
                    InstructorAvatar(instructor: topInstructorsList[index]),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}
