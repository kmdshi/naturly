import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naturly/src/feature/account/presentation/bloc/account_bloc.dart';
import 'package:naturly/src/feature/account/presentation/widgets/registration_screen.dart';
import 'package:naturly/src/feature/account/presentation/widgets/text_input_wrapper.dart';

class LoginScreenMobile extends StatefulWidget {
  const LoginScreenMobile({super.key});

  @override
  State<LoginScreenMobile> createState() => _LoginScreenMobileState();
}

class _LoginScreenMobileState extends State<LoginScreenMobile> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Image.asset(
                'assets/icons/logo.png',
                width: 250,
                height: 250,
              ), // TODO: перенести в константы
              SizedBox(height: 15),
              const Text(
                'Log in to your account',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 36,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 7),

              Text(
                'Welcome back! Please enter your details.',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(height: 30),
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 400,
                  minHeight: 42,
                  maxHeight: 42,
                ),
                child: TextInputWrapper(
                  controller: emailController,
                  hintText: 'Enter your email',
                ),
              ),
              SizedBox(height: 15),
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 400,
                  minHeight: 42,
                  maxHeight: 42,
                ),
                child: TextInputWrapper(
                  controller: passwordController,
                  hintText: 'Enter your password',
                ),
              ),
              SizedBox(height: 15),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: 400,
                  minWidth: 400,
                  minHeight: 40,
                  maxHeight: 40,
                ),
                child: ElevatedButton(
                  onPressed:
                      () => context.read<AccountBloc>().add(
                        AccountLogInEvent(
                          email: emailController.text,
                          password: passwordController.text,
                        ),
                      ),
                  child: const Text(
                    'Login',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                  style: ButtonStyle(
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    backgroundColor: WidgetStatePropertyAll(Color(0xFF0062CC)),
                    foregroundColor: WidgetStatePropertyAll(Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account?',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                  TextButton(
                    onPressed:
                        () => Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (
                              context,
                              animation,
                              secondaryAnimation,
                            ) {
                              return RegistrationScreen();
                            },
                          ),
                        ),
                    style: ButtonStyle(
                      foregroundColor: WidgetStatePropertyAll(
                        Color(0xFF0062CC),
                      ),
                    ),
                    child: Text(
                      'Sign up',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
