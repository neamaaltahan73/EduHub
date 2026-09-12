import 'dart:convert';
class LoginModel {
  final String? email;
  final String? password;

  LoginModel({this.email, this.password});

  LoginModel copyWith({String? email, String? password}) => LoginModel(
    email: email ?? this.email,
    password: password ?? this.password,
  );

  factory LoginModel.fromJson(String str) =>
      LoginModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LoginModel.fromMap(Map<String, dynamic> json) =>
      LoginModel(email: json["email"], password: json["password"]);

  Map<String, dynamic> toMap() => {"email": email, "password": password};
}
