class CourseModel {
  final String image;
  final String category;
  final String title;
  final String instructor;
  final double rating;
  final String studentsLabel;
  final double price;
  final double? oldPrice;

  const CourseModel({
    required this.image,
    required this.category,
    required this.title,
    required this.instructor,
    required this.rating,
    required this.studentsLabel,
    required this.price,
    this.oldPrice,
  });
}
