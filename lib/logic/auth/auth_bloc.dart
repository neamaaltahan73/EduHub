import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../core/config/dio_client.dart';
import '../../data/repositories/auth_repository.dart';
import '../../models/login_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    DioClient.instance.onUnauthorized = () => add(LogoutRequested());

    on<AppStarted>((event, emit) async {
      emit(AuthCheckingSession());
      final token = authRepository.getSavedToken();
      if (token != null && token.isNotEmpty) {
        try {
          emit(AuthAuthenticated(token));
        } catch (_) {
          await authRepository.logout();
          emit(AuthUnauthenticated());
        }
      } else {
        emit(AuthUnauthenticated());
      }
    });

    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final token = await authRepository.login(event.loginModel);
        emit(AuthAuthenticated(token));
      } on DioException catch (e) {
        emit(AuthFailure(getErrorMessage(e)));
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });

    on<LogoutRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        await authRepository.logout();
      } catch (_) {}
      emit(AuthUnauthenticated());
    });
  }

 String getErrorMessage(DioException e) {
  if (e.type == DioExceptionType.connectionError) {
    return 'لا يوجد اتصال بالإنترنت.';
  }
  if (e.response?.statusCode == 401) {
    return 'خطأ في البريد الإلكتروني أو كلمة المرور.';
  }
  return 'حدث خطأ، حاول مجددًا.';
}
}
