import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naturly/src/core/common/router/router.gr.dart';
import 'package:naturly/src/core/widget/alert_snackbar.dart';
import 'package:naturly/src/feature/account/presentation/bloc/account_bloc.dart';
import 'package:naturly/src/feature/account/presentation/widgets/registration_screen.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    context.read<AccountBloc>().add(InitialEvent());
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
    return BlocListener<AccountBloc, AccountState>(
      listener: (context, state) {
        if (state is AccountAuthorized || state is AccountFailure) {
          state is AccountFailure
              ? showCustomSnackBar(context, state.message)
              : null;
        }
      },
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal:
                MediaQuery.sizeOf(context).width > 600
                    ? MediaQuery.sizeOf(context).width * 0.3
                    : MediaQuery.sizeOf(context).width * 0.1,
          ),
          child: BlocBuilder<AccountBloc, AccountState>(
            builder: (context, state) {
              if (state is AccountAuthorized) {
                Future.microtask(() {
                  context.router.pushAndPopUntil(
                    HomeTab(),
                    predicate: (route) => false,
                  );
                });
                return SizedBox.shrink();
              } else {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Log in'),
                      TextField(controller: emailController),
                      SizedBox(height: 15),
                      TextField(controller: passwordController),
                      Row(
                        children: [
                          Text('Don\'t have an account?'),
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
                            child: Text('Register'),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed:
                            () => context.read<AccountBloc>().add(
                              AccountSingInEvent(
                                email: emailController.text,
                                password: passwordController.text,
                              ),
                            ),
                        child: Text('Log in'),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
