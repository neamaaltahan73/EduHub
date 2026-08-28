
import 'package:flutter/material.dart';
import '../../models/instructor_model.dart';
import '../colors/app_colors.dart';

class InstructorAvatar extends StatelessWidget {
  final InstructorModel instructor;

  const InstructorAvatar({super.key, required this.instructor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(instructor.image),
          ),
          const SizedBox(height: 6),
          Text(
            instructor.name,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),
          Text(
            instructor.specialty,
            style: const TextStyle(fontSize: 10, color: AppColors.textGrey),
          ),
        ],
      ),
    );
  }
}
