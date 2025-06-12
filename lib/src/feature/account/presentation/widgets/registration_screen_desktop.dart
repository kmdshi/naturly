import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naturly/src/feature/account/presentation/bloc/account_bloc.dart';
import 'package:naturly/src/feature/account/presentation/widgets/login_screen.dart';
import 'package:naturly/src/feature/account/presentation/widgets/logo_screen.dart';
import 'package:naturly/src/feature/account/presentation/widgets/text_input_wrapper.dart';

class RegistrationScreenDesktop extends StatefulWidget {
  const RegistrationScreenDesktop({super.key});

  @override
  State<RegistrationScreenDesktop> createState() =>
      _RegistrationScreenDesktopState();
}

class _RegistrationScreenDesktopState extends State<RegistrationScreenDesktop> {
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
    final screenWidth = MediaQuery.of(context).size.width;
    final halfWidth = screenWidth / 2;
    return Row(
      children: [
        SizedBox(
          width: halfWidth,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/icons/logo.png',
                  width: 250,
                  height: 250,
                ), // TODO: перенести в константы
                SizedBox(height: 15),
                const Text(
                  'Create an account',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 36,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 7),

                Text(
                  'Start your jounery with us.',
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

                SizedBox(height: 10),

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
                          AccountRegistrationEvent(
                            email: emailController.text,
                            password: passwordController.text,
                          ),
                        ),
                    child: const Text('Sign up'),
                    style: ButtonStyle(
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      backgroundColor: WidgetStatePropertyAll(
                        Color(0xFF0062CC),
                      ),
                      foregroundColor: WidgetStatePropertyAll(Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
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
                                return LoginScreen();
                              },
                            ),
                          ),
                      style: ButtonStyle(
                        foregroundColor: WidgetStatePropertyAll(
                          Color(0xFF0062CC),
                        ),
                      ),
                      child: Text(
                        'Log in',
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

        SizedBox(width: halfWidth, child: LogoScreen()),
      ],
    );
  }
}
