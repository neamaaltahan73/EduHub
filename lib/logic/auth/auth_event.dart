part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AppStarted extends AuthEvent {}

final class LoginRequested extends AuthEvent {
  final LoginModel loginModel;

  LoginRequested({required this.loginModel});
}

final class LogoutRequested extends AuthEvent {}
