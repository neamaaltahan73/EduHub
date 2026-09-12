import 'dart:convert';
import 'package:flutter/material.dart';

class CourseModel {
  final int id;
  final String image;
  final String category;
  final String title;
  final String instructor;
  final double rating;
  final int enrolledStudents;
  final double price;
  final double? oldPrice;
  final String? badge;
  final Color? badgeColor;
  final String? durationLabel;
  final String? description;
  final List<String> whatYouWillLearn;
  final String? lastUpdated;
  final List<CourseReviewModel> reviews;

  CourseModel({
    this.id = -1,
    required this.image,
    required this.category,
    required this.title,
    required this.instructor,
    required this.rating,
    this.enrolledStudents = 0,
    required this.price,
    this.oldPrice,
    this.badge,
    this.badgeColor,
    this.durationLabel,
    this.description,
    this.whatYouWillLearn = const [],
    this.lastUpdated,
    this.reviews = const [],
  });

  String get studentsLabel {
    if (enrolledStudents >= 1000) {
      return '${(enrolledStudents / 1000).toStringAsFixed(1)}k students';
    }
    return '$enrolledStudents students';
  }

  CourseModel copyWith({
    int? id,
    String? image,
    String? category,
    String? title,
    String? instructor,
    double? rating,
    int? enrolledStudents,
    double? price,
    double? oldPrice,
    String? badge,
    Color? badgeColor,
    String? durationLabel,
    String? description,
    List<String>? whatYouWillLearn,
    String? lastUpdated,
    List<CourseReviewModel>? reviews,
  }) => CourseModel(
    id: id ?? this.id,
    image: image ?? this.image,
    category: category ?? this.category,
    title: title ?? this.title,
    instructor: instructor ?? this.instructor,
    rating: rating ?? this.rating,
    enrolledStudents: enrolledStudents ?? this.enrolledStudents,
    price: price ?? this.price,
    oldPrice: oldPrice ?? this.oldPrice,
    badge: badge ?? this.badge,
    badgeColor: badgeColor ?? this.badgeColor,
    durationLabel: durationLabel ?? this.durationLabel,
    description: description ?? this.description,
    whatYouWillLearn: whatYouWillLearn ?? this.whatYouWillLearn,
    lastUpdated: lastUpdated ?? this.lastUpdated,
    reviews: reviews ?? this.reviews,
  );

  factory CourseModel.fromMap(Map<String, dynamic> json) => CourseModel(
    id: json["id"],
    image: json["image"],
    category: json["category"],
    title: json["name"],
    instructor: json["instructor_name"],
    rating: (json["rating"] as num).toDouble(),
    enrolledStudents: json["enrolled_students"] ?? 0,
    price: (json["price"] as num).toDouble(),
    description: json["description"],
    whatYouWillLearn: json["what_you_will_learn"] == null
        ? []
        : List<String>.from(json["what_you_will_learn"].map((x) => x)),
    lastUpdated: json["last_updated"],
    reviews: json["reviews"] == null
        ? []
        : List<CourseReviewModel>.from(
            json["reviews"].map((x) => CourseReviewModel.fromMap(x)),
          ),
  );

  factory CourseModel.fromJson(String str) =>
      CourseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": title,
    "description": description,
    "category": category,
    "instructor_name": instructor,
    "price": price,
    "image": image,
    "enrolled_students": enrolledStudents,
    "rating": rating,
    "what_you_will_learn": List<dynamic>.from(whatYouWillLearn.map((x) => x)),
    "last_updated": lastUpdated,
    "reviews": List<dynamic>.from(reviews.map((x) => x.toMap())),
  };
}

class CourseReviewModel {
  final String reviewerName;
  final String reviewDate;
  final String reviewContent;

  CourseReviewModel({
    required this.reviewerName,
    required this.reviewDate,
    required this.reviewContent,
  });

  CourseReviewModel copyWith({
    String? reviewerName,
    String? reviewDate,
    String? reviewContent,
  }) => CourseReviewModel(
    reviewerName: reviewerName ?? this.reviewerName,
    reviewDate: reviewDate ?? this.reviewDate,
    reviewContent: reviewContent ?? this.reviewContent,
  );

  factory CourseReviewModel.fromJson(String str) =>
      CourseReviewModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CourseReviewModel.fromMap(Map<String, dynamic> json) =>
      CourseReviewModel(
        reviewerName: json["reviewer_name"],
        reviewDate: json["review_date"],
        reviewContent: json["review_content"],
      );

  Map<String, dynamic> toMap() => {
    "reviewer_name": reviewerName,
    "review_date": reviewDate,
    "review_content": reviewContent,
  };
}
