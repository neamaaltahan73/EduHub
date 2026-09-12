import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../logic/auth/auth_bloc.dart';
import '../models/login_model.dart';
import 'home_screen.dart';

class EduHubLoginPage extends StatefulWidget {
  const EduHubLoginPage({super.key});

  @override
  State<EduHubLoginPage> createState() => _EduHubLoginPageState();
}

class _EduHubLoginPageState extends State<EduHubLoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthAuthenticated) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HomeDashboardScreen()),
                (route) => false,
              );
            } else if (state is AuthFailure) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (BuildContext context, AuthState state) {
            return Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: Image.asset(
                          'assets/Utilizing Material Symbol as instructed, representing academic rigor@3x.png',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(
                              child: Icon(Icons.broken_image, color: Colors.grey, size: 30),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'EduHub',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF111827),
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Welcome back. Please log in to your account.',
                      style: TextStyle(fontSize: 14, color: Color(0xFF6B7280)),
                    ),
                    const SizedBox(height: 24),

                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 16,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Email Address',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF374151),
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: email,
                            enabled: state is! AuthLoading,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: 'user@email.com',
                              hintStyle: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
                              prefixIcon: const Icon(Icons.mail_outline, color: Color(0xFF9CA3AF), size: 20),
                              contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(color: Color(0xFF2563EB)),
                              ),
                            ),
                          ),
                          const SizedBox(height: 18),

                          const Text(
                            'Password',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF374151),
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: password,
                            enabled: state is! AuthLoading,
                            obscureText: obscurePassword,
                            decoration: InputDecoration(
                              hintText: '••••••••',
                              hintStyle: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
                              prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFF9CA3AF), size: 20),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                                  color: const Color(0xFF9CA3AF),
                                  size: 20,
                                ),
                                onPressed: () => setState(() => obscurePassword = !obscurePassword),
                              ),
                              contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(color: Color(0xFF2563EB)),
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'بيانات تجريبية: user@email.com / user12345',
                            style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF)),
                          ),
                          const SizedBox(height: 18),

                          SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: state is! AuthLoading
                                ? ElevatedButton(
                                    onPressed: () {
                                      context.read<AuthBloc>().add(
                                        LoginRequested(
                                          loginModel: LoginModel(
                                            email: email.text.trim(),
                                            password: password.text,
                                          ),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF2563EB),
                                      foregroundColor: Colors.white,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: const [
                                        Text(
                                          'Login',
                                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(width: 8),
                                        Icon(Icons.arrow_forward, size: 18),
                                      ],
                                    ),
                                  )
                                : const CircularProgressIndicator(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}