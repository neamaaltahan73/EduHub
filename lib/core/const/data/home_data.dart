import '../../../models/continue_learning_model.dart';
import '../../../models/instructor_model.dart';

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
