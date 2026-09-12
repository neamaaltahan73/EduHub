import 'dart:convert';

class UserProfileModel {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String city;
  final String country;
  final String avatarUrl;

  UserProfileModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.city,
    required this.country,
    required this.avatarUrl,
  });

  String get fullName => '$firstName $lastName'.trim();

  String get location => [city, country].where((s) => s.isNotEmpty).join(', ');

  UserProfileModel copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? email,
    String? city,
    String? country,
    String? avatarUrl,
  }) => UserProfileModel(
    id: id ?? this.id,
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    email: email ?? this.email,
    city: city ?? this.city,
    country: country ?? this.country,
    avatarUrl: avatarUrl ?? this.avatarUrl,
  );

  factory UserProfileModel.fromMap(Map<String, dynamic> json) =>
      UserProfileModel(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        city: json["city"],
        country: json["country"],
        avatarUrl: json["profile_image"],
      );

  factory UserProfileModel.fromJson(String str) =>
      UserProfileModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "city": city,
    "country": country,
    "profile_image": avatarUrl,
  };
}
