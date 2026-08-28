import '../../models/continue_learning_model.dart';
import '../../models/course_model.dart';
import '../../models/instructor_model.dart';

final List<ContinueLearningModel> continueLearningList = [
  const ContinueLearningModel(
    image: 'assets/Image Hero Area.png',
    title: 'Advanced UI Design Principles',
    subtitle: 'Lesson 12 of 20 · Visual Hierarchy',
    progress: 0.65,
  ),
  const ContinueLearningModel(
    image: 'assets/Image Hero Area.png',
    title: 'React Native Fundamentals',
    subtitle: 'Lesson 4 of 15 · Components',
    progress: 0.30,
  ),
];

final List<String> categoriesList = [
  'Development',
  'Business',
  'Design',
  'Marketing',
];

final List<CourseModel> popularCoursesList = [
  const CourseModel(
    image: 'assets/Image Hero Area.png',
    category: 'Development',
    title: 'Full-stack Web Dev Bootcamp 2024',
    instructor: 'By Dr. Angela Yu',
    rating: 4.8,
    studentsLabel: '10k students',
    price: 89.99,
  ),
  const CourseModel(
    image: 'assets/Image Hero Area.png',
    category: 'Marketing',
    title: 'Complete Digital Marketing Course',
    instructor: 'By Sarah J.',
    rating: 4.9,
    studentsLabel: '8k students',
    price: 64.99,
  ),
];

// "Recommended for You"
final List<CourseModel> recommendedCoursesList = [
  const CourseModel(
    image: 'assets/Image Hero Area.png',
    category: 'Design',
    title: 'UI/UX Masterclass: From Beginner to Pro',
    instructor: '',
    rating: 4.9,
    studentsLabel: '4k',
    price: 59.99,
  ),
  const CourseModel(
    image: 'assets/Image Hero Area.png',
    category: 'Development',
    title: 'Python for Machine Learning',
    instructor: '',
    rating: 4.9,
    studentsLabel: '22k',
    price: 99.99,
  ),
];

// "Top Instructors"
final List<InstructorModel> topInstructorsList = [
  const InstructorModel(
    image: 'assets/Image Hero Area.png',
    name: 'Dr. Angela Yu',
    specialty: 'Development',
  ),
  const InstructorModel(
    image: 'assets/Image Hero Area.png',
    name: 'Sarah J.',
    specialty: 'Marketing',
  ),
  const InstructorModel(
    image: 'assets/Image Hero Area.png',
    name: 'David Chen',
    specialty: 'Business',
  ),
];
