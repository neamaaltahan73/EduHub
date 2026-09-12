import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/config/hive_config.dart';
import 'data/datasources/auth_local_data_source.dart';
import 'data/datasources/auth_remote_data_source.dart';
import 'data/datasources/cart_local_data_source.dart';
import 'data/datasources/courses_remote_data_source.dart';
import 'data/datasources/favorites_local_data_source.dart';
import 'data/datasources/profile_remote_data_source.dart';
import 'data/repositories/auth_repository.dart';
import 'data/repositories/courses_repository.dart';
import 'data/repositories/profile_repository.dart';
import 'data/repositories/favorites_repository.dart';
import 'data/repositories/cart_repository.dart';
import 'logic/auth/auth_bloc.dart';
import 'logic/cart/cart_bloc.dart';
import 'logic/courses/courses_bloc.dart';
import 'logic/profile/profile_bloc.dart';
import 'logic/favorites/favorites_bloc.dart';
import 'screens/splash_screen.dart';
import 'screens/onboarding_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveConfig.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final GlobalKey<NavigatorState> _navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    final coursesRepository = CoursesRepositoryImpl(
      remoteDataSource: CoursesRemoteDataSourceImpl(),
    );

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (_) => AuthRepositoryImpl(
            remoteDataSource: AuthRemoteDataSourceImpl(),
            localDataSource: AuthLocalDataSourceImpl(),
          ),
        ),
        RepositoryProvider<CoursesRepository>(create: (_) => coursesRepository),
        RepositoryProvider<ProfileRepository>(
          create: (_) => ProfileRepositoryImpl(
            remoteDataSource: ProfileRemoteDataSourceImpl(),
          ),
        ),
        RepositoryProvider<FavoritesRepository>(
          create: (_) => FavoritesRepositoryImpl(
            localDataSource: FavoritesLocalDataSourceImpl(),
            coursesRepository: coursesRepository,
          ),
        ),
        RepositoryProvider<CartRepository>(
          create: (_) => CartRepositoryImpl(
            localDataSource: CartLocalDataSourceImpl(),
            coursesRepository: coursesRepository,
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) =>
                AuthBloc(authRepository: context.read<AuthRepository>())
                  ..add(AppStarted()),
          ),
          BlocProvider<CoursesBloc>(
            create: (context) => CoursesBloc(
              coursesRepository: context.read<CoursesRepository>(),
            ),
          ),
          BlocProvider<ProfileBloc>(
            create: (context) => ProfileBloc(
              profileRepository: context.read<ProfileRepository>(),
            ),
          ),
          BlocProvider<FavoritesBloc>(
            create: (context) => FavoritesBloc(
              favoritesRepository: context.read<FavoritesRepository>(),
            ),
          ),
          BlocProvider<CartBloc>(
            create: (context) =>
                CartBloc(cartRepository: context.read<CartRepository>()),
          ),
        ],
        child: Builder(
          builder: (context) {
            return BlocListener<AuthBloc, AuthState>(
              listenWhen: (previous, current) =>
                  previous is AuthAuthenticated &&
                  current is AuthUnauthenticated,
              listener: (context, state) {
                _navigatorKey.currentState?.pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const OnboardingScreen()),
                  (route) => false,
                );
              },
              child: MaterialApp(
                navigatorKey: _navigatorKey,
                debugShowCheckedModeBanner: false,
                title: 'EduHub',
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                  fontFamily: 'Roboto',
                ),
                home: const SplashScreen(),
              ),
            );
          },
        ),
      ),
    );
  }
}
