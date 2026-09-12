part of 'auth_bloc.dart';
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthCheckingSession extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final String token;

  AuthAuthenticated(this.token);
}

class AuthUnauthenticated extends AuthState {}

class AuthFailure extends AuthState {
  final String message;

  AuthFailure(this.message);
}